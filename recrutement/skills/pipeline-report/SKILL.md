---
name: pipeline-report
description: >
  Donne au recruteur l'état du recrutement en une page : où en sont les
  candidatures étape par étape, ce qui bloque, ce qui attend une décision de lui,
  les délais qui glissent, les dossiers RGPD à purger, et les trois actions de la
  semaine. Lit l'onglet Pilotage du tableur et le confronte au reste, ne recalcule
  rien à la main. Déclencher sur « point recrutement », « où on en est globalement »,
  « résume-moi le pipeline », « combien de candidats », « qu'est-ce qui bloque »,
  « rapport », ou le lundi matin quand le recruteur demande ce qu'il doit faire.
allowed-tools: Read
---

# Pipeline Report

Le lundi matin du recruteur en une page : les chiffres qui comptent, ce qui attend sa décision, et rien d'autre.

Lire avant : `../../shared/tracker-schema.md`, `../../shared/personal-data.md`.

## Étape 1 — Lire, ne pas recalculer

Lire l'onglet `Pilotage` du `~~tracker` : candidatures, vidéos reçues, à contacter, en entretien, scores complétés, shortlist. Ce sont des formules ; elles font foi.

Puis lire `Assessment candidats` pour ce que Pilotage ne compte pas : répartition par `Statut`, dates dans `Notes / preuves`, `Prochaine étape` vides ou dépassées, critères bloquants restés à `À vérifier` sur des candidats en shortlist, dates d'entretien.

Et le dernier onglet `Relances JJ-MM-AAAA` : envoyés, répondus, délai dépassé.

**Si Pilotage et Assessment ne disent pas la même chose** (le cas du 19/10 : 5 vidéos dans Pilotage, 7 dans la colonne, 11 fichiers dans le Drive), le dire en premier, et proposer `relance-tracker` avant toute analyse. Un rapport sur un tableur faux est pire que pas de rapport.

## Étape 2 — Le funnel

Un tableau, étape par étape, avec le nombre et la variation depuis le dernier rapport (lire la date du dernier rapport dans `Notes / preuves` ou demander) :

| Étape | Nombre | Depuis le dernier point |
|---|---|---|
| Candidatures | | |
| Dossier complet (vidéo + prétentions + dispo) | | |
| Vidéos évaluées | | |
| Shortlist | | |
| Entretiens planifiés / réalisés | | |
| Offre | | |
| Refusés / Sans réponse | | |

Puis les **taux** qui disent si le process fonctionne : part des relancés qui ont répondu ; part des vidéos reçues qui ont été évaluées ; délai moyen entre réception de la vidéo et évaluation. Si moins de la moitié des vidéos reçues sont évaluées, c'est le goulot, quel que soit le nombre de relances.

## Étape 3 — Ce qui attend le recruteur

La section la plus utile. Uniquement les décisions que lui seul peut prendre, nommées (prénom + initiale) :

- Notes proposées par `video-review` non validées
- Candidats en bande Peut-être sans prochaine étape
- Sans réponse après délai : clore ou relancer une dernière fois
- Critères bloquants à `Non` sur un candidat en shortlist : aménagement ou refus
- Entretiens réalisés dont les notes ne sont pas dans le tableur
- Mises en attente dont la date promise approche ou est passée

Chaque ligne avec l'action en un verbe et le skill qui l'exécute.

## Étape 4 — Ce qui glisse

- Candidats sans mouvement depuis plus de 7 jours, par statut
- Promesses de date (mise en attente, « nous reviendrons vers vous d'ici ») dépassées
- Entretiens planifiés sans kit (`live-itw-prep` non lancé)

## Étape 5 — Hygiène RGPD

Dossiers `Refusé` ou `Sans réponse` dont le dernier contact date de plus de 22 mois : à purger ou à demander l'accord pour le vivier (`../../shared/personal-data.md`). Sur un recrutement en cours, cette section est vide ; elle existe pour que le tableur ne devienne pas un cimetière dans deux ans.

## Étape 6 — Les trois actions de la semaine

Trois, pas dix, dans l'ordre d'impact sur le goulot identifié à l'étape 2. Avec la phrase de déclenchement de chaque skill. Exemple :

1. « Évalue les 6 vidéos reçues » → `video-review` (le goulot)
2. « Rédige les relances » pour les 4 dossiers incomplets → `reply-drafter`
3. « Prépare l'entretien de Prénom A. » → `live-itw-prep`

## Livrable

Dans le chat, une page : écart Pilotage/Assessment s'il existe, funnel, ce qui attend le recruteur, ce qui glisse, trois actions. Chiffres en premier, prose minimale.

Si le recruteur veut un visuel ou un document à partager (point avec un associé), produire un artefact HTML sobre ou un document : **sans aucune coordonnée**, prénoms + initiales seulement, et jamais les prétentions salariales individuelles (agrégat « fourchette observée : X–Y k€ » admis).

Après livraison, proposer d'ajouter une ligne dans `Notes / preuves` d'un candidat fictif « — rapport » ou, mieux, dans l'onglet Pilotage : `JJ/MM/AAAA — pipeline-report : [3 chiffres clés]`, pour que le prochain rapport ait une base de comparaison.

## Clôture

Une ligne : le chiffre qui résume (« 70 candidats, 11 vidéos, 0 évaluée : le goulot c'est l'évaluation »). Puis la première des trois actions, avec sa phrase.

## À ne pas faire

- **Ne jamais recalculer les compteurs de Pilotage à la main.** Lire, signaler les écarts.
- **Ne jamais sortir une coordonnée ni un salaire individuel** d'un rapport.
- **Ne jamais classer ou recommander un candidat** dans le rapport ; c'est `video-review` et l'entretien qui le font, avec preuves.
- **Ne jamais produire un rapport rassurant sur un tableur incohérent.**
- **Ne jamais dépasser trois actions.**
