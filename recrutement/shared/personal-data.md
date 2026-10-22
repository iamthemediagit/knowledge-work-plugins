# Données personnelles des candidats

**Partagé par tous les skills.** Un dossier de candidature contient bien plus que ce dont un livrable a besoin. La règle : utiliser un champ pour faire le travail, ne jamais le reproduire.

---

## Jamais reproduit, dans aucune sortie

Ni dans le chat, ni dans un artefact HTML, ni dans un rapport, ni dans un fichier du dépôt, ni dans un brouillon destiné à quelqu'un d'autre que le candidat lui-même :

- Numéro de sécurité sociale, pièce d'identité, titre de séjour, RIB, IBAN
- Date de naissance, âge
- Adresse personnelle (une ville ou un département peut apparaître si le poste exige une présence locale, et seulement dans le tableur)
- État de santé, handicap, situation familiale, grossesse, et tout ce qu'un candidat confie spontanément dans ce registre
- Les coordonnées (email, mobile) **en dehors du tableur et des brouillons adressés au candidat**. Un rapport de pipeline parle de « 7 vidéos reçues », pas de sept adresses email.

---

## Ce qui reste là où c'est

- **Les vidéos** restent dans `~~drive`. Elles ne sont ni téléchargées dans un autre service, ni envoyées à une API externe sans accord explicite du recruteur (voir `skills/video-review/reference/transcription.md` sur le choix local vs cloud).
- **Les transcriptions** sont des données personnelles au même titre que les vidéos : stockées à côté, dans le même dossier, mêmes droits d'accès.
- **Les notes et preuves** vont dans le tableur, pas dans un fichier local du recruteur ni dans une mémoire du plugin.

---

## Durée de conservation

La CNIL fixe à **deux ans après le dernier contact** la durée maximale de conservation d'un dossier de candidat non retenu, sauf accord du candidat pour une conservation plus longue (vivier). Le plugin ne supprime rien lui-même, mais `pipeline-report` signale les dossiers refusés ou sans réponse qui approchent de l'échéance.

Le candidat peut demander l'accès, la rectification ou la suppression de ses données à tout moment. `reply-drafter` dispose d'un modèle d'accusé de réception pour ces demandes ; le traitement reste au recruteur.

---

## Information des candidats

Les candidats doivent savoir : qui traite leurs données, pour quoi, combien de temps, et qu'un outil d'IA assiste l'analyse. Une mention dans l'annonce ou dans le premier email suffit. `reply-drafter` la propose si elle manque des modèles existants.

---

## Quand le recruteur le demande quand même

Dire que le champ n'est pas reproduit par ce plugin et renvoyer au tableur, où il est sous ses propres droits d'accès. Une ligne, pas de leçon.
