# Schéma du tableur de suivi

**Partagé par tous les skills.** Le tableur est le système de référence : chaque skill lit et écrit dedans, aucun ne tient un état parallèle. Si une information n'est pas dans le tableur, elle n'existe pas pour le prochain skill.

Le schéma ci-dessous est celui utilisé chez maars. Pour un autre client, reproduire la même logique : une ligne par candidat, des colonnes « preuves » que seul un humain ou un skill avec preuve remplit, un onglet barème, un onglet pilotage calculé.

---

## Onglet `Assessment candidats`

Une ligne par candidat unique (dédoublonné sur l'email).

| Groupe | Colonnes | Qui écrit |
|---|---|---|
| Identité | Rang initial, Prénom, Nom, Email, Mobile | Import initial. Jamais modifié par un skill |
| Pré-évaluation | Note CV initiale /10 | Import initial. **Indicative, ne sert pas au classement** |
| Grille métier (colonnes bleues) | Fiabilité, Anticipation, Imprévus, Communication & confidentialité, Autonomie & digital, Motivation durable, Coordination terrain — chacune /10 | `video-review` propose, le recruteur valide |
| Score métier /100 | Calculé : SOMMEPROD(notes × pondérations) / 10 | Formule. Vide tant qu'une note manque |
| Culture maars (5 piliers) | Mission, Autonomie, Action, Relations, Santé durable — chacune /10 | Recruteur après live ITW. `video-review` peut proposer si la vidéo donne des preuves |
| Culture /10, Évaluation consolidée /100, Rang assessment | Calculés : moyenne des piliers ; 75 % métier + 25 % culture | Formule |
| Critères bloquants | Permis B, Anglais professionnel, CDI temps plein, Présence 92 / mobilité, Salaire souhaité (€ brut/an) | `relance-tracker` depuis les réponses email ; valeurs `Oui` / `Non` / `À vérifier` |
| Suivi | Vidéo reçue, Statut, Prochaine étape, Prétentions salariales, Date entretien | `relance-tracker`, `reply-drafter` |
| Trace | Notes / preuves, Source / dossier | Tous les skills ajoutent, **en préfixant par la date** (`21/10/2026 — …`), jamais en écrasant |

### Valeurs de `Statut`

`À évaluer` → `Préqualification` (vidéo reçue, infos manquantes) → `À vérifier` (dossier complet, à noter) → `Shortlist` → `Entretien` → `Offre` → `Recruté`, ou `Refusé` à tout moment. `Sans réponse` quand la relance a expiré sans retour.

### Valeurs de `Vidéo reçue`

`Oui` / `Non vérifié` / `Modalité adaptée` (le candidat a signalé une difficulté et une alternative a été proposée).

---

## Onglet `Barème et méthode`

Source de vérité pour les pondérations. **Les skills lisent les pondérations ici, ne les codent jamais en dur.** Si l'onglet change, le calcul change.

Contient aussi les règles de saisie :
- Notes de 0 à 10 uniquement après CV / entretien / test. Une note manquante laisse le score vide.
- Critères bloquants : vérifier avant décision, **ne jamais filtrer automatiquement** sans examiner les aménagements possibles.
- Vidéo : suivre la réception, proposer une modalité adaptée si besoin, **ne pas noter les caractéristiques personnelles ni l'apparence**.

---

## Onglet `Pilotage`

Compteurs calculés : candidatures, vidéos reçues, à contacter, en entretien, scores complétés, shortlist. `pipeline-report` les lit, ne les recalcule pas à la main.

---

## Onglet `Réponses`

Les modèles d'email validés par le recruteur. `reply-drafter` part de là, jamais d'un modèle inventé.

---

## Onglets `Relances JJ-MM-AAAA`

Un onglet par vague de relance : Prénom, Nom, Email, Date envoi, Objet, Réponse attendue, Suivi. `relance-tracker` met à jour la colonne Suivi et ajoute une colonne `Horodatage réponse` quand il peut la lire dans `~~email`.

---

## Règles d'écriture

1. **Lire avant d'écrire.** Toujours relire la ligne du candidat juste avant de la modifier ; un autre humain peut l'avoir changée.
2. **Ne jamais écraser une note saisie par un humain.** Si une cellule bleue contient déjà une valeur, proposer la nouvelle note dans `Notes / preuves`, pas dans la cellule.
3. **Ne jamais supprimer une ligne.** Un candidat refusé reste dans le tableur avec `Statut = Refusé`.
4. **Chaque écriture est annoncée avant d'être faite** : « Je vais passer 3 candidats en Préqualification et noter les vidéos reçues. OK ? »
5. **Les données personnelles restent dans le tableur.** Aucun skill ne les recopie dans un rapport, un artefact ou un fichier (`shared/personal-data.md`).
