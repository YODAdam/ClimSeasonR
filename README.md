# ClimSeasonR
An R Package for Agroclimatic Analysis of the Rainy Season

## Introduction

This R package provides tools to estimate key agroclimatic characteristics of the rainy season based on Sivakumar's principle. It allows users to calculate:

- 📅 Start of the season (SOS)
- 📅 End of the season (EOS)
- 🌵 Dry spells at the beginning and end of the season
- 🌧️ Total rainfall during the season
- 📈 Other essential agroclimatic parameters
Designed for researchers, agronomists, and climatologists, this package helps analyze rainfall data to improve crop management and climate risk assessment.

## Principe de la Méthode de Sivakumar

- **Date de début de saison** : Lorsque 20 mm de pluie sont enregistrés sur trois jours consécutifs après le 1ᵉʳ mai, sans qu'une période sèche de plus de sept jours ne survienne dans les 30 jours suivants.
- **Date de fin de saison** : Dernier jour après le 1ᵉʳ septembre où une pluie d'au moins 5 mm est suivie d'une période sèche d'au moins 10 jours.

## Installation

```R
install.packages("remotes") # Install remotes if not already installed 
remotes::install_github("YODAdam/ClimSeasonR")

````
## Quick Usage Example

### Loading libraries and importing dataset

The code below start by importing a set of data, extracting on year rainfall data for a station an a specifique year.

```r
library(ClimSeasonR)
library(dplyr)  ## install if you dn't have it
library(readr)

## importing dataset

## a dataset with Station, Year, Month, Day and Rain as columns
data <-  read_csv(file = "data.csv")

## Ouagadougou is juste une of the stations
## we extract a rainfall vector for ouagadougou and 2020.

Ouaga_rain_2020 <- data %>% 
  filter(Station_Name == 'Ouagadougou', Year == 2020) %>% 
  pull(var = Rain)

```
### Start of the season

The code below try to find the first time we have 20 mm of rain `SumVdays` over 3 days `n_Vdays` without more that 20 concecutive dry days `maxDrySpell_aft` in the following  30 days `onMaxdays`.
```r

SOS <- ClimSeasonR::dt_start(
  x = Ouaga_rain_2020, 
  early = 91, 
  limit = 200, 
  SumVdays = 20.0, 
  n_Vdays = 3, 
  maxDrySpell_aft = 20, 
  onMaxdays = 30
  
)

```


### End of the season

The code below compute the end of the season starting from julian day 245 `from` supposing a soil with maximum capacity of 70 mm `soil_cap` and a daily mean evapotranspiration of 5 mm `daily_etp`.

```r

EOS <- ClimSeasonR::end_season(
  x = Ouaga_rain_2020, 
  from = 245, 
  soil_cap = 70, 
  daily_etp = 5.0
)

```

### Dry spell between the start and the end of the season

We can now compute the maximum dry spell between the start an the end of the season.

The code below will compute the maximum dry spell between the end and the start of the season by taking as rainy day threshold 0.85 mm of rain.

```r

MDS <- Ouaga_rain_2020[SOS:EOS] %>%  # taking values between start and end
  ClimSeasonR::dry_spell(threshold = 0.85, return_max = TRUE)

```

### Dry spell at the beging of the season

The code below will compute the dry spells at the begining of the season from the start to 50 days `period` commonly known as the bloom date.

```r

Dspell_Beging <- Dspell_start(x = Ouaga_rain_2020, 
                              period = 50, 
                              Tolastrain = TRUE)

```
### Dry spell at the end of the season

The code below will compute the dry spell at the end of the season from bloom date to the end of the season.

```r

Dspell_end <- Dspell_end(x = Ouaga_rain_2020, Fromlastrain = TRUE)

```
### Dry spells in the season

```r

## all dry spells in the season

all_Dspells <- dry_spell(x = Ouaga_rain_2020[dt_start(Ouaga_rain_2020):end_season(Ouaga_rain_2020)], return_max = FALSE)

```
### Combine all that with `dplyr` functions

Now we will try to compute all parameters for everystation and every years at once using `group_by` and `summarize` from `dplyr`.

```r

params_tbl <- 
  data %>% 
  group_by(Station_Name, Year) %>% 
  summarize(
    
    season_start = dt_start(Rain),
    season_end = end_season(Rain),
    dry_spell_start = Dspell_start(Rain),
    dry_spell_end = Dspell_end(Rain)
  )

print(params_tbl)

```

## Références

1. **Sivakumar, M. V. K. (1988).** "Predicting rainy season potential from the onset of rains in southern Sahelian and Sudanian climatic zones of West Africa." *Agricultural and Forest Meteorology, 42(4), 295-305.*
2. **Ozer, P. (2001).** "Analyse pluviométrique au Niger." *Bulletin de la Société Géographique de Liège, 42, 49-59.* ([Lien](https://orbi.uliege.be/bitstream/2268/16133/1/OZER_NIAMEY1.pdf))
3. **Sivakumar, M. V. K., & Awesso, Y. (1996).** "Agroclimatology of West Africa: Togo." *Information Bulletin No. 49, ICRISAT.* ([Lien](https://climatology.edpsciences.org/articles/climat/full_html/2010/01/climat20107p89/climat20107p89.html))
4. **Marteau, R., et al. (2011).** "Démarrage de la saison des pluies et date de semis du mil dans le sud-ouest du Niger." *Sécheresse, 22(2), 87-97.* ([Lien](https://horizon.documentation.ird.fr/exl-doc/pleins_textes/divers16-04/010051275.pdf))
5. **Balme, M., Galle, S., & Lebel, T. (2005).** "Démarrage de la saison des pluies au Sahel." *Sécheresse, 16(1), 15-22.* ([Lien](https://iri.columbia.edu/~ousmane/print/Onset/BalmeGalleLebel05_Secheresse.pdf))

## Utilisation

1. Cloner ce dépôt :
   ```bash
   git clone https://github.com/votre-repo.git
   ```
2. Exécuter le script d'analyse (exemple en R) :
   ```r
   source("calculate_season.R")
   ```

## Contributions
Les contributions sont les bienvenues ! Veuillez soumettre une pull request pour toute amélioration ou correction.
