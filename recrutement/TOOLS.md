# Outillage

Ce qu'il faut sur le Mac du recruteur pour que le plugin tourne en entier. Prévu pour quelqu'un qui n'ouvre pas le Terminal tous les jours : deux commandes à copier-coller, une seule fois.

---

## 1. Côté Claude

| Quoi | Pourquoi | Comment |
|---|---|---|
| **Claude Cowork** (app Mac) | Fait tourner le plugin | Télécharger sur [claude.com](https://claude.com), se connecter avec le compte maars |
| Connecteurs **Gmail**, **Google Drive**, **Google Calendar** | Lire les réponses des candidats, le tableur et les vidéos ; proposer des créneaux | Dans Cowork : Paramètres → Connecteurs → connecter les trois avec le compte Google de maars |
| Le plugin **Recrutement** | | Depuis Cowork : installer depuis la marketplace `iamthemediagit/knowledge-work-plugins`. En Claude Code : `claude plugin marketplace add iamthemediagit/knowledge-work-plugins` puis `claude plugin install recrutement@knowledge-work-plugins` |

Sans connecteur, tout fonctionne quand même en déposant un export `.xlsx` du tableur et en collant les emails dans la conversation ; les brouillons sont alors à envoyer à la main.

---

## 2. Côté Mac : transcrire les vidéos sans qu'elles quittent la machine

Nécessaire pour `video-review`. Claude ne regarde pas les vidéos ; il lit un texte. Ce texte est produit **sur le Mac**, par un modèle de reconnaissance vocale local (Whisper). Aucune vidéo de candidat n'est envoyée à un service externe (`shared/personal-data.md`).

Un Mac Studio ou n'importe quel Mac Apple Silicon (M1 à M4) fait ça en 20 à 60 secondes par vidéo de 3 minutes.

### Installation, une fois (10 minutes, dont le téléchargement)

1. Ouvrir **Terminal** (Cmd + Espace, taper `Terminal`, Entrée).
2. Copier-coller cette ligne et appuyer sur Entrée :

   ```bash
   bash "$(find ~ -path '*recrutement/scripts/setup.sh' -print -quit 2>/dev/null)"
   ```

   Si la ligne ne trouve pas le script (plugin installé ailleurs que dans le dossier personnel), glisser le fichier `scripts/setup.sh` dans la fenêtre du Terminal après avoir tapé `bash ` (avec un espace), puis Entrée.

3. Le script installe, dans l'ordre : Homebrew (le gestionnaire d'installation du Mac, s'il n'est pas déjà là ; il demande le mot de passe de session une fois), `ffmpeg`, `whisper.cpp`, le modèle de langue (3 Go, une seule fois), et la commande `transcrire`. Chaque étape affiche une coche verte. Relancer le script ne casse rien : ce qui est déjà fait est sauté.
4. Fermer le Terminal et le rouvrir.

### Utilisation, à chaque vague de vidéos

1. Télécharger les vidéos depuis le dossier Drive des candidats dans un dossier du Mac, par exemple `Téléchargements/videos-candidats`. Un dossier dédié, rien d'autre dedans.
2. Dans Terminal :

   ```bash
   transcrire ~/Downloads/videos-candidats
   ```

3. Pour chaque vidéo apparaît une ligne `✓ 412 mots → Prénom Nom.txt, Prénom Nom.srt`. Un `⚠ transcription courte` signale une vidéo à vérifier (son coupé, silence). Les vidéos déjà transcrites sont sautées.
4. Remonter les fichiers `.txt` et `.srt` dans le **même dossier Drive** que les vidéos. Supprimer le dossier local.
5. Dans Claude : « évalue les vidéos reçues ». `video-review` lit les transcriptions depuis Drive.

Le `.srt` sert à citer avec un repère temporel (« 1:12–1:40 ») : le recruteur ouvre la vidéo au bon moment au lieu de la regarder en entier.

### Si quelque chose bloque

| Message | Cause | Faire |
|---|---|---|
| `command not found: transcrire` | Terminal pas rouvert après l'installation | Fermer et rouvrir Terminal, ou taper `source ~/.zshrc` |
| `ffmpeg manquant` / `whisper-cli manquant` | Installation incomplète | Relancer `setup.sh` |
| `Modèle introuvable` | Téléchargement interrompu | Relancer `setup.sh` ; il reprend le téléchargement |
| `⚠ transcription courte` | Son absent ou vidéo tronquée | Ouvrir la vidéo ; si le son est bon, relancer avec `transcrire <dossier> --medium` après avoir supprimé le `.txt` |
| Très lent (plusieurs minutes par vidéo) | Mac Intel, ou autre tâche lourde en cours | Utiliser `--medium` (modèle plus léger, à télécharger une fois : commande affichée par le script) |

---

## 3. Ce qu'on n'installe pas

- **Aucun outil d'analyse d'image, de voix ou d'émotion.** Hors grille, et interdit en contexte professionnel par l'AI Act (`shared/fair-screening.md`). Le plugin travaille sur le texte.
- **Aucun ATS.** Le Google Sheet suffit à cette échelle ; un deuxième système serait un deuxième tableau à tenir à jour.
- **Aucun service de transcription en ligne**, sauf décision explicite du recruteur avec un sous-traitant couvert par le RGPD et une mention dans l'information des candidats.

---

## 4. Pour un développeur

Les scripts sont dans `scripts/` : `setup.sh` (idempotent, Homebrew + ffmpeg + whisper-cpp + modèle + lien dans `~/.local/bin`) et `transcrire.sh` (ffmpeg → wav mono 16 kHz → `whisper-cli -l fr -otxt -osrt`, nettoyage des wav). Alternative plus rapide sur M3/M4 pour qui a `uv` : `uv tool install mlx-whisper`, puis `mlx_whisper <wav> --model mlx-community/whisper-large-v3-mlx --language fr --output-format all`. Sous Linux/Windows : `whisper.cpp` compilé ou `faster-whisper`.
