# Installation des librairies et paramétrage ----

options(scipen = 999) # Disable scientific notation

library(haven)
library(sjlabelled)
library(viridis)
library(tidyverse)
library(survey)

# Viridis colors as default for ggplot2 : easier to read by those with colorblindness, and print well in grey scale.
options(ggplot2.continuous.colour="viridis")
options(ggplot2.continuous.fill = "viridis")
scale_colour_discrete <- scale_colour_viridis_d
scale_fill_discrete <- scale_fill_viridis_d

# Importation des données ----

menages <- read_sas("../data/men2010.sas7bdat")
individus <- read_sas("../data/ind2010.sas7bdat")
deplacements <- read_sas("../data/dplct2010.sas7bdat")
trajets <- read_sas("../data/trajet2010.sas7bdat")

# Étiquettes de variables, table "Ménages" ----

menages <- menages %>%
  var_labels(
    SEM =	"Semaine d'enquête",
    NQUEST = "Identifiant du ménage",
    POIDSM = "Poids du ménage",
    RESCOUR = "Couronne de résidence",
    RESDEP = "Département de résidence",
    RESSECT = "Secteur de résidence",
    RESCOMM = "Commune de résidence",
    RESC = "Carreau de résidence",
    JDEP = "Jour (semaine) des déplacements",
    MNP = "Nombre de personnes du ménage",
    MNP5 = "Nombre de personnes du ménage de 5 ans et plus",
    MNPMOB = "Nombre de personnes du ménage qui se sont déplacées la veille",
    MNPACT = "Nombre d'actifs dans le ménage",
    TYPELOG = "Type de logement",
    OCCUPLOG = "Occupation du logement",
    LOY_HC = "Montant du loyer hors charge",
    LOY_NSP = "Ne sait pas",
    ALLOC = "Allocations",
    CHG = "Montant des charges mensuelles",
    CHG_NSP = "Ne sait pas",
    LOY_PARK = "Montant des loyers de parking",
    PARK = "Loyers de parking",
    NBPI = "Nombre de pièces",
    SURF = "Superficie totale du logement",
    TELFIX = "Téléphone fixe",
    INTERNET = "Internet",
    ANEM = "Nombre d'années passées dans ce logement",
    MNEM = "Nombre de mois passés dans ce logement",
    CHOIXLOG1 = "Raison 1 de choix du logement",
    CHOIXLOG2 = "Raison 2 de choix du logement",
    CHOIXLOG3 = "Raison 3 de choix du logement",
    ACOMM = "Commune de résidence précédente",
    NB_VELO = "Nombre de vélos (en état de marche)",
    NB_VAE = "Nombre de VAE",
    PARKVELO = "Parking à vélo",
    NB_VD = "Nombre de voitures à disposition",
    TYPEV1 = "Type de véhicule du véhicule 1",
    ENERGV1 = "Energie du véhicule 1",
    APMCV1 = "Année de première mise en circulation (véhicule 1)",
    PUISSV1 = "Puissance fiscale en chevaux (véhicule 1)",
    ANKMV1 = "Kilométrage moyen annuel (véhicule 1)",
    CPTKMV1 = "Kilométrage au compteur (véhicule 1)",
    POSSV1 = "Possession du véhicule 1",
    STATV1 = "Stationnement la nuit (véhicule 1)",
    TYPEV2 = "Type de véhicule du véhicule 2",
    ENERGV2 = "Energie du véhicule 2",
    APMCV2 = "Année de première mise en circulation (véhicule 2)",
    PUISSV2 = "Puissance fiscale en chevaux (véhicule 2)",
    ANKMV2 = "Kilométrage moyen annuel (véhicule 2)",
    CPTKMV2 = "Kilométrage au compteur (véhicule 2)",
    POSSV2 = "Possession du véhicule 2",
    STATV2 = "Stationnement la nuit (véhicule 2)",
    TYPEV3 = "Type de véhicule du véhicule 3",
    ENERGV3 = "Energie du véhicule 3",
    APMCV3 = "Année de première mise en circulation (véhicule 3)",
    PUISSV3 = "Puissance fiscale en chevaux (véhicule 3)",
    ANKMV3 = "Kilométrage moyen annuel (véhicule 3)",
    CPTKMV3 = "Kilométrage au compteur (véhicule 3)",
    POSSV3 = "Possession du véhicule 3",
    STATV3 = "Stationnement la nuit (véhicule 3)",
    TYPEV4 = "Type de véhicule du véhicule 4",
    ENERGV4 = "Energie du véhicule 4",
    APMCV4 = "Année de première mise en circulation (véhicule 4)",
    PUISSV4 = "Puissance fiscale en chevaux (véhicule 4)",
    ANKMV4 = "Kilométrage moyen annuel (véhicule 4)",
    CPTKMV4 = "Kilométrage au compteur (véhicule 4)",
    POSSV4 = "Possession du véhicule 4",
    STATV4 = "Stationnement la nuit (véhicule 4)",
    NB_2RM = "Nombre de 2RM, 3RM à disposition",
    NB_VEH = "Nombre de véhicules motorisés à disposition",
    TYPERM1 = "Type du 2RM/3RM 1",
    MOTRM1 = "Type de moteur (2RM/3RM 1)",
    ENERM1 = "Type d'énergie (2RM/3RM 1)",
    APMCRM1 = "Année de première mise en circulation (2RM/3RM 1)",
    CYLRM1 = "Cylindrée (2RM/3RM 1)",
    ANKMRM1 = "Kilométrage moyen annuel (2RM/3RM 1)",
    STATRM1 = "Stationnement la nuit (2RM/3RM 1)",
    TYPERM2 = "Type du 2RM/3RM 2",
    MOTRM2 = "Type de moteur (2RM/3RM 2)",
    ENERM2 = "Type d'énergie (2RM/3RM 2)",
    APMCRM2 = "Année de première mise en circulation (2RM/3RM 2)",
    CYLRM2 = "Cylindrée (2RM/3RM 2)",
    ANKMRM2 = "Kilométrage moyen annuel (2RM/3RM 2)",
    STATRM2 = "Stationnement la nuit (2RM/3RM 2)",
    TYPERM3 = "Type du 2RM/3RM 3",
    MOTRM3 = "Type de moteur (2RM/3RM 3)",
    ENERM3 = "Type d'énergie (2RM/3RM 3)",
    APMCRM3 = "Année de première mise en circulation (2RM/3RM 3)",
    CYLRM3 = "Cylindrée (2RM/3RM 3)",
    ANKMRM3 = "Kilométrage moyen annuel (2RM/3RM 3)",
    STATRM3 = "Stationnement la nuit (2RM/3RM 3)",
    TYPERM4 = "Type du 2RM/3RM 4",
    MOTRM4 = "Type de moteur (2RM/3RM 4)",
    ENERM4 = "Type d'énergie (2RM/3RM 4)",
    APMCRM4 = "Année de première mise en circulation (2RM/3RM 4)",
    CYLRM4 = "Cylindrée (2RM/3RM 4)",
    ANKMRM4 = "Kilométrage moyen annuel (2RM/3RM 4)",
    STATRM4 = "Stationnement la nuit (2RM/3RM 4)",
    ANCOUT = "Coût annuel estimé pour la flotte de véhicules (entretien, réparation)",
    ASSCOUT = "Coût annuel de l'assurance",
    REVENU = "Classe de revenut net mensuel",
  )

# Étiquettes de valeurs, table "Ménages" ----

