#!/bin/bash
# Transcribe every video in a folder, locally, in French.
# Produces <video>.txt (plain text) and <video>.srt (timestamped) next to each video.
# Audio intermediates are deleted. Nothing leaves the machine.
#
# Usage:  transcrire <dossier>            # all videos in the folder
#         transcrire <dossier> --medium   # faster, slightly less accurate model
#
# Installed by setup.sh as ~/.local/bin/transcrire

set -euo pipefail

DIR="${1:-}"
MODEL="$HOME/.whisper/ggml-large-v3.bin"
[[ "${2:-}" == "--medium" ]] && MODEL="$HOME/.whisper/ggml-medium.bin"

if [[ -z "$DIR" || ! -d "$DIR" ]]; then
  echo "Usage : transcrire <dossier contenant les vidéos>"; exit 1
fi
for cmd in ffmpeg whisper-cli; do
  command -v "$cmd" >/dev/null 2>&1 || { echo "$cmd manquant : relancez setup.sh"; exit 1; }
done
if [[ ! -s "$MODEL" ]]; then
  echo "Modèle introuvable : $MODEL"
  echo "Relancez setup.sh (ou, pour --medium : curl -L -o ~/.whisper/ggml-medium.bin https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-medium.bin)"
  exit 1
fi

cd "$DIR"
shopt -s nullglob nocaseglob
videos=(*.mp4 *.mov *.m4v *.webm *.mkv *.avi)
shopt -u nocaseglob

if (( ${#videos[@]} == 0 )); then
  echo "Aucune vidéo trouvée dans $DIR"; exit 0
fi

done_count=0; skipped=0; failed=0
for v in "${videos[@]}"; do
  base="${v%.*}"
  if [[ -s "$base.txt" ]]; then
    echo "— déjà transcrit : $v"; ((skipped++)); continue
  fi
  echo "▶ $v"
  if ! ffmpeg -nostdin -loglevel error -y -i "$v" -vn -ac 1 -ar 16000 "$base.wav"; then
    echo "  ✗ extraction audio impossible"; ((failed++)); continue
  fi
  if whisper-cli -m "$MODEL" -l fr -otxt -osrt -of "$base" -np "$base.wav" >/dev/null 2>&1; then
    words=$(wc -w < "$base.txt" | tr -d ' ')
    if (( words < 150 )); then
      echo "  ⚠ transcription courte ($words mots) : vérifier la vidéo (son coupé ? silence ?)"
    else
      echo "  ✓ $words mots → $base.txt, $base.srt"
    fi
    ((done_count++))
  else
    echo "  ✗ transcription échouée"; ((failed++))
  fi
  rm -f "$base.wav"
done

printf '\n%d transcrite(s), %d déjà faite(s), %d en échec.\n' "$done_count" "$skipped" "$failed"
printf 'Remontez les .txt et .srt dans le même dossier Drive que les vidéos.\n'
