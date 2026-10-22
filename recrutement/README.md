# Recrutement

Plugin de recrutement pour une PME française qui recrute sans ATS : un Google Sheet, une boîte Gmail, un dossier Drive de vidéos, et un dirigeant qui n'a pas le temps.

Construit à partir de `small-business/hiring-screener` (règles d'évaluation équitable, « rien ne part sans validation »), adapté au droit français, au RGPD, à l'AI Act, et au cas concret d'un recrutement par vidéo de présentation.

## Ce qu'il fait

| Skill | Ce qu'il produit | Déclencheur |
|---|---|---|
| `relance-tracker` | Le tableur à jour : vidéos reçues, réponses lues dans Gmail, écarts dossier/tableur, listes de relances horodatées | « où on en est », « qui a répondu », « mets à jour le tableau » |
| `video-review` | Une note par critère **avec citation** depuis la transcription, une bande (entretien / peut-être / non / non évaluable), proposition d'écriture dans les colonnes de notation | « évalue les vidéos », « shortlist », « qui on retient » |
| `reply-drafter` | Les emails aux candidats dans la voix de l'entreprise, depuis les modèles validés, groupés par lot, validation nominative avant envoi | « rédige les relances », « envoie les refus », « convoque » |
| `live-itw-prep` | Un kit d'entretien par candidat : ce que la vidéo a déjà prouvé, ce qui reste en tiret, les questions pour le trancher, la grille de notes ; consigne de démo pour les formateurs | « prépare l'entretien », « questions pour », « kit entretien » |
| `pipeline-report` | L'état du recrutement en une page : funnel, ce qui attend une décision du recruteur, ce qui glisse, hygiène RGPD, les trois actions de la semaine | « point recrutement », « qu'est-ce qui bloque », « rapport » |
| `job-post` | Le dossier d'ouverture d'un poste : fiche `positions/`, grille pondérée fixée **avant** la première candidature, annonce conforme (L1132-1, fourchette, mention IA/RGPD), structure du tableur | « on recrute un », « rédige l'annonce », « fiche de poste » |

## Comment il travaille

- **Le tableur est la source de vérité.** Aucun skill ne tient d'état parallèle. Schéma dans `shared/tracker-schema.md`.
- **Un poste = une fiche** dans `positions/` : grille pondérée, critères bloquants, questions posées aux candidats et, surtout, la table de correspondance questions → critères sans laquelle les notes vidéo sont arbitraires.
- **L'IA propose, l'humain décide.** Aucune note n'entre dans le tableur, aucun mail ne part, aucun statut ne passe à « Refusé » sans validation explicite du recruteur. C'est la règle du plugin, et c'est ce que l'AI Act exige d'un système de tri de candidats (haut risque, annexe III).
- **On note la transcription, pas l'image.** Ni apparence, ni accent, ni décor, ni qualité technique. Détail dans `shared/fair-screening.md`.
- **Les données personnelles restent dans le tableur et le Drive.** Jamais dans un rapport, un artefact ou ce dépôt. `shared/personal-data.md`.

## Installation

```bash
claude plugin marketplace add iamthemediagit/knowledge-work-plugins
claude plugin install recrutement@knowledge-work-plugins
```

Puis connecter Gmail, Google Drive et Google Calendar (voir `CONNECTORS.md`). Outils à installer sur la machine du recruteur (ffmpeg, Whisper) : `TOOLS.md`. Sans connecteur, chaque skill fonctionne avec un export `.xlsx` du tableur et les emails collés ; les brouillons sont alors le livrable.

## Transcription des vidéos

Claude ne regarde pas de vidéo. La transcription se fait en local sur le Mac du recruteur (ffmpeg + Whisper, moins d'une minute par vidéo, rien ne quitte la machine). Installation en une commande avec `scripts/setup.sh`, puis `transcrire <dossier>` à chaque vague. Installation dans `TOOLS.md`, procédure dans `skills/video-review/reference/transcription.md`.

## Adapter à un autre client

1. Copier `positions/_template.md`, remplir la grille et la table de correspondance avec le recruteur **avant** de lire la première candidature.
2. Reproduire le schéma du tableur (`shared/tracker-schema.md`) ou décrire le sien.
3. Coller trois emails du recruteur dans `shared/voice-profile.md`.
4. Reprendre les modèles de `skills/reply-drafter/reference/templates-fr.md` dans l'onglet Réponses du tableur.

## Structure

```
recrutement/
├── .claude-plugin/plugin.json
├── .mcp.json                      # Gmail, Google Drive, Google Calendar
├── CONNECTORS.md
├── TOOLS.md                       # installation côté Mac, dépannage
├── scripts/
│   ├── setup.sh                   # installe ffmpeg, whisper.cpp, le modèle, la commande transcrire
│   └── transcrire.sh              # transcrit un dossier de vidéos en .txt + .srt
├── positions/                     # une fiche par poste
│   ├── _template.md
│   ├── assistant-executif-maars.md
│   └── coach-ia-maars.md          # freelance, démo pédagogique
├── shared/                        # règles communes à tous les skills
│   ├── tracker-schema.md
│   ├── fair-screening.md          # L1132-1, AI Act, critères bloquants
│   ├── personal-data.md           # RGPD, CNIL 2 ans
│   ├── untrusted-content.md
│   └── voice-profile.md
└── skills/
    ├── relance-tracker/
    ├── video-review/
    │   └── reference/ transcription.md, scoring.md
    ├── reply-drafter/
    │   └── reference/ templates-fr.md
    ├── live-itw-prep/
    │   └── reference/ question-bank.md
    ├── pipeline-report/
    └── job-post/
        └── reference/ annonce.md
```