menages <- menages %>%
  val_labels(
    RESCOUR = c(
      "Paris" = "1",
      "Petite couronne" = "2",
      "Grande couronne" = "3"
    ),
    RESDEP = c(
      "Paris" = "75",
      "Seine-et-Marne" = "77",
      "Yvelines" = "78",
      "Essonne" = "91",
      "Hauts-de-Seine" = "92",
      "Seine-Saint-Denis" = "93",
      "Val-de-Marne" = "94"
    ),
    JDEP = c(
      "Lundi" = "1",
      "Mardi" = "2",
      "Mercredi" = "3",
      "Jeudi" = "4",
      "Vendredi" = "5",
      "Samedi" = "6",
      "Dimanche" = "7"
    ),
    TYPELOG = c(
      "Individuel sans jardin" = "1",
      "Individuel avec jardin <=300 m²" = "2",
      "Individuel avec jardin >300 m²" = "3",
      "Collectif moins de 50 logements" = "4",
      "Collectif 50 à 100 logements" = "5",
      "Collectif plus de 100 logements" = "6",
      "Autre" = "7"
    ),
    OCCUPLOG = c(
      "Propriétaire" = "1",
      "Accédant à la propriété" = "2",
      "Locataire d'un organisme HLM" = "3",
      "Locataire du parc privé en meublé" = "4",
      "Locataire du parc privé sous régime loi 48" = "5",
      "Autre type de locataire du parc privé" = "6",
      "Logé gratuitement par l'employeur / logement de fonction" = "7",
      "Logé gratuitement (sans loyer, avec charges éventuelles)" = "8",
      "Autres" = 8
    ),
    LOY_NSP = c(
      "Ne sait pas" = "1"
    ),
    ALLOC = c(
      "Montant avec allocations" = "1",
      "Montant sans allocations" = "2",
      "Ne sait pas"= "3"
    ),
    CHG_NSP = c(
      "Ne sait pas" = "1"
    ),
    PARK = c(
      "Oui, ne connaît pas le montant" = "1",
      "Non, montant inclus dans les loyers/ charges" = "2",
      "Non, n'en paie pas" = "3"
    ),
    TELFIX = c(
      "Oui" = "1",
      "Non" = "2"
    ),
    INTERNET = c(
      "Oui" = "1",
      "Non" = "2"
    ),
    CHOIXLOG1 = c(
      "Prix du logement" = "1",
      "Taille du logement" = "2",
      "Confort du logement" = "3",
      "Proximité du lieu de travail" = "4",
      "Proximité du centre-ville" = "5",
      "Proximité famille / amis" = "6",
      "Proximité des équipements scolaires" = "7",
      "Proximité des commerces" = "8",
      "Image du quartier/réputation du quartier" = "9",
      "Qualité de l'environnement, du cadre de vie" = "10",
      "Qualité de la desserte routière" = "11",
      "Qualité de desserte des transports collectifs" = "12",
      "Logement neuf ou ancien" = "13",
      "Type de logement (maison ou appartement)" = "14",
      "Ne sait pas, ne sait plus" = "15",
      "Autre critère" = "16"
    ),
    CHOIXLOG2 = c(
      "Prix du logement" = "1",
      "Taille du logement" = "2",
      "Confort du logement" = "3",
      "Proximité du lieu de travail" = "4",
      "Proximité du centre-ville" = "5",
      "Proximité famille / amis" = "6",
      "Proximité des équipements scolaires" = "7",
      "Proximité des commerces" = "8",
      "Image du quartier/réputation du quartier" = "9",
      "Qualité de l'environnement, du cadre de vie" = "10",
      "Qualité de la desserte routière" = "11",
      "Qualité de desserte des transports collectifs" = "12",
      "Logement neuf ou ancien" = "13",
      "Type de logement (maison ou appartement)" = "14",
      "Ne sait pas, ne sait plus" = "15",
      "Autre critère" = "16"
    ),
    CHOIXLOG3 = c(
      "Prix du logement" = "1",
      "Taille du logement" = "2",
      "Confort du logement" = "3",
      "Proximité du lieu de travail" = "4",
      "Proximité du centre-ville" = "5",
      "Proximité famille / amis" = "6",
      "Proximité des équipements scolaires" = "7",
      "Proximité des commerces" = "8",
      "Image du quartier/réputation du quartier" = "9",
      "Qualité de l'environnement, du cadre de vie" = "10",
      "Qualité de la desserte routière" = "11",
      "Qualité de desserte des transports collectifs" = "12",
      "Logement neuf ou ancien" = "13",
      "Type de logement (maison ou appartement)" = "14",
      "Ne sait pas, ne sait plus" = "15",
      "Autre critère" = "16"
    ),
    PARKVELO = c(
      "Oui" = "1",
      "Non" = "2"
    ),
    TYPEV1 = c(
      "Véhicule de tourisme ou utilitaire (<800 kg de charge utile)" = "1",
      "Véhicule utilitaire (800-1000 kg de charge utile)" = "2",
      "Véhicule utilitaire (+1000 kg de charge utile, >3500 kg PTAC)" = "3",
      "Camping car" = "4",
      "Voiture sans permis" = "5"
    ),
    ENERGV1 = c(
      "Sans plomb" = "1",
      "Super" = "2",
      "Diesel" = "3",
      "Hybride" = "4",
      "Électrique" = "5",
      "Autre (GPL)" = "6"
    ),
    POSSV1 = c(
      "Possédé par le ménage" = "1",
      "Possédé par le ménage (aide employeur)" = "2",
      "Possédé par l'employeur" = "3",
      "Autres (location, prêt, leasing)" = "4"
    ),
    STATV1 = c(
      "Voie publique, payant à durée limitée" = "1",
      "Voie publique, payant tarif résidentiel" = "2",
      "Voie publique, gratuit autorisé" = "3",
      "Voie publique, gratuit non autorisé" = "4",
      "Emplacement privé, gratuit" = "5",
      "Emplacement privé, propriétaire" = "6",
      "Emplacement privé, locataire" = "7",
      "Stationnement ouvert au public, gratuit" = "8",
      "Stationnement ouvert au public, propriétaire" = "9",
      "Stationnement ouvert au public, locataire" = "10",
      "Stationnement ouvert au public, payant à l'horaire" = "11",
      "Stationnement ouvert au public, autres" = "12"
    ),
    TYPEV2 = c(
      "Véhicule de tourisme ou utilitaire (<800 kg de charge utile)" = "1",
      "Véhicule utilitaire (800-1000 kg de charge utile)" = "2",
      "Véhicule utilitaire (+1000 kg de charge utile, >3500 kg PTAC)" = "3",
      "Camping car" = "4",
      "Voiture sans permis" = "5"
    ),
    ENERGV2 = c(
      "Sans plomb" = "1",
      "Super" = "2",
      "Diesel" = "3",
      "Hybride" = "4",
      "Électrique" = "5",
      "Autre (GPL)" = "6"
    ),
    POSSV2 = c(
      "Possédé par le ménage" = "1",
      "Possédé par le ménage (aide employeur)" = "2",
      "Possédé par l'employeur" = "3",
      "Autres (location, prêt, leasing)" = "4"
    ),
    STATV2 = c(
      "Voie publique, payant à durée limitée" = "1",
      "Voie publique, payant tarif résidentiel" = "2",
      "Voie publique, gratuit autorisé" = "3",
      "Voie publique, gratuit non autorisé" = "4",
      "Emplacement privé, gratuit" = "5",
      "Emplacement privé, propriétaire" = "6",
      "Emplacement privé, locataire" = "7",
      "Stationnement ouvert au public, gratuit" = "8",
      "Stationnement ouvert au public, propriétaire" = "9",
      "Stationnement ouvert au public, locataire" = "10",
      "Stationnement ouvert au public, payant à l'horaire" = "11",
      "Stationnement ouvert au public, autres" = "12"
    ),
    TYPEV3 = c(
      "Véhicule de tourisme ou utilitaire (<800 kg de charge utile)" = "1",
      "Véhicule utilitaire (800-1000 kg de charge utile)" = "2",
      "Véhicule utilitaire (+1000 kg de charge utile, >3500 kg PTAC)" = "3",
      "Camping car" = "4",
      "Voiture sans permis" = "5"
    ),
    ENERGV3 = c(
      "Sans plomb" = "1",
      "Super" = "2",
      "Diesel" = "3",
      "Hybride" = "4",
      "Électrique" = "5",
      "Autre (GPL)" = "6"
    ),
    POSSV3 = c(
      "Possédé par le ménage" = "1",
      "Possédé par le ménage (aide employeur)" = "2",
      "Possédé par l'employeur" = "3",
      "Autres (location, prêt, leasing)" = "4"
    ),
    STATV3 = c(
      "Voie publique, payant à durée limitée" = "1",
      "Voie publique, payant tarif résidentiel" = "2",
      "Voie publique, gratuit autorisé" = "3",
      "Voie publique, gratuit non autorisé" = "4",
      "Emplacement privé, gratuit" = "5",
      "Emplacement privé, propriétaire" = "6",
      "Emplacement privé, locataire" = "7",
      "Stationnement ouvert au public, gratuit" = "8",
      "Stationnement ouvert au public, propriétaire" = "9",
      "Stationnement ouvert au public, locataire" = "10",
      "Stationnement ouvert au public, payant à l'horaire" = "11",
      "Stationnement ouvert au public, autres" = "12"
    ),
    TYPEV4 = c(
      "Véhicule de tourisme ou utilitaire (<800 kg de charge utile)" = "1",
      "Véhicule utilitaire (800-1000 kg de charge utile)" = "2",
      "Véhicule utilitaire (+1000 kg de charge utile, >3500 kg PTAC)" = "3",
      "Camping car" = "4",
      "Voiture sans permis" = "5"
    ),
    ENERGV4 = c(
      "Sans plomb" = "1",
      "Super" = "2",
      "Diesel" = "3",
      "Hybride" = "4",
      "Électrique" = "5",
      "Autre (GPL)" = "6"
    ),
    POSSV4 = c(
      "Possédé par le ménage" = "1",
      "Possédé par le ménage (aide employeur)" = "2",
      "Possédé par l'employeur" = "3",
      "Autres (location, prêt, leasing)" = "4"
    ),
    STATV4 = c(
      "Voie publique, payant à durée limitée" = "1",
      "Voie publique, payant tarif résidentiel" = "2",
      "Voie publique, gratuit autorisé" = "3",
      "Voie publique, gratuit non autorisé" = "4",
      "Emplacement privé, gratuit" = "5",
      "Emplacement privé, propriétaire" = "6",
      "Emplacement privé, locataire" = "7",
      "Stationnement ouvert au public, gratuit" = "8",
      "Stationnement ouvert au public, propriétaire" = "9",
      "Stationnement ouvert au public, locataire" = "10",
      "Stationnement ouvert au public, payant à l'horaire" = "11",
      "Stationnement ouvert au public, autres" = "12"
    ),
    TYPERM1 = c(
      "Moto" = "1",
      "Scooter" = "2",
      "Autre 2RM" = "3",
      "3 roues motorisé" = "4"
    ),
    MOTRM1 = c(
      "Deux temps" = "2",
      "Quatre temps" = "4"
    ),
    ENERM1 = c(
      "Électrique" = "1",
      "Essence" = "2"
    ),
    CYLRM1 = c(
      "Inférieur à 50 cm3" = "1",
      "50-125 cm3" = "2",
      "Supérieur à 125 cm3" = "3"
    ),
    STATRM1 = c(
      "Voie publique, payant à durée limitée" = "1",
      "Voie publique, payant tarif résidentiel" = "2",
      "Voie publique, gratuit autorisé" = "3",
      "Voie publique, gratuit non autorisé" = "4",
      "Emplacement privé, gratuit" = "5",
      "Emplacement privé, propriétaire" = "6",
      "Emplacement privé, locataire" = "7",
      "Stationnement ouvert au public, gratuit" = "8",
      "Stationnement ouvert au public, propriétaire" = "9",
      "Stationnement ouvert au public, locataire" = "10",
      "Stationnement ouvert au public, payant à l'horaire" = "11",
      "Stationnement ouvert au public, autres" = "12"
    ),
    TYPERM2 = c(
      "Moto" = "1",
      "Scooter" = "2",
      "Autre 2RM" = "3",
      "3 roues motorisé" = "4"
    ),
    MOTRM2 = c(
      "Deux temps" = "2",
      "Quatre temps" = "4"
    ),
    ENERM2 = c(
      "Électrique" = "1",
      "Essence" = "2"
    ),
    CYLRM2 = c(
      "Inférieur à 50 cm3" = "1",
      "50-125 cm3" = "2",
      "Supérieur à 125 cm3" = "3"
    ),
    STATRM2 = c(
      "Voie publique, payant à durée limitée" = "1",
      "Voie publique, payant tarif résidentiel" = "2",
      "Voie publique, gratuit autorisé" = "3",
      "Voie publique, gratuit non autorisé" = "4",
      "Emplacement privé, gratuit" = "5",
      "Emplacement privé, propriétaire" = "6",
      "Emplacement privé, locataire" = "7",
      "Stationnement ouvert au public, gratuit" = "8",
      "Stationnement ouvert au public, propriétaire" = "9",
      "Stationnement ouvert au public, locataire" = "10",
      "Stationnement ouvert au public, payant à l'horaire" = "11",
      "Stationnement ouvert au public, autres" = "12"
    ),
    TYPERM3 = c(
      "Moto" = "1",
      "Scooter" = "2",
      "Autre 2RM" = "3",
      "3 roues motorisé" = "4"
    ),
    MOTRM3 = c(
      "Deux temps" = "2",
      "Quatre temps" = "4"
    ),
    ENERM3 = c(
      "Électrique" = "1",
      "Essence" = "2"
    ),
    CYLRM3 = c(
      "Inférieur à 50 cm3" = "1",
      "50-125 cm3" = "2",
      "Supérieur à 125 cm3" = "3"
    ),
    STATRM3 = c(
      "Voie publique, payant à durée limitée" = "1",
      "Voie publique, payant tarif résidentiel" = "2",
      "Voie publique, gratuit autorisé" = "3",
      "Voie publique, gratuit non autorisé" = "4",
      "Emplacement privé, gratuit" = "5",
      "Emplacement privé, propriétaire" = "6",
      "Emplacement privé, locataire" = "7",
      "Stationnement ouvert au public, gratuit" = "8",
      "Stationnement ouvert au public, propriétaire" = "9",
      "Stationnement ouvert au public, locataire" = "10",
      "Stationnement ouvert au public, payant à l'horaire" = "11",
      "Stationnement ouvert au public, autres" = "12"
    ),
    TYPERM4 = c(
      "Moto" = "1",
      "Scooter" = "2",
      "Autre 2RM" = "3",
      "3 roues motorisé" = "4"
    ),
    MOTRM4 = c(
      "Deux temps" = "2",
      "Quatre temps" = "4"
    ),
    ENERM4 = c(
      "Électrique" = "1",
      "Essence" = "2"
    ),
    CYLRM4 = c(
      "Inférieur à 50 cm3" = "1",
      "50-125 cm3" = "2",
      "Supérieur à 125 cm3" = "3"
    ),
    STATRM4 = c(
      "Voie publique, payant à durée limitée" = "1",
      "Voie publique, payant tarif résidentiel" = "2",
      "Voie publique, gratuit autorisé" = "3",
      "Voie publique, gratuit non autorisé" = "4",
      "Emplacement privé, gratuit" = "5",
      "Emplacement privé, propriétaire" = "6",
      "Emplacement privé, locataire" = "7",
      "Stationnement ouvert au public, gratuit" = "8",
      "Stationnement ouvert au public, propriétaire" = "9",
      "Stationnement ouvert au public, locataire" = "10",
      "Stationnement ouvert au public, payant à l'horaire" = "11",
      "Stationnement ouvert au public, autres" = "12"
    ),
    ANCOUT = c(
      "Moins de 400€" = "1",
      "400€ - 800€" = "2",
      "800€ - 1200€" = "3",
      "1200€ - 1600€" = "4",
      "1600€ - 2000€" = "5",
      "2000€ et plus" = "6",
      "Pas à ma charge" = "7",
      "Ne sait pas" = "8"
    ),
    ASSCOUT = c(
      "Moins de 400€" = "1",
      "400€ - 800€" = "2",
      "800€ - 1200€" = "3",
      "1200€ - 1600€" = "4",
      "1600€ - 2000€" = "5",
      "2000€ et plus" = "6",
      "Pas à ma charge" = "7",
      "Ne sait pas" = "8"
    ),
    REVENU = c(
      "Moins de 800€" = "1",
      "De 800 à 1200€" = "2",
      "De 1200 à 1600€" = "3",
      "De 1600 à 2000€" = "4",
      "De 2000 à 2400€" = "5",
      "De 2400 à 3000€" = "6",
      "De 3000 à 3500€" = "7",
      "De 3500 à 4500€" = "8",
      "De 4500 à 5500€" = "9",
      "5500€ et plus" = "10",
      "Refus" = "11",
      "Ne sait pas" = "12"
    )
  )

# Étiquettes de variables, table "Individus" ----

individus <- individus %>%
  var_labels(
    NQUEST = "Identifiant du ménage",
    NP = "Numéro de personne dans le ménage",
    POIDSP = "Poids de la personne",
    RESCOUR = "Couronne de résidence",
    RESDEP = "Département de résidence",
    RESSECT = "Secteur de résidence",
    RESCOMM = "Commune de résidence",
    RESC = "Carreau de résidence",
    JDEP = "Jour de la semaine où la personne a effectué les déplacements",
    TYPEP = "Type de personne",
    SEXE = "Sexe",
    LIENPREF = "Lien avec la personne de référence",
    AGE = "Âge",
    TRAGE = "Classes d'âge",
    PERMVP = "Permis de conduire voiture",
    ABONVP = "Abonnement autopartage",
    PERM2RM = "Permis de conduire 2RM",
    ABONTC = "Abonnement TC",
    ZONITC = "Zonage de l'abonnement TC (première zone)",
    ZONFTC = "Zonage de l'abonnement TC (dernière zone)",
    SUPPTC = "Support de l'abonnement",
    REMBTC = "% de l'abonnement à charge",
    ABONVLS = "Abonnement de Vélib ou VLS",
    DIPL = "Niveau d'étude atteint",
    OCCP = "Occupation principale",
    TYPLT = "Type du lieu de travail",
    CS24L = "Catégorie socioprofessionnelle / classe fréquentée",
    CS8 = "Catégorie socioprofessionnelle en 8 postes",
    CAT = "Catégorie de personne (Classes retenues pour le redressement)",
    ULTRAV = "Unicité du lieu de travail ou d'étude",
    LTRAVCOUR = "Couronne du lieu de travail / études principal",
    LTRAVDEP = "Département du lieu de travail / études principal",
    LTRAVSECT = "Secteur du lieu de travail / études principal",
    LTRAVCOMM = "Commune du lieu de travail / études principal",
    LTRAVC = "Carreau du lieu de travail / étude principal",
    PKVPTRAV = "Disponibilité d'un  parking au lieu de travail / étude",
    PKVLTRAV = "Disponibilité d'un  parking vélo au lieu de travail / étude",
    CHGTRAV = "Changement de lieu de travail depuis 2000",
    ANCHGTRAV = "Année de changement de lieu de travail depuis 2000",
    COMATRAV = "Commune du précédent lieu de travail",
    HANDI = "Gêne dans les déplacements en général",
    HANDI1 = "Type de gêne 1",
    HANDI2 = "Type de gêne 2",
    HANDI3 = "Type de gêne 3",
    HANDI4 = "Type de gêne 4",
    ACHINT = "Achats sur Internet",
    DEMINT = "Démarches administratives sur Internet",
    CONGE = "Congé, arrêt maladie",
    NONDEPL = "Déplacements hier",
    PERTURB = "Perturbations pour les déplacements",
    TPERTURB = "Type de perturbation",
    GENE = "Gêne temporaire ou permanente pour la journée enquêtée",
    PUVP = "Possibilité d'utiliser un véhicule motorisés conducteur (même si pas utilisé)",
    NBDEPL = "Nombre de déplacements réalisés",
    NBDEPLVP = "Nombre de déplacements réalisés en voiture (passager ou conducteur)",
    NBDEPLVPC = "Nombre de déplacements réalisés en voiture (conducteur)",
    NBDEPLTC = "Nombre de déplacements réalisés en transports collectifs",
    NBDEPLVELO = "Nombre de déplacements réalisés à vélo",
    NBDEPL2RM = "Nombre de déplacements réalisés en deux roues-motorisé",
    NBDEPLMAP = "Nombre de déplacements réalisés à pied",
    DDOMTRAV = "Portée du déplacement domicile - travail / études en kilomètres",
  )

# Étiquettes de valeurs, table "Individus" ----

individus <- individus %>%
  val_labels(
    RESCOUR = c(
      "Paris" = "1",
      "Petite couronne" = "2",
      "Grande couronne" = "3"
    ),
    RESDEP = c(
      "Paris" = "75",
      "Seine-et-Marne" = "77",
      "Yvelines" = "78",
      "Essonne" = "91",
      "Hauts-de-Seine" = "92",
      "Seine-Saint-Denis" = "93",
      "Val-de-Marne" = "94"
    ),
    JDEP = c(
      "Lundi" = "1",
      "Mardi" = "2",
      "Mercredi" = "3",
      "Jeudi" = "4",
      "Vendredi" = "5",
      "Samedi" = "6",
      "Dimanche" = "7"
    ),
    TYPEP = c(
      "Réside dans le logement une grande partie de l'année" = "1",
      "Logé ailleurs pour motif travail ou études" = "2",
      "Logé ici pour motif travail ou études" = "3"
    ),
    SEXE = c(
      "Homme" = "1",
      "Femme" = "2"
    ),
    LIENPREF = c(
      "Personne de référence" = "1",
      "Conjoint" = "2",
      "Enfant, gendre, belle-fille" = "3",
      "Ascendants, beaux-parents" = "4",
      "Petits-enfants" = "5",
      "Autres parents" = "6",
      "Employés de maison salariés et logés" = "7",
      "Autre non parent" = "8"
    ),
    TRAGE = c(
      "0 à 4 ans" = "0",
      "5 à 14 ans" = "1",
      "15 à 24 ans" = "2",
      "25 à 34 ans" = "3",
      "35 à 54 ans" = "4",
      "55 à 64 ans" = "5",
      "65 à 74 ans" = "6",
      "75 ans et plus" = "7"
    ),
    PERMVP = c(
      "Oui" = "1",
      "Non" = "2",
      "Conduite accompagnée, leçons" = "3"
    ),
    ABONVP = c(
      "Oui" = "1",
      "Non" = "2"
    ),
    PERM2RM = c(
      "Oui" = "1",
      "Non" = "2"
    ),
    ABONTC = c(
      "Non" = "1",
      "Carte Orange hebdomadaire ou Navigo semaine" = "2",
      "Carte Orange mensuelle ou Navigo Mois" = "3",
      "Carte Intégrale" = "4",
      "Carte Imagine’R scolaire" = "5",
      "Carte Imagine’R étudiant" = "6",
      "Carte Solidarité Transport 75% hebdomadaire" = "7",
      "Carte Solidarité Transport 75%  mensuelle" = "8",
      "Carte hebdo de travail (12 voyages)" = "9",
      "Abonnement scolaire ou carte OPTILE" = "10",
      "Carte Améthyste" = "11",
      "Carte Emeraude" = "12",
      "Carte Rubis" = "13",
      "Forfait Gratuité Transport" = "14",
      "Autre abonnement" = "15"
    ),
    SUPPTC = c(
      "Pass Navigo" = "1",
      "Pass Navigo Découverte" = "2"
    ),
    REMBTC = c(
      "0% (remboursement total)" = "1",
      "Moins de 25 %" = "2",
      "25%" = "3",
      "26% à moins de 50%" = "4",
      "50%" = "5",
      "51% à moins de 75%" = "6",
      "75%" = "7",
      "76% à moins de 100%" = "8",
      "100% (totalement à la charge de la personne)" = "9",
      "Ne sait pas" = "0"
    ),
    ABONVLS = c(
      "Oui, annuel" = "1",
      "Oui, hebdo" = "2",
      "Oui, journée" = "3",
      "Non" = "4"
    ),
    DIPL = c(
      "Personne en cours de scolarité" = "1",
      "Primaire" = "2",
      "Secondaire (de la 6ème à la 3ème)" = "3",
      "Secondaire (de la seconde à la terminale, BEP, CAP) et non titulaire du bac" = "4",
      "Secondaire et titulaire du bac" = "5",
      "Supérieur jusqu’à BAC + 2 (y compris BTS – DUT)" = "6",
      "Supérieur BAC + 3 et plus" = "7",
      "Apprentissage" = "8",
      "Autre formation postsecondaire (sanitaire et social ou artistique, …)" = "9",
      "La personne n’est jamais allée à l’école même en primaire" = "0"
    ),
    OCCP = c(
      "Exerce un métier, a un emploi, aide un membre de sa famille (emploi rémunéré) à plein temps (actif à  plein temps)" = "1",
      "Exerce un métier, a un emploi, aide un membre de sa famille (emploi rémunéré) à temps partiel (actif à temps partiel)" = "2",
      "Étudiant" = "3",
      "Élève d’un centre d’apprentissage avec contrat de qualification" = "4",
      "Élève du primaire ou du secondaire" = "5",
      "Chômeur ayant déjà travaillé" = "6",
      "Retraité, ancien salarié, retiré des affaires" = "7",
      "Chômeur n’ayant jamais travaillé" = "8",
      "Reste au foyer, personne sans profession" = "9",
      "Inactif, pensionné" = "0"
    ),
    TYPLT = c(
      "Bureau" = "1",
      "Commerce, boutique, grandes surfaces" = "2",
      "Entrepôt, usine, atelier" = "3",
      "Universités, collèges, lycées" = "4",
      "Hôpital" = "5",
      "Aéroports / gares" = "6",
      "Chez des particuliers" = "7",
      "Zones spéciales (Rungis, portuaires)" = "8",
      "Domicile" = "9",
      "Autres" = "10"
    ),
    CS24L = c(
      "Agriculteurs exploitants" = "10",
      "Artisans" = "21",
      "Commerçants et assimilés" = "22",
      "Chefs d'entreprise de 10 salariés ou plus" = "23",
      "Professions libérales et assimilés" = "31",
      "Cadres de la fonction publique, professions intellectuelles et artistiques, professeurs de lycée, professions scientifiques, profession de l’information, des arts et des spectacles" = "32",
      "Cadres d'entreprise, cadres administratifs, commerciaux ou techniques d’entreprise, ingénieurs" = "36",
      "Professions intermédiaires de l'enseignement, de la santé, de la fonction publique et assimilés, instituteurs, professeur d’enseignement général des collèges, services médicaux et sociaux, clergé" = "41",
      "Professions intermédiaires administratives et commerciales des entreprises" = "46",
      "Techniciens" = "47",
      "Contremaîtres, agents de maîtrise" = "48",
      "Employés de la fonction publique ; agents de service, aides soignantes, policiers, militaires, agents de surveillance" = "51",
      "Employés administratifs d'entreprise, secrétaires, employés de bureau" = "54",
      "Employés de commerce" = "55",
      "Personnels des services directs aux particuliers, nourrices, gens de maison, femmes de ménage" = "56",
      "Ouvriers qualifiés, ouvriers spécialisés, chauffeurs" = "61",
      "Ouvriers non qualifiés" = "66",
      "Ouvriers agricoles" = "69",
      "Maternelle ou Primaire (CP à CM2)" = "80",
      "Collège, 6ème" = "81",
      "Collège, 5ème" = "82",
      "Collège, 4ème" = "83",
      "Collège, 3ème" = "84",
      "Collège, SEGPA" = "85",
      "Technique court (CAP, BEP)" = "86",
      "Lycée, Seconde" = "87",
      "Lycée, 1ère" = "88",
      "Lycée, Terminale, niveau Bac ou Brevet professionnel" = "89",
      "Technique supérieur (IUT, BTS)" = "90",
      "1ère année de classe préparatoire (à des concours ou intégrée)" = "91",
      "2éme année de classe préparatoire (à des concours ou intégrée)" = "92",
      "Bac+1" = "93",
      "Bac+2" = "94",
      "Bac+3" = "95",
      "Bac+4" = "96",
      "Bac+5" = "97",
      "Bac+6 ou plus" = "98"
    ),
    CS8 = c(
      "Agriculteurs exploitants" = "1",
      "Artisans, commerçants et chefs d'entreprise" = "2",
      "Cadres et professions intellectuelles supérieures" = "3",
      "Professions Intermédiaires" = "4",
      "Employés" = "5",
      "Ouvriers" = "6",
      "Retraités" = "7",
      "Autres personnes sans activité professionnelle (élèves, étudiants...)" = "8"
    ),
    CAT = c(
      "Homme 0-4 ans" = "1",
      "Homme 5-11 ans" = "2",
      "Homme élèves étudiants 12-18 ans" = "3",
      "Homme élèves étudiants de + 18 ans" = "4",
      "Homme chômeurs" = "5",
      "Homme retraités de moins de 65 ans" = "6",
      "Homme 65 ans à 75 ans" = "7",
      "Homme plus de 75 ans" = "8",
      "Homme autres inactifs de 15 à 64 ans" = "9",
      "Homme actifs occ 15-64 ans agriculteurs exploitants en 2008" = "10",
      "Homme actifs occ 15-64 ans artisans, commerçants, chefs  d'entreprise en 2008" = "11",
      "Homme actifs occ 15-64 ans cadres professions intellectuelles  supérieures en 2008" = "12",
      "Homme actifs occ 15-64 ans professions intermédiaires en 2008" = "13", 
      "Homme actifs occupés 15-64 ans employés en 2008" = "14",
      "Homme Actifs occupés 15-64 ans ouvriers en 2008" = "15",
      "Femme 0-4 ans" = "16",
      "Femme 5-11 ans" = "17",
      "Femme élèves étudiantes 12-18 ans" = "18",
      "Femme élèves étudiantes de + 18 ans" = "19",
      "Femme chômeuses" = "20",
      "Femme retraitées de moins de 65 ans" = "21",
      "Femme 65 ans à 75 ans" = "22",
      "Femme plus de 75 ans" = "23",
      "Femme autres inactives de 15 à 64 ans" = "24",
      "Femme actives occ 15-64 ans agricultrices exploitantes en 2008" = "25",
      "Femme actives occ 15-64 ans artisans, commerçantes, chefs  d'entreprise en 2008" = "26",
      "Femme actives occ 15-64 ans cadres professions intellectuelles  supérieures en 2008" = "27",
      "Femme actives occ 15-64 ans professions intermédiaires en 2008" = "28",
      "Femme actives occupées 15-64 ans employées en 2008" = "29",
      "Femme Actives occupées 15-64 ans ouvrières en 2008" = "30"
    ),
    ULTRAV = c(
      "Oui, j'ai un seul lieu de travail / d'études habituel en dehors du domicile" = "1",
      "Oui, j'ai un seul lieu de travail / d'études habituel à domicile" = "2",
      "Non, je n'ai pas de lieu fixe de travail / d'études" = "3"
    ),
    LTRAVCOUR = c(
      "Paris" = "1",
      "Petite couronne" = "2",
      "Grande couronne" = "3"
    ),
    LTRAVDEP = c(
      "Paris" = "75",
      "Seine-et-Marne" = "77",
      "Yvelines" = "78",
      "Essonne" = "91",
      "Hauts-de-Seine" = "92",
      "Seine-Saint-Denis" = "93",
      "Val-de-Marne" = "94"
    ),
    PKVPTRAV = c(
      "Oui" = "1",
      "Non" = "2"
    ),
    PKVLTRAV = c(
      "Oui" = "1",
      "Non" = "2"
    ),
    CHGTRAV = c(
      "Oui" = "1",
      "Non" = "2"
    ),
    ANCHGTRAV = c(
      "2000" = "0",
      "2001" = "1",
      "2002" = "2",
      "2003" = "3",
      "2004" = "4",
      "2005" = "5",
      "2006" = "6",
      "2007" = "7",
      "2008" = "8",
      "2009" = "9",
      "2010" = "10",
      "2011" = "11"
    ),
    HANDI = c(
      "Oui" = "1",
      "Non" = "2"
    ),
    HANDI1 = c(
      "Orientation" = "1",
      "Audition" = "2",
      "Communication orale" = "3",
      "Motricité" = "4",
      "Vision" = "5",
      "Autre" = "6"
    ),
    HANDI2 = c(
      "Orientation" = "1",
      "Audition" = "2",
      "Communication orale" = "3",
      "Motricité" = "4",
      "Vision" = "5",
      "Autre" = "6"
    ),
    HANDI3 = c(
      "Orientation" = "1",
      "Audition" = "2",
      "Communication orale" = "3",
      "Motricité" = "4",
      "Vision" = "5",
      "Autre" = "6"
    ),
    HANDI4 = c(
      "Orientation" = "1",
      "Audition" = "2",
      "Communication orale" = "3",
      "Motricité" = "4",
      "Vision" = "5",
      "Autre" = "6"
    ),
    ACHINT = c(
      "Oui, au moins 1 fois par semaine" = "1",
      "Oui, moins souvent mais au moins une fois par mois" = "2",
      "Oui, moins de 1 fois par mois" = "3",
      "Non, jamais" = "4"
    ),
    DEMINT = c(
      "Oui, dès que possible" = "1",
      "Oui, de temps en temps" = "2",
      "Non, jamais" = "3"
    ),
    CONGE = c(
      "Congés hebdomadaires" = "1",
      "Congés / RTT toute la journée" = "2",
      "Congés ou RTT le matin" = "3",
      "Congés ou RTT l'après-midi" = "4",
      "Temps partiel toute la journée" = "5",
      "Temps partiel le matin" = "6",
      "Temps partiel l'après-midi" = "7",
      "Travail en horaires décalés" = "8",
      "Travail en horaires aménagés (femmes enceintes …)" = "9",
      "Arrêt maladie ou enfant malade toute la journée" = "10",
      "Arrêt maladie ou enfant malade le matin" = "11",
      "Arrêt maladie ou enfant malade l'après-midi" = "12",
      "Autre arrêt (grève, chômage technique …)" = "13",
      "Congé de maternité" = "14",
      "Aucune de ces situations" = "15"
    ),
    NONDEPL = c(
      "Oui" = "1",
      "Non, à cause de la grippe A" = "2",
      "Non, car incapacité permanente liée à des problèmes de santé" = "3",
      "Non, car incapacité temporaire liée à des problèmes de santé (membre cassé …)" = "4",
      "Non, car pas de moyen de locomotion motorisé à disposition ce jour là" = "5",
      "Non, car intempéries" = "6",
      "Non, n’est pas sorti de son domicile pour une autre raison" = "7",
      "Non, car se trouvait hier hors région Ile de France" = "8"
    ),
    PERTURB = c(
      "Oui" = "1",
      "Non" = "2"
    ),
    TPERTURB = c(
      "Grève dans les transports" = "1",
      "Grippe A" = "2",
      "Travaux" = "3",
      "Voiture ou moto en panne" = "4",
      "Mauvaises conditions météo" = "5",
      "Autres" = "6"
    ),
    GENE = c(
      "Permanente (fauteuil roulant, appareillage, mal voyant, mal entendant, handicap mental)" = "1",
      "Temporaire (membre cassé)" = "2",
      "Circonstances (jeunes enfants, poussette, valise)" = "3",
      "Pas de gêne" = "4"
    ),
    PUVP = c(
      "Oui" = "1",
      "Non" = "2"
    ),
  )


