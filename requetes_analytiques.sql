USE Projet_2_en_SanteCNAM;
GO

-- ==========================================
-- REQUÊTES ANALYTIQUES DU PROJET (VERSION PROPRE)
-- ==========================================

-- A. Top 10 des pathologies par effectif (Dernière année disponible)
SELECT TOP 10 
    libelle_pathologie, 
    SUM(TRY_CAST(effectif_tot AS FLOAT)) AS total_patients
FROM data_effectifs_clean
WHERE TRY_CAST(annee AS INT) = (SELECT MAX(TRY_CAST(annee AS INT)) FROM data_effectifs_clean)
GROUP BY libelle_pathologie
ORDER BY total_patients DESC;
GO

-- B. Dépense moyenne par patient (Croisement Effectifs x Dépenses)
SELECT TOP 15 
    e.libelle_pathologie,
    SUM(TRY_CAST(d.montant_total AS FLOAT)) / NULLIF(SUM(TRY_CAST(e.effectif_tot AS FLOAT)), 0) AS cout_moyen_patient
FROM data_effectifs_clean e
JOIN data_depenses_clean d 
    ON e.code_pathologie = d.code_pathologie 
    AND e.annee = d.annee
WHERE TRY_CAST(e.annee AS INT) = (SELECT MAX(TRY_CAST(annee AS INT)) FROM data_depenses_clean)
GROUP BY e.libelle_pathologie
ORDER BY cout_moyen_patient DESC;
GO

-- C. Évolution annuelle du nombre de patients diabétiques
SELECT 
    annee, 
    SUM(TRY_CAST(effectif_tot AS FLOAT)) AS total_diabetiques
FROM data_effectifs_clean
WHERE libelle_pathologie LIKE '%diabète%'
GROUP BY annee
ORDER BY annee;
GO