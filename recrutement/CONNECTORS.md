# Connecteurs

## Comment les références aux outils fonctionnent

Les skills désignent les outils par catégorie avec le préfixe `~~` : `~~tracker`, `~~email`, `~~drive`, `~~calendar`. Le fichier `.mcp.json` pré-configure des serveurs MCP, mais n'importe quel outil de la même catégorie fonctionne.

Le plugin est **pensé pour une PME qui n'a pas d'ATS** : le système de référence est un tableur partagé (Google Sheet), pas un logiciel de recrutement. Tout ce que le plugin produit se retrouve dans ce tableur ou dans la boîte mail.

## Connecteurs de ce plugin

| Catégorie | Placeholder | Pré-configuré | Autres options |
|---|---|---|---|
| Suivi des candidatures | `~~tracker` | Google Sheets (via Google Drive) | Notion, ClickUp, Airtable, Excel dans M365 |
| Email | `~~email` | Gmail | Microsoft 365 |
| Stockage des fichiers (CV, vidéos) | `~~drive` | Google Drive | Microsoft 365, Dropbox, Box |
| Agenda | `~~calendar` | Google Calendar | Microsoft 365 |
| Transcription vidéo | — | Locale (Whisper via ffmpeg) | Voir `skills/video-review/reference/transcription.md` |

## Sans connecteur

Chaque skill fonctionne avec des fichiers déposés dans la conversation : export du tableur en `.xlsx`, transcriptions en `.txt`, emails collés. Les brouillons de réponse sont alors le livrable : le recruteur les envoie lui-même.

## Fonctionnement en mode « maars »

Chez maars, le `~~tracker` est le Google Sheet `PA RECRUITMENT …` (onglets Assessment candidats / Barème et méthode / Pilotage / Réponses / Relances). Le `~~drive` est le dossier partagé qui reçoit les vidéos, avec un sous-dossier `NEXT STEP -> LIVE ITW` pour les candidats retenus. Le schéma des colonnes est décrit dans `shared/tracker-schema.md`.