# Étiquettes de valeurs, table "Individus" (CS8_short) ----

individus_CS8_short <- individus %>%
  var_labels(
    CS8 = "PCS (niv. 1)"
  ) %>%
  val_labels(
    CS8 = c(
      "Agri." = "1",
      "Art." = "2",
      "CPIS" = "3",
      "P.I." = "4",
      "Empl." = "5",
      "Ouvr." = "6",
      "Retr." = "7",
      "Autres" = "8"
    )
  )

# Étiquettes de variables, table "Déplacements" ----

deplacements <- deplacements %>%
  var_labels(
    NQUEST = "Identifiant du ménage",
    NP = "Numéro de personne dans le ménage",
    ND = "Numéro de déplacement de la personne",
    POIDSP = "Poids de la personne réalisant le déplacement",
    JDEP = "Jour de la semaine où le déplacement est effectué",
    RESCOUR = "Couronne de résidence de la personne effectuant le déplacement",
    RESDEP = "Département de résidence de la personne effectuant le déplacement",
    RESSECT = "Secteur de résidence de la personne effectuant le déplacement",
    RESCOMM = "Commune de résidence de la personne effectuant le déplacement",
    RESC = "Carreau de résidence de la personne effectuant le déplacement",
    ORCOUR = "Couronne d'origine du déplacement",
    ORDEP = "Département d'origine du déplacement",
    ORSECT = "Secteur d'origine du déplacement",
    ORCOMM = "Commune d'origine du déplacement",
    ORC = "Carreau d'origine du déplacement",
    ORH = "Heure de départ",
    ORM = "Minute de départ",
    ORMOT = "Motif au départ",
    ORMOT_H9 = "Motif au départ (regroupé en 9 catégories)",
    DESTCOUR = "Couronne de destination du déplacement",
    DESTDEP = "Département de destination du déplacement",
    DESTSECT = "Secteur de destination du déplacement",
    DESTCOMM = "Commune de destination du déplacement",
    DESTC = "Carreau de destination du déplacement",
    DESTH = "Heure d'arrivée",
    DESTM = "Minute d'arrivée",
    DESTMOT = "Motif à l'arrivée",
    DESTMOT_H9 = "Motif à l'arrivée (regroupé en 9 catégories)",
    DESTMOT_IAURIF02 = "Motif à l'arrivée (définition IAURIF)",
    MOTIF_COMBINE = "Motif combiné origine / destination",
    DPORTEE = "Portée du déplacement en kilomètres (pour interne IdF)",
    DUREE = "Durée du déplacement en minutes (pour interne IdF)",
    ACCMOT = "Motif de la personne accompagnée",
    ACCMOT_H9 = "Motif de la personne accompagnée (regroupé en 9 catégories)",
    ACCNP = "Numéro de la personne accompagnée si personne du ménage",
    TLT = "Type de lieu de travail (si destination = lieu de travail)",
    TLA = "Type de lieu d'achat (si destination = lieu d'achat)",
    NBAT = "Nombre d'arrêts dans la tournée",
    TRP = "Avez-vous traversé Paris intra muros pendant le déplacement",
    MODP_STRICT = "Mode principal strict détaillé",
    MODP_H6 = "Mode principal en 6 modalités",
    MODP_H7 = "Mode principal en 7 modalités",
    MODP_H12 = "Mode principal en 12 modalités",
    MODP_H19 = "Mode principal en 19 modalités",
    NBTRAJ = "Nombre de trajets réalisés dans le déplacement",
    NBTRAJVP = "Nombre de trajets réalisés en voiture (passager ou conducteur) dans le déplacement",
    NBTRAJVPC = "Nombre de trajets réalisés en voiture (conducteur) dans le déplacement",
    NBTRAJTC = "Nombre de trajets réalisés en transports collectifs dans le déplacement",
    NBTRAJVELO = "Nombre de trajets réalisés à vélo dans le déplacement",
    NBTRAJ2RM = "Nombre de trajets réalisés en deux roues-motorisé dans le déplacement",
    IDM = "Indicateur de déplacement motorisé",
    NBCO = "Nombre de correspondances si déplacement effectué en transports collectifs",
    RAB_TC = "Mode principal de rabattement vers les transports collectifs (avant d'emprunter la première ligne de transports collectifs du déplacement)",
    DIFF_TC = "Mode principal de diffusion depuis les transports collectifs (après avoir emprunté la dernière ligne de transports collectifs du déplacement)",
  )

