# Transcription des vidéos

Claude ne lit pas la vidéo. Il faut une transcription texte par candidat. Ce document dit comment l'obtenir et quoi choisir.

---

## Local ou cloud

Les vidéos sont des données personnelles (`../../../shared/personal-data.md`). Les envoyer à un service de transcription externe est un transfert de données vers un sous-traitant : possible, mais il faut l'accord du recruteur, un sous-traitant couvert par le RGPD, et une mention dans l'information des candidats.

**Recommandation : local, avec Whisper.** Sur un Mac Apple Silicon, une vidéo de 3 minutes se transcrit en moins d'une minute avec `whisper.cpp` ou `mlx-whisper`, rien ne quitte la machine, et le français est bien géré par le modèle `large-v3` (ou `medium` si la machine peine).

Si le recruteur n'a pas la machine pour, l'alternative acceptable est un service dont le DPA couvre le RGPD, avec suppression après traitement ; le dire explicitement avant le premier envoi.

---

## Procédure locale (macOS, Apple Silicon)

**Pour le recruteur** : installation en une fois avec `scripts/setup.sh`, puis `transcrire <dossier>` à chaque vague. Tout est dans `../../../TOOLS.md`. Ce qui suit est le détail de ce que fait la commande, pour qui veut l'adapter.

Pour un dossier de vidéos téléchargé depuis `~~drive` dans un dossier vide dédié :

```bash
# 1. Extraire l'audio (mono, 16 kHz : ce que Whisper attend ; fichiers 50× plus petits)
for f in *.mp4 *.mov *.MOV; do
  [ -e "$f" ] || continue
  ffmpeg -nostdin -loglevel error -i "$f" -vn -ac 1 -ar 16000 "${f%.*}.wav"
done

# 2. Transcrire en français, sortie texte à côté
for w in *.wav; do
  mlx_whisper "$w" --model mlx-community/whisper-large-v3-mlx --language fr \
    --output-format txt --output-dir .
done
```

Avec `whisper.cpp` : `whisper-cli -m ~/.whisper/ggml-large-v3.bin -l fr -otxt -osrt -of "${w%.wav}" "$w"`.

Chaque `.txt` fait 350 à 500 mots pour 3 minutes. En dessous de 150, vérifier : audio coupé, langue mal détectée, silence long au début.

---

## Horodatage

Pour citer avec un repère temporel (« 1:12–1:40 »), demander la sortie `srt` ou `vtt` en plus du `txt` (`--output-format all`). Les citations horodatées rendent la vérification par le recruteur immédiate : il ouvre la vidéo à 1:12 au lieu de la regarder entière.

---

## Rangement

- La transcription porte **le même nom que la vidéo**, extension `.txt`, dans le **même dossier `~~drive`**. Mêmes droits d'accès, même durée de conservation.
- Les `.wav` intermédiaires sont supprimés après transcription : ils ne servent plus et doublent le volume de données personnelles.
- Le dossier local de travail est vidé une fois les transcriptions remontées dans `~~drive`. Rien ne reste sur le poste du recruteur.

---

## Ce que la transcription ne contient pas, volontairement

Pas d'analyse du ton de voix, pas de détection d'émotion, pas de description de l'image. L'AI Act interdit la reconnaissance d'émotions en contexte professionnel (art. 5), et la grille ne les nomme pas de toute façon. Si un outil de transcription propose ces options, les désactiver.

---

## Quand le candidat n'a pas pu envoyer de vidéo

Ce n'est pas un cas de transcription, c'est un cas `reply-drafter` : proposer une modalité adaptée (appel de 10 min, réponses écrites aux quatre questions). Les réponses écrites se notent exactement comme une transcription.
