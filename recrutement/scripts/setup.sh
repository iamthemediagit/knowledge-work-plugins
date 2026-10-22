#!/bin/bash
# One-time setup for local video transcription on a Mac (Apple Silicon).
# Installs Homebrew (if missing), ffmpeg, whisper.cpp, downloads the French-capable
# model, and puts the `transcrire` command on the PATH.
#
# Run from Terminal:  bash setup.sh
# Safe to re-run: every step is skipped when already done.

set -euo pipefail

MODEL_DIR="$HOME/.whisper"
MODEL_NAME="ggml-large-v3.bin"
MODEL_URL="https://huggingface.co/ggerganov/whisper.cpp/resolve/main/$MODEL_NAME"
BIN_DIR="$HOME/.local/bin"
HERE="$(cd "$(dirname "$0")" && pwd)"

step() { printf '\n\033[1m%s\033[0m\n' "$*"; }
ok()   { printf '  ✓ %s\n' "$*"; }

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "Ce script est prévu pour macOS. Voir TOOLS.md pour les autres systèmes."; exit 1
fi
if [[ "$(uname -m)" != "arm64" ]]; then
  echo "Mac Intel détecté : la transcription sera lente. Le script continue, mais préférez le modèle medium (voir TOOLS.md)."
fi

step "1/5  Homebrew"
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
ok "brew $(brew --version | head -1 | awk '{print $2}')"

step "2/5  ffmpeg (extraction audio)"
brew list ffmpeg >/dev/null 2>&1 || brew install ffmpeg
ok "$(ffmpeg -version | head -1 | awk '{print $1, $3}')"

step "3/5  whisper.cpp (transcription)"
brew list whisper-cpp >/dev/null 2>&1 || brew install whisper-cpp
ok "whisper-cli installé"

step "4/5  Modèle large-v3 (environ 3 Go, une seule fois)"
mkdir -p "$MODEL_DIR"
if [[ -s "$MODEL_DIR/$MODEL_NAME" ]]; then
  ok "déjà présent : $MODEL_DIR/$MODEL_NAME"
else
  echo "  téléchargement… (quelques minutes selon la connexion)"
  curl -L --progress-bar -o "$MODEL_DIR/$MODEL_NAME.part" "$MODEL_URL"
  mv "$MODEL_DIR/$MODEL_NAME.part" "$MODEL_DIR/$MODEL_NAME"
  ok "modèle téléchargé"
fi

step "5/5  Commande 'transcrire'"
mkdir -p "$BIN_DIR"
cp "$HERE/transcrire.sh" "$BIN_DIR/transcrire"
chmod +x "$BIN_DIR/transcrire"
SHELL_RC="$HOME/.zshrc"
if ! grep -q '\.local/bin' "$SHELL_RC" 2>/dev/null; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$SHELL_RC"
  echo "  PATH mis à jour dans $SHELL_RC (ouvrez un nouveau Terminal, ou tapez : source ~/.zshrc)"
fi
ok "transcrire → $BIN_DIR/transcrire"

printf '\n\033[1mTerminé.\033[0m Pour transcrire un dossier de vidéos :\n\n'
printf '    transcrire ~/Downloads/videos-candidats\n\n'
printf 'Chaque vidéo donne un .txt et un .srt à côté d'"'"'elle. Rien ne quitte cet ordinateur.\n'