# Modes et motifs ----

## Détail des motifs (ORMOT, DESTMOT, ACCMOT) ----
motifs <- c(
  "Domicile habituel (celui où la personne est enquêtée)" = "1",
  "Un des domiciles correspondant à une garde alternée" = "2",
  "Résidence secondaire, logement occasionnel, hôtel, autre domicile" = "3",
  "Travail sur le lieu de travail déclaré dans la fiche personne" = "11",
  "Travail sur un autre lieu (hors affaires professionnelles)" = "12",
  "Affaires professionnelles hors lieu de travail habituel (RV professionnel, réunion, etc.)" = "13",
  "Tournée professionnelle" = "14",
  "Repas d’affaires, déjeuner professionnel" = "15",
  "Pause déjeuner durant la journée de travail (cantine, cafétéria, restaurant situés hors du lieu de travail…)" = "16",
  "Autre restauration hors domicile (restaurant, bar, café, cybercafé…)" = "17",
  "Nourrice, crèche, garde d’enfants" = "21",
  "Études sur le lieu d'études déclaré (école maternelle et primaire)" = "22",
  "Études sur le lieu d'études déclaré (enseignement secondaire : collège et lycée)" = "23",
  "Études sur le lieu d'études déclaré (enseignement supérieur, universités et grandes écoles)" = "24",
  "Études sur un autre lieu (école maternelle et primaire)" = "25",
  "Études sur un autre lieu (enseignement secondaire : collège et lycée)" = "26",
  "Études sur un autre lieu (enseignement supérieur, universités et grandes écoles)" = "27",
  "Achats quotidiens (pain, journal, …)" = "31",
  "Achats hebdomadaires ou bi hebdomadaires" = "32",
  "Achats occasionnels (livres, vêtements, électroménager, musique, meubles etc.)" = "33",
  "Participation à une activité sportive, culturelle, associative ou religieuse" = "41",
  "Promenade, lèche-vitrines (sans achat), leçons de conduite" = "42",
  "Visite à des parents" = "43",
  "Visite à des amis" = "44",
  "Spectacle, exposition, cinéma, musée, théâtre, concert, match de foot…" = "45",
  "Voyage, sortie touristique" = "46",
  "Autres loisirs" = "47",
  "Démarches administratives" = "50",
  "Recherche d’emploi (y. entretiens)" = "51",
  "Aide ou soins à des proches" = "52",
  "Santé (hôpital, clinique)" = "53",
  "Santé autres (consultation professionnel de la santé hors hôpital : médecin, dentiste, kiné, etc.)" = "54",
  "Affaires personnelles autres (avocat, notaire, garage, réunion parents d’élèves, réunion de copropriétaires etc.)" = "55",
  "Dépose d’une personne à un mode de transport (station, gare, arrêt de bus, aéroport…)" = "61",
  "Reprise d’une personne à un mode de transport (station, gare, arrêt de bus, aéroport…)" = "62",
  "Accompagner quelqu’un dans un lieu autre qu’un mode de transport (école, garderie, amis, cinéma, sport, travail etc.)" = "63",
  "Aller chercher quelqu’un (dans un lieu autre qu’un mode de transport (école, garderie, amis, cinéma, sport, travail etc.)" = "64",
  "Autre motif" = "98"
)

