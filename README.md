# 🏥 Data Quality & Analyse des Pathologies en France (Cartographie CNAM)

## 🎯 Objectif du projet

Ce projet s'inscrit dans le cadre de ma spécialisation en Data Science (parcours Santé, Assurance, Finance — Master 2 à l'Université Paris-Saclay). Il exploite la **Cartographie des pathologies et des dépenses de l'Assurance Maladie**, publiée en open data par la CNAM (données réelles couvrant 67,6 millions de bénéficiaires, de 2015 à 2024).

L'objectif n'est pas seulement de produire des statistiques descriptives, mais de mener une véritable démarche de **gestion de la qualité de la donnée (Data Quality)** : un jeu de données institutionnel de cette taille contient des valeurs manquantes, des codes de secret statistique (`NS`, `<50`), des types hétérogènes et des doublons de nomenclature — autant de problèmes qu'une entreprise attend qu'un data analyst/gestionnaire de données sache identifier et traiter avant toute analyse.

**Problématique retenue :**
> Comment la prévalence des principales pathologies chroniques évolue-t-elle en France selon l'âge, le sexe et le territoire, et quelles pathologies représentent le poids financier le plus important pour l'Assurance Maladie ?

## 🛠 Outils et langages utilisés

- **Python** : nettoyage et audit qualité (`Pandas`, `NumPy`), visualisation (`Matplotlib`)
- **SQL (SQLite)** : structuration relationnelle et requêtes analytiques (jointures, agrégations, fenêtrage)
- **Power BI / Power Query** : tableau de bord interactif pour la restitution métier
- **Environnement** : Jupyter Notebook, Git/GitHub

## 📁 Sources de données

- CNAM — [Cartographie des pathologies et des dépenses de l'Assurance Maladie](https://www.assurance-maladie.ameli.fr/etudes-et-donnees/par-theme/pathologies/cartographie-assurance-maladie) — tableaux Excel des effectifs de patients par pathologie, sexe, classe d'âge, région
- data.gouv.fr — [Pathologies : dépenses remboursées affectées à chaque pathologie](https://www.data.gouv.fr/datasets/pathologies-depenses-remboursees-affectees-a-chaque-pathologie)
- Data.ameli.fr — [Effectifs et dépenses par pathologie](https://data.ameli.fr/explore/dataset/depenses/)

Ces jeux de données sont gratuits, réutilisables et régulièrement mis à jour par la CNAM.

## 📊 Méthodologie

### 1. Audit qualité des données (Python)
- Chargement des fichiers Excel/CSV bruts de la CNAM
- Détection et traitement des valeurs codées `NS` (non significatif, secret statistique) et `<50`
- Vérification des types (effectifs en entier, dépenses en flottant, années en date)
- Détection des doublons de libellés de pathologies (harmonisation des nomenclatures)
- Production d'un **rapport de qualité** : taux de complétude par colonne, nombre de valeurs aberrantes, cohérence des totaux

### 2. Structuration en base SQL
- Modélisation d'un schéma relationnel simple : `pathologies`, `effectifs_regionaux`, `depenses`
- Requêtes analytiques : top 10 des pathologies par effectif, dépense moyenne par patient et par pathologie, évolution régionale

### 3. Restitution Power BI
- Import des tables nettoyées via Power Query
- Dashboard interactif : carte de prévalence par région, évolution temporelle par pathologie, comparateur de dépenses

## 💡 Ce que répond ce projet

**Pourquoi commencer par un audit qualité plutôt que directement par l'analyse ?**
Réponse : Les données de santé publique contiennent des codes de confidentialité (secret statistique) et des changements de nomenclature d'une année sur l'autre. Ignorer ces spécificités fausse les moyennes et les comparaisons. Un bon data analyst sécurise d'abord la fiabilité du chiffre avant de le communiquer.

**Quelles pathologies pèsent le plus sur les dépenses de l'Assurance Maladie ?**
Réponse : L'analyse met en évidence la concentration des dépenses sur un nombre restreint de pathologies chroniques (maladies cardio-neurovasculaires, diabète, cancers), confirmant l'intérêt de cibler la prévention sur ces postes pour les acteurs de santé et de l'assurance.

**En quoi ce projet est-il utile pour une entreprise ?**
Réponse : Il démontre une compétence rare et recherchée : traiter une donnée institutionnelle imparfaite de bout en bout (Python → SQL → Power BI), avec un souci de qualité et de gouvernance de la donnée directement transposable aux enjeux d'un assureur, d'un établissement de santé ou d'un service data d'entreprise.

## 🚀 Reproduire le projet

```bash
git clone <lien-du-repo>
cd projet_sante_pathologies
pip install pandas numpy matplotlib
```

1. Placez les fichiers sources CNAM dans `data/`
2. Exécutez `notebooks/audit_qualite_et_analyse.py` (ou le notebook associé) pour rejouer le nettoyage et générer les graphiques
3. Chargez `sql/requetes_analytiques.sql` dans SQLite/DB Browser pour explorer la base structurée
4. Ouvrez `powerbi/dashboard_pathologies.pbix` pour le tableau de bord interactif

## 📈 Prochaines étapes

- Croiser ces indicateurs avec les données de mortalité (INSEE/CépiDc) pour enrichir l'analyse
- Passer à un projet de modélisation prédictive (voir projet santé n°2 : prédiction de réadmission hospitalière)
