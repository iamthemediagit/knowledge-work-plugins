---
name: job-post
description: >
  Construit le dossier d'ouverture d'un poste à partir d'un brief de quinze
  minutes : la fiche de poste du plugin (grille pondérée, critères bloquants,
  questions aux candidats, correspondance questions → critères), l'annonce en
  français conforme au droit du travail, et les colonnes à ajouter au tableur.
  La grille se fixe avant de lire la première candidature. Déclencher sur « on
  recrute un », « rédige l'annonce », « fiche de poste », « ouvre un poste »,
  « on cherche un », « job description », « grille d'évaluation », ou dès que le
  recruteur parle d'un nouveau recrutement sans fiche dans positions/.
allowed-tools: Read
---

# Job Post

Ouvrir un poste proprement : la grille d'abord, l'annonce ensuite, et un tableur prêt à recevoir les candidats. Tout l'aval du plugin (`relance-tracker`, `video-review`, `live-itw-prep`) dépend de ce que ce skill produit.

Lire avant : `../../positions/_template.md`, `../../shared/fair-screening.md`, `../../shared/voice-profile.md`.

## Étape 1 — Le brief, quinze minutes

Questions au recruteur, dans cet ordre, en s'arrêtant dès qu'il a répondu dans son message initial :

1. **Le poste en une phrase** : qui fait quoi pour qui. « Bras droit du fondateur » suffit à démarrer.
2. **Contrat** : CDI, CDD, freelance, alternance. Change l'annonce, les critères bloquants et les emails (`brut annuel` vs `TJM`).
3. **Lieu et présence** : où, combien de jours, quels déplacements.
4. **La question qui fixe les pondérations** : « Deux candidats. L'un est d'une fiabilité absolue mais n'anticipe rien ; l'autre anticipe tout mais oublie parfois de fermer une boucle. Lequel vous voulez dans le bureau ? » La réponse pèse plus que toute discussion abstraite. Deux ou trois arbitrages de ce type suffisent.
5. **Ce qui a manqué la dernière fois** : s'il y a eu un prédécesseur, ce qui n'allait pas est souvent le critère le plus lourd.
6. **Critères bloquants** : ce sans quoi le poste est impossible, et pourquoi. Trois ou quatre au maximum. Un bloquant qui est en réalité un « souhaitable » réduit le vivier pour rien.
7. **Fourchette de rémunération** : fixée maintenant, **avant** de lire des prétentions. Sinon la fourchette s'ajuste au candidat qu'on aime.
8. **Mode de candidature** : CV seul, CV + vidéo, CV + réponses écrites, démo. Si vidéo : les questions, 3 à 4 maximum, chacune reliée à un critère.

## Étape 2 — La grille

Construire la grille métier selon `_template.md` :

- 5 à 7 critères, pondérations totalisant 100, **aucun au-dessus de 40**
- chaque critère écrit comme un **comportement observable**, pas un adjectif. « Bon communicant » ne se note pas ; « adapte le ton à l'interlocuteur, remonte ce qui compte, tait ce qui ne compte pas » se note
- pour chaque critère : où on peut l'observer (CV / question vidéo / entretien / test / références)

Puis la grille culture si l'entreprise en a une (chez maars : les 5 piliers). Même règle : comportement observable. Un pilier qu'on ne sait pas observer n'entre pas dans la grille.

Puis la **table de correspondance questions → critères** : pour chaque question posée au candidat, les critères qu'elle peut éclairer et ceux qu'elle n'éclaire pas. Un critère qui n'apparaît dans aucune question reste en tiret jusqu'à l'entretien ; le dire explicitement dans la fiche. C'est la pièce qui manque dans 90 % des recrutements et qui rend les notes vidéo arbitraires.

Lire la grille au recruteur à voix haute, telle qu'elle sera appliquée. Ce qui ne survit pas à cette lecture (« fit culturel », « dynamique », « présentation soignée ») sort.

## Étape 3 — L'annonce

Rédiger dans la voix du profil (`../../shared/voice-profile.md`). Structure dans `reference/annonce.md`. Les contraintes qui ne se négocient pas :