## Motifs simplifiés (ORMOT_H9, ) ----

motifs_9cat <- c(
  "Domicile" = "1",
  "Travail" = "2",
  "Autre travail" = "3",
  "Etudes" = "4", 
  "Achats" = "5",
  "Affaires perso" = "6",
  "Accompagnement" = "7",
  "Loisirs / visites" = "8",
  "Autres" = "9"
)

## Mode principal strict détaillé (MODP_STRICT) ----

mode_strict <- c(
  "MAP" = "41",
  "Train de banlieue SNCF" = "1",
  "RER" = "2",
  "Orly Val" = "4",
  "Métro" = "3",
  "Tramway" = "5",
  "TVM" = "6",
  "Bus RATP Paris" = "7",
  "Bus RATP banlieue" = "8",
  "Bus OPTILE" = "9",
  "Noctilien" = "10",
  "Bateau bus / Vogueo" = "11",
  "TAD" = "14",
  "Transport Employeur" = "12",
  "Ramassage Scolaire" = "13",
  "Thandicapé" = "15",
  "Autres TPC" = "16",
  "Taxi" = "17",
  "Avion" = "37",
  "TGV" = "38",
  "Grandes Lignes SNCF autre que TGV" = "39",
  "TER" = "40",
  "VP Conducteur" = "21",
  "VP Cond Covoit" = "20",
  "VU1 Cond" = "19",
  "VU2 Cond" = "18",
  "Cond 2RM Non Immat" = "27",
  "Cond 2RM" = "26",
  "VP Pass" = "25",
  "VP Pass Covoit" = "24",
  "VU1 Pass" = "23",
  "VU2 Pass" = "22",
  "Pass 2RM NI" = "29",
  "Pass 2RM" = "28",
  "Velib" = "31",
  "Autre VLS" = "32",
  "Vélo" = "33",
  "VAE" = "30",
  "Fauteuil / voiturette" = "34",
  "Roller, skate, trot" = "35",
  "Autre" = "36"
)

## Mode principal en 19 catégories (MODP_H19) ----

mode_principal <- c(
  "Train de banlieue SNCF" = "1",
  "RER" = "2",
  "Métro tramway Val" = "3",
  "TVM" = "4",
  "Bus RATP Paris" = "5",
  "Bus RATP banlieue" = "6",
  "Bus OPTILE" = "7",
  "Noctilien" = "8",
  "Bateau bus / Vogueo" = "9",
  "Transport Scolaire-Employeur" = "10",
  "TAD" = "11",
  "Thandicapé" = "12",
  "Autres TPC" = "13",
  "Taxi" = "14",
  "VP-VU" = "15",
  "2RM" = "16",
  "Vélo" = "17",
  "Autre" = "18",
  "MAP" = "19"
)

## Détail des moyens de transport des trajets (MOYEN)

moyen <- c(
  "Marche à pied" = "1",
  "Train de banlieue SNCF(Transilien)" = "10",
  "RER (Lignes A, B, C, D, E)" = "11",
  "Orly-Val" = "12",
  "Métro" = "13",
  "Tramway (y compris le T4)" = "14",
  "TVM" = "15",
  "Autobus Paris RATP" = "16",
  "Autobus de banlieue RATP" = "17",
  "Autre autobus de banlieue OPTILE (ex APTR,ADATRIF)" = "18",
  "Noctilien (bus de nuit ex Noctambus)" = "19",
  "Bateau bus – Voguéo" = "20",
  "Transport à la demande" = "30",
  "Transports employeurs" = "31",
  "Ramassage scolaire" = "32",
  "Société de service spécialisée dans le transport des handicapés" = "33",
  "Autres transports privés collectifs (navettes, …)" = "34",
  "Taxi" = "35",
  "Avion" = "40",
  "TGV" = "41",
  "Grande ligne SNCF autre que TGV" = "42",
  "TER" = "43",
  "Conducteur voiture particulière" = "50",
  "Conducteur dans un système de covoiturage organisé" = "51",
  "Conducteur véhicule utilitaire 800 à 1 000 kg" = "52",
  "Conducteur véhicule utilitaire de 1 000 kg ou plus" = "53",
  "Conducteur véhicule à 2 (ou 3) roues à moteur non immatriculé" = "54",
  "Conducteur véhicule à 2 (ou 3) roues à moteur immatriculé" = "55",
  "Vélib'" = "60",
  "Autre vélo en libre service" = "61",
  "Vélo personnel" = "62",
  "Vélo personnel à assistance électrique" = "63",
  "Passager d’une voiture particulière" = "70",
  "Passager dans un système de covoiturage organisé" = "71",
  "Passager d’un véhicule utilitaire 800 à 1 000 kg" = "72",
  "Passager  véhicule utilitaire de 1 000 kg ou plus" = "73",
  "Passager d’un véhicule à 2 (ou 3) roues à moteur non immatriculé" = "74",
  "Passager d’un véhicule à 2 (ou 3) roues à moteur immatriculé" = "75",
  "Fauteuil roulant avec ou sans moteur, voiturette  (handicapés)" = "80",
  "Rollers, skate, trottinette" = "81",
  "Autre moyen de transport" = "82"
)

# Étiquettes de valeurs, table "Déplacements" ----

