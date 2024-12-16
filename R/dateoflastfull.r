#' @title Compute the last dates of soil full capacity
#' @description
#' dateoflastefull compute the laste date of the soil full capacity starting from the begin of vector x
#' @param x the rainfall vector
#' @param threshold the default value of rain quantity to be counted as a rainy day
#' @param replaceNA Replace missing values by a specified value defaulted to 0.0 mm
#' @param NAvalues missing data replacement values
#' @param from from which element of x to start
#' @param to last element for dry spell computing
#' @param soil_cap maximum capacity of water storage of th soil (default to 70.0 in Burkina Faso)
#' @return result is a julian day (integer)
#' @examples
#'
#'
#'
#' @export


dateoflastefull <- function(x, from = 1, to = length(x), soil_cap = 70.0, replaceNA = TRUE, NAValues = 0.0) {


  if (length(x) == 0) {
    return(NA)
  }

  if (replaceNA) x[is.na(x)] <- NAValues else if (any(is.na(x))) {

    warning('Missing data in vector x without replacement options: NA returned')
    return( NA)

  }





  bilan <- 0.0
  ful_day <- to
  compteur <- 0
  ful_flag <- 0

  for(i in x[from:to]){


    compteur <- compteur + 1
    bilan <- bilan + (i - daily_etp)

    if (bilan < 0.0) {

      bilan <- 0.0
    }

    if (bilan >= soil_cap ){

      bilan <- soil_cap
      ful_day <- compteur
      ful_flag <- ful_flag + 1

    }
  }

  if (ful_day < from) ful_day <- NA


  return (ful_day)
}