- **Pas de mention discriminatoire** (art. L1132-1 et L5321-2 du Code du travail) : ni âge (« jeune », « senior », « 5 ans d'expérience maximum »), ni sexe (intitulé au masculin seul : écrire « assistant(e) » ou « assistant / assistante » ou « H/F »), ni situation familiale, ni origine, ni apparence (« excellente présentation »), ni santé. « Dynamique » et « digital native » sont des proxys d'âge : les retirer.
- **Rémunération** : indiquer la fourchette. Non obligatoire en France pour l'instant, mais la directive européenne sur la transparence salariale (transposition attendue en 2026) l'imposera, et une annonce avec fourchette reçoit des candidatures mieux ciblées.
- **Information IA et RGPD** : une phrase disant qu'un outil d'IA assiste l'analyse des candidatures, que la décision est humaine, et combien de temps les données sont conservées. Formulation dans `reference/annonce.md`.
- **Les critères bloquants apparaissent dans l'annonce**, avec leur raison. Un candidat qui sait pourquoi le permis est demandé peut proposer un aménagement ; un candidat devant « permis B obligatoire » renonce.
- **Les questions vidéo apparaissent dans l'annonce** si le mode de candidature les inclut, avec la mention « aucun montage, pas de texte à lire » et la porte ouverte à une modalité adaptée. Le candidat sait à quoi s'attendre avant de postuler.

Pas de superlatifs d'entreprise (« leader », « en forte croissance », « famille »). Une phrase sur ce que fait l'entreprise, une sur ce que le poste change pour la personne qui le prend.

## Étape 4 — Le tableur

Produire la liste des colonnes à créer dans `~~tracker`, selon `../../shared/tracker-schema.md` : identité, une colonne bleue par critère, formules de score (SOMMEPROD des pondérations), critères bloquants, suivi, trace. Plus l'onglet `Barème et méthode` rempli avec les pondérations de la grille, et un onglet `Réponses` pré-rempli avec les modèles de `../reply-drafter/reference/templates-fr.md` adaptés au contrat.

Si le recruteur réutilise un tableur existant (le cas maars pour un deuxième poste) : un onglet ou un fichier distinct par poste, jamais deux postes dans le même onglet. Les grilles diffèrent, les formules aussi.

## Étape 5 — Livrer et ranger

Trois livrables, dans cet ordre :

1. **La fiche de poste** : `positions/<poste>-<entreprise>.md`, remplie depuis `_template.md`. Proposer de l'écrire dans le plugin si le recruteur travaille depuis le dépôt ; sinon la livrer en fichier.
2. **L'annonce**, prête à publier, avec la liste des canaux proposés (site, LinkedIn, France Travail, APEC pour un cadre, écoles ou réseaux spécialisés pour un formateur).
3. **La structure du tableur**, à créer par le recruteur ou, avec `~~tracker` connecté et accord explicite, créée par le skill dans un fichier **nouveau** (jamais en modifiant un tableur de recrutement en cours).

Rappeler en une ligne : la grille est figée à partir de la première candidature lue. On peut la corriger avant ; après, chaque changement doit être noté dans `Barème et méthode` avec sa date et sa raison, et appliqué à tous les candidats déjà notés.

## Clôture

Une ligne : le poste est ouvert, la grille a N critères, l'annonce est prête. Puis au plus deux suites : « publie / envoie l'annonce » (le recruteur), « mets à jour le tableau » (`relance-tracker`) dès les premières candidatures.

## À ne pas faire

- **Ne jamais écrire la grille après avoir lu des candidatures.** Elle finirait par décrire le candidat qu'on a aimé.
- **Ne jamais laisser un critère au-dessus de 40**, ni un critère qui n'est pas un comportement observable.
- **Ne jamais produire une annonce sans fourchette de rémunération** sans l'avoir proposée et noté le refus du recruteur.
- **Ne jamais laisser un adjectif proxy** (jeune, dynamique, senior, bonne présentation, natif) dans l'annonce.
- **Ne jamais modifier un tableur de recrutement en cours** pour y loger un nouveau poste.
