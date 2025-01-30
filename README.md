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

## Installation

```R
install.packages("remotes") # Install remotes if not already installed 
remotes::install_github("YODAdam/ClimSeasonR")

````
## Quick Usage Example

### Loading libraries and importing dataset

The code below start by importing a set of data, extracting on year rainfall data for a station an a specifique year.

```{r}
library(ClimSeasonR)
library(dplyr)  ## install if you dn't have it
library(readr)

## importing dataset

data <-  read_csv(file = "data.csv")

Ouaga_rain_2020 <- data %>% 
  filter(Station_Name == 'Ouagadougou', Year == 2020) %>% 
  pull(var = Rain)

```
### Start of the season

The code below try to find the first time we have 20 mm of rain `SumVdays` over 3 days `n_Vdays` without more that 20 concecutive dry days `maxDrySpell_aft` in the following  30 days `onMaxdays`.
```{r}

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
