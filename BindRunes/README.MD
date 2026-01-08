# BindRunes Crafter

BindRunes Crafter est une application iOS expérimentale de création de **bindrunes** inspirée des traditions runiques nordiques.  
Elle permet de formuler une intention, de sélectionner et combiner des runes, puis d’ajuster leur disposition afin de créer un symbole personnel et symboliquement cohérent.

L’application met l’accent sur :
- la **stabilité visuelle**
- une **interface rituelle** (centre fixe, zones contextuelles)
- une **expérience créative fluide**, sans navigation superflue

---

## ✨ Concept

Un **bindrune** est un symbole composite formé par la fusion de plusieurs runes, chacune portant une signification propre.

BindRunes Crafter propose :
- une zone centrale rituelle (anneau + bindrune)
- une approche guidée par l’**intention**
- des réglages précis rune par rune
- une interface épurée, sans scroll global

---

## 🧭 Architecture UI (principes)

- **NavigationStack** conservée (évolutivité future)
- **Aucun `navigationTitle`** (titre géré dans le contenu)
- **Pas de ScrollView global**
- Zones fixes :
  - Titre (sous la Dynamic Island)
  - Anneau / bindrune central
  - Zone Intention / Runes sélectionnées
- Zones contextuelles :
  - Réglages de rune (affichés uniquement si une rune est sélectionnée)
  - Export (appui long sur une icône)
  - Index / symbolique des runes (icône dédiée)

---

## 🛠️ Fonctionnalités actuelles

- Sélection et combinaison de runes
- Déplacement des runes avec snapping
- Génération automatique depuis une intention
- Réglages individuels :
  - rotation
  - échelle
  - miroir
  - opacité
- Export du bindrune en image PNG
- Retour haptique léger sur les interactions

---

## 🧩 Structure du projet (simplifiée)

