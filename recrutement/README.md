# Recrutement

Plugin de recrutement pour une PME française qui recrute sans ATS : un Google Sheet, une boîte Gmail, un dossier Drive de vidéos, et un dirigeant qui n'a pas le temps.

Construit à partir de `small-business/hiring-screener` (règles d'évaluation équitable, « rien ne part sans validation »), adapté au droit français, au RGPD, à l'AI Act, et au cas concret d'un recrutement par vidéo de présentation.

## Ce qu'il fait

| Skill | Ce qu'il produit | Déclencheur |
|---|---|---|
| `relance-tracker` | Le tableur à jour : vidéos reçues, réponses lues dans Gmail, écarts dossier/tableur, listes de relances horodatées | « où on en est », « qui a répondu », « mets à jour le tableau » |
| `video-review` | Une note par critère **avec citation** depuis la transcription, une bande (entretien / peut-être / non / non évaluable), proposition d'écriture dans les colonnes de notation | « évalue les vidéos », « shortlist », « qui on retient » |
| `reply-drafter` | Les emails aux candidats dans la voix de l'entreprise, depuis les modèles validés, groupés par lot, validation nominative avant envoi | « rédige les relances », « envoie les refus », « convoque » |

À venir : `live-itw-prep` (questions d'entretien ciblées sur ce que la vidéo n'a pas montré), `job-post` (annonce + grille par poste), `pipeline-report` (l'onglet Pilotage, lu et commenté).

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

Puis connecter Gmail, Google Drive et Google Calendar (voir `CONNECTORS.md`). Sans connecteur, chaque skill fonctionne avec un export `.xlsx` du tableur et les emails collés ; les brouillons sont alors le livrable.

## Transcription des vidéos

Claude ne regarde pas de vidéo. La transcription se fait en local (ffmpeg + Whisper sur Mac Apple Silicon, moins d'une minute par vidéo, rien ne quitte la machine). Procédure dans `skills/video-review/reference/transcription.md`.

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
├── positions/                     # une fiche par poste
│   ├── _template.md
│   ├── assistant-executif-maars.md
│   └── coach-ia-maars.md          # brouillon
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
    └── reply-drafter/
        └── reference/ templates-fr.md
```
