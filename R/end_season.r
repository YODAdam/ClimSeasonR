#' Compute the end of the rainy season
#'
#' dry_spell function compute the end of the rainy season in julian days using water balance methode.
#' @param x the rainfall vector
#' @param threshold the default value of rain quantity to be counted as a rainy day
#' @param replaceNA Replace missing values by a specified value defaulted to 0.0 mm
#' @param NAvalues missing data replacement values
#' @param MaxNAPercent maximum percentage of missing data
#' @param from from which element of x to start
#' @param to last element for dry spell computing
#' @param soil_cap maximum capacity of water storage of th soil (default to 70.0 in Burkina Faso)
#' @param UseLastFull use late full storage date to starte calculation
#' @return result is a consecutive number of dry days
#' @examples
#'
#'
#'
#' @export


end_season <- function(x, from = 245, to = length(x), replaceNA = FALSE, NAValues = 0.0, soil_cap = 70.0, UseLastFull = FALSE, daily_etp = 5.0) {


  # if (NAPercent(x) > NaMaxPercent) return (NA)

  bilan <- soil_cap

  count <- 0

  later_date <-  from

  if (UseLastFull) later_date <- dateoflastefull(x = x)


  if(is.na(later_date)) return(NA)


  x <- x[later_date:to]



  if (replaceNA) { x[is.na(x)]= NAValues } else if (any(is.na(x))) {return (NA)}

  for (i in x) {

    count <- count + 1

    bilan <- sum(c(bilan ,i ,- daily_etp),na.rm = T)

    if (bilan > soil_cap) {

      bilan <- soil_cap

      } else if (bilan <= 0.0){

        break
      }

  }

  return(count + later_date)
}
