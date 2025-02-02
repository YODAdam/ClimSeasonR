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

## Sivakumar's Method Principle

- **Start date of the season**: When 20 mm of rain is recorded over three consecutive days after May 1st, without a dry spell of more than seven days occurring within the following 30 days.
- **End date of the season**: The last day after September 1st when at least 5 mm of rain is followed by a dry period of at least 10 days.


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
## References

1. **Sivakumar, M. V. K. (1988).** "Predicting rainy season potential from the onset of rains in southern Sahelian and Sudanian climatic zones of West Africa." *Agricultural and Forest Meteorology, 42(4), 295-305.*
2. **Ozer, P. (2001).** "Rainfall analysis in Niger." *Bulletin of the Geographic Society of Liège, 42, 49-59.* ([Link](https://orbi.uliege.be/bitstream/2268/16133/1/OZER_NIAMEY1.pdf))
3. **Sivakumar, M. V. K., & Awesso, Y. (1996).** "Agroclimatology of West Africa: Togo." *Information Bulletin No. 49, ICRISAT.* ([Link](https://climatology.edpsciences.org/articles/climat/full_html/2010/01/climat20107p89/climat20107p89.html))
4. **Marteau, R., et al. (2011).** "Start of the rainy season and millet sowing date in southwest Niger." *Sécheresse, 22(2), 87-97.* ([Link](https://horizon.documentation.ird.fr/exl-doc/pleins_textes/divers16-04/010051275.pdf))
5. **Balme, M., Galle, S., & Lebel, T. (2005).** "Onset of the rainy season in the Sahel." *Sécheresse, 16(1), 15-22.* ([Link](https://iri.columbia.edu/~ousmane/print/Onset/BalmeGalleLebel05_Secheresse.pdf))

## Usage

1. Clone this repository:
   ```bash
   git clone https://github.com/YODAdam/ClimSeasonR.git
   ```

## Contributions
Contributions are welcome! Please submit a pull request for any improvements or corrections.
