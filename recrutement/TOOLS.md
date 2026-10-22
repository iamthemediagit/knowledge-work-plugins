# Outillage

Ce qu'il faut installer pour que le plugin tourne en entier. Tout le reste (tableur, mail, agenda) passe par les connecteurs de `CONNECTORS.md`.

---

## Côté Claude

| Outil | Pourquoi | Installation |
|---|---|---|
| **Claude Cowork** (app desktop) ou **Claude Code** | Exécute le plugin | [claude.com](https://claude.com) ; Claude Code : `npm install -g @anthropic-ai/claude-code` |
| Connecteurs Gmail, Google Drive, Google Calendar | `~~email`, `~~drive`, `~~tracker`, `~~calendar` | Activés depuis Cowork (Connecteurs) ou lus dans `.mcp.json` par Claude Code ; authentification Google au premier appel |
| Le plugin | | `claude plugin marketplace add iamthemediagit/knowledge-work-plugins` puis `claude plugin install recrutement@knowledge-work-plugins` |

Sans connecteur, le plugin fonctionne avec un export `.xlsx` du tableur déposé dans la conversation et des emails collés.

---

## Côté machine du recruteur : transcription locale

Nécessaire pour `video-review` uniquement. Les vidéos ne quittent pas la machine (`shared/personal-data.md`).

### Prérequis

Mac Apple Silicon (M1 à M4) avec [Homebrew](https://brew.sh). Sur une autre machine, voir « Alternative » plus bas.

### Installation, une fois

```bash
# Homebrew si absent
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Extraction audio
brew install ffmpeg

# Transcription : option A, whisper.cpp (binaire natif, Homebrew)
brew install whisper-cpp
```

`whisper-cpp` installe la commande `whisper-cli` mais **pas de modèle**. Télécharger le modèle français une fois (environ 3 Go pour `large-v3`, 1,5 Go pour `medium`, suffisant pour une voix seule face caméra) :

```bash
mkdir -p ~/.whisper && cd ~/.whisper
curl -L -o ggml-large-v3.bin \
  https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-large-v3.bin
```

### Option B : mlx-whisper (Python, optimisé Apple Silicon)

Pour qui a déjà `uv` (stack Python). Plus rapide sur M3/M4, télécharge le modèle tout seul au premier lancement.

```bash
brew install uv            # si absent
uv tool install mlx-whisper
```

Les deux options donnent le même résultat ; l'option A ne dépend pas de Python, l'option B est plus rapide. Une seule suffit.

### Utilisation

Dans un dossier vide où les vidéos ont été téléchargées depuis Drive :

```bash
# 1. Audio mono 16 kHz
for f in *.mp4 *.mov *.MOV; do
  [ -e "$f" ] || continue
  ffmpeg -nostdin -loglevel error -i "$f" -vn -ac 1 -ar 16000 "${f%.*}.wav"
done

# 2a. whisper.cpp
for w in *.wav; do
  whisper-cli -m ~/.whisper/ggml-large-v3.bin -l fr -otxt -osrt -of "${w%.wav}" "$w"
done

# 2b. ou mlx-whisper
for w in *.wav; do
  mlx_whisper "$w" --model mlx-community/whisper-large-v3-mlx --language fr \
    --output-format all --output-dir .
done

# 3. Nettoyage : les .wav ne servent plus
rm -f *.wav
```

Résultat : un `.txt` (texte) et un `.srt` (horodaté, pour citer « 1:12–1:40 ») par vidéo, à remonter dans le même dossier Drive que les vidéos. Une vidéo de 3 minutes se transcrit en 20 à 60 secondes sur M4.

### Alternative sans Mac Apple Silicon

Sur Windows ou Linux : `whisper.cpp` se compile ou s'installe via les paquets de la distribution ; `faster-whisper` (Python, `uv tool install faster-whisper`) est l'équivalent de mlx-whisper. Sans machine assez puissante, un service cloud de transcription est possible **si** son contrat de sous-traitance couvre le RGPD et si la mention d'information des candidats le prévoit ; décision du recruteur, à écrire dans `shared/personal-data.md` du client.

---

## Ce qu'on n'installe pas

- Aucun outil d'analyse d'image, de voix ou d'émotion. Hors grille et interdit en contexte professionnel par l'AI Act (`shared/fair-screening.md`).
- Aucun ATS. Le tableur suffit à cette échelle ; en ajouter un, c'est un deuxième système à tenir à jour.

---

## Vérifier que tout est en place

```bash
ffmpeg -version | head -1
whisper-cli --help 2>&1 | head -1   # ou : mlx_whisper --help | head -1
ls -lh ~/.whisper/                  # le modèle, si option A
```

Puis, dans Claude : « où on en est ? » doit lire le tableur ; « évalue cette transcription » avec un `.txt` déposé doit produire des notes avec citations.