deplacements <- deplacements %>%
  val_labels(
    JDEP = c(
      "Lundi" = "1",
      "Mardi" = "2",
      "Mercredi" = "3",
      "Jeudi" = "4",
      "Vendredi" = "5",
      "Samedi" = "6",
      "Dimanche" = "7"
    ),
    RESCOUR = c(
      "Paris" = "1",
      "Petite couronne" = "2",
      "Grande couronne" = "3"
    ),
    RESDEP = c(
      "Paris" = "75",
      "Seine-et-Marne" = "77",
      "Yvelines" = "78",
      "Essonne" = "91",
      "Hauts-de-Seine" = "92",
      "Seine-Saint-Denis" = "93",
      "Val-de-Marne" = "94"
    ),
    ORCOUR = c(
      "Paris" = "1",
      "Petite couronne" = "2",
      "Grande couronne" = "3"
    ),
    ORDEP = c(
      "Paris" = "75",
      "Seine-et-Marne" = "77",
      "Yvelines" = "78",
      "Essonne" = "91",
      "Hauts-de-Seine" = "92",
      "Seine-Saint-Denis" = "93",
      "Val-de-Marne" = "94"
    ),
    ORMOT = !!motifs,
    ORMOT_H9 = !!motifs_9cat,
    DESTCOUR = c(
      "Paris" = "1",
      "Petite couronne" = "2",
      "Grande couronne" = "3"
    ),
    DESTDEP = c(
      "Paris" = "75",
      "Seine-et-Marne" = "77",
      "Yvelines" = "78",
      "Essonne" = "91",
      "Hauts-de-Seine" = "92",
      "Seine-Saint-Denis" = "93",
      "Val-de-Marne" = "94"
    ),
    DESTMOT = !!motifs,
    DESTMOT_H9 = !!motifs_9cat,
    DESTMOT_IAURIF02 = c(
      "Travail" = "1",
      "Affaires professionnelles" = "2",
      "École" = "3",
      "Loisirs" = "4",
      "Achats" = "5",
      "Affaires personnelles" = "6",
      "Domicile" = "7"
    ),
    MOTIF_COMBINE = c(
      "Domicile <-> Travail" = "1",
      "Domicile <-> Études" = "2",
      "Domicile <-> Achats" = "3",
      "Domicile <-> Affaires perso" = "4",
      "Domicile <-> Accompagnement" = "5",
      "Domicile <-> Loisirs / visites" = "6",
      "Domicile <-> Autres" = "7",
      "Secondaire lié au travail" = "8",
      "Secondaire non lié au travail" = "9"
    ),
    ACCMOT = !!motifs,
    ACCMOT_H9 = !!motifs_9cat,
    TLT = c(
      "Un bureau (siège social d’entreprise, administration)" = "1",
      "Un commerce, une boutique" = "2",
      "Un entrepôt, une usine, un atelier" = "3",
      "Une université" = "4",
      "Un hôpital" = "5",
      "Un aéroport" = "6",
      "Chez des particuliers" = "7",
      "Zones spéciales (portuaires, Rungis, etc.)" = "8",
      "Autres" = "9"
    ),
    TLA = c(
      "Petit commerce" = "1",
      "Supérette" = "2",
      "Supermarché" = "3",
      "Grande surface" = "4",
      "Hypermarché" = "5",
      "Centre commercial" = "6",
      "Grands magasins" = "7",
      "Marché" = "8",
      "Marché aux puces" = "9"
    ),
    TRP = c(
      "Oui" = "1",
      "Non" = "2"
    ),
    MODP_STRICT = !!mode_strict,
    MODP_H6 = c(
      "TC" = "1",
      "VP" = "2",
      "2RM" = "3",
      "Vélo" = "4",
      "Autres (dont taxi)" = "5",
      "MAP" = "6"
    ),
    MODP_H7 = c(
      "TC" = "1",
      "VPC" = "2",
      "VPP" = "3",
      "2RM" = "4",
      "Vélo" = "5",
      "Autres (dont taxi)" = "6",
      "MAP" = "7"
    ),
    MODP_H12 = c(
      "TC (Ferré lourd)" = "1",
      "TC (Ferré)" = "2",
      "TC (Tram)" = "3",
      "TC (Bus)" = "4",
      "TC (Autre)" = "5",
      "VPC" = "6",
      "VPP" = "7",
      "Taxi" = "8",
      "2RM" = "9",
      "Vélo" = "10",
      "Autres" = "11",
      "MAP" = "12"
    ),
    MODP_H19 = !!mode_principal,
    IDM = c(
      "Déplacement non motorisé" = "0",
      "Déplacement motorisé" = "1"
    ),
    RAB_TC = !!moyen,
    DIFF_TC = !!moyen,
  )

# Étiquettes de variables, table "Trajets" ----

trajets <- trajets %>%
  var_labels(
    NQUEST = "Identifiant du ménage",
    NP = "Numéro de personne dans le ménage",
    ND = "Numéro de déplacement de la personne",
    NT = "Numéro de trajet dans le déplacement",
    POIDSP = "Poids de la personne réalisant le trajet",
    JDEP = "Jour de la semaine où le trajet est effectué",
    MOYEN = "Mode utilisé pour le trajet",
    TT = "Titre de transport utilisé",
    LIGNE = "Ligne utilisée (métro, RER)",
    ENTC = "Carreau d'entrée dans le mode",
    SORTC = "Carreau de sortie du mode",
    TPORTEE = "Portée du trajet en kilomètres (pour les trajets des déplacements internes IdF)",
    TYPV = "Numéro du véhicule du ménage utilisé",
    TSTAT = "Type de stationnement",
    NBPV = "Nombre de personnes dans le véhicule (passagers + conducteurs)",
    LSC = "Stationnement connu à la destination",
    UTP = "Emprunté le périphérique",
    UTA86 = "Emprunté l'A86",
    UTFRL = "Emprunté la francilienne",
    SRES = "Stationnement réservé à destination liée au travail",
    REMBF = "Remboursement des frais du véhicule par employeur",
    PCT = "Coût du trajet à charge",
  )

# Étiquettes de valeurs, table "Trajets" ----

trajets <- trajets %>%
  val_labels(
    JDEP = c(
      "Lundi" = "1",
      "Mardi" = "2",
      "Mercredi" = "3",
      "Jeudi" = "4",
      "Vendredi" = "5",
      "Samedi" = "6",
      "Dimanche" = "7"
    ),
    MOYEN = !!moyen,
    TT = c(
      "Carte Orange hebdomadaire ou Navigo semaine" = "1",
      "Carte Orange mensuelle ou Navigo mois" = "2",
      "Carte Intégrale" = "3",
      "Carte hebdomadaire de travail (12 voyages)" = "4",
      "Carte Imagine’R Scolaire ou Imagine’R Etudiant" = "5",
      "Abonnement scolaire ou carte Optile" = "6",
      "Carte CST (carte solidarité transport)" = "7",
      "Carte Améthyste, Emeraude, Rubis" = "8",
      "Ticket t+ acheté à l’unité" = "9",
      "Ticket t+ acheté en carnet plein tarif" = "10",
      "Ticket t+ acheté en carnet ½ tarif" = "11",
      "Ticket d’accès à bord (TAB)" = "13",
      "Billet banlieue acheté à l’unité plein tarif" = "14",
      "Billet banlieue acheté à l’unité, ½ tarif" = "15",
      "Billet banlieue acheté en carnet plein tarif" = "16",
      "Billet banlieue acheté en carnet ½ tarif" = "17",
      "Mobilis" = "18",
      "Ticket Jeune" = "19",
      "Autre titre de transport Gratuit" = "20",
      "Pas de titre de transport (fraude)" = "21",
      "Autre titre de transport" = "22"
    ),
    TYPV = c(
      "Véhicule 1" = "1",
      "Véhicule 2" = "2",
      "Véhicule 3" = "3",
      "Véhicule 4" = "4",
      "Autre véhicule du ménage" = "5",
      "Véhicule de location" = "6",
      "Véhicule en Autolib ou Autopartage" = "7",
      "Véhicule de l’entreprise" = "8",
      "Autre véhicule" = "9"
    ),
    TSTAT = c(
      "Dépose minute" = "1",
      "Stationnement Payant à durée limitée" = "2",
      "Stationnement Payant à tarif préférentiel résidents" = "3",
      "Stationnement Gratuit durée illimitée" = "4",
      "Stationnement Gratuit durée limitée (zone bleue)" = "5",
      "Stationnement Non autorisé" = "6",
      "Propriétaire" = "7",
      "Locataire" = "8",
      "À titre gratuit" = "9",
      "Parc relais (parc de rabattement à une gare) à titre gratuit" = "10",
      "Parc relais (parc de rabattement à une gare) à titre payant" = "11",
      "Autre gratuit" = "12",
      "Autre propriétaire" = "13",
      "Autre abonné, locataire avec ou sans réservation" = "14",
      "Autre payant horaire" = "15",
      "Autre stationnement" = "16"
    ),
    LSC = c(
      "Oui" = "1",
      "Non" = "2"
    ),
    UTP = c(
      "Oui" = "1",
      "Non" = "2",
      "Ne sait pas" = "3"
    ),
    UTA86 = c(
      "Oui" = "1",
      "Non" = "2",
      "Ne sait pas" = "3"
    ),
    UTFRL = c(
      "Oui" = "1",
      "Non" = "2",
      "Ne sait pas" = "3"
    ),
    SRES = c(
      "Oui" = "1",
      "Non" = "2"
    ),
    REMBF = c(
      "Oui" = "1",
      "Non" = "2"
    ),
    PCT = c(
      "Ou, totalement" = "1",
      "Oui, partiellement" = "2",
      "Non, pas du tout" = "3"
    )
  )

# Suppression des variables temporaires ----

rm(mode_strict, mode_principal, motifs, motifs_9cat, moyen)