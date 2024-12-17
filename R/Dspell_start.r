#' Compute the dry spell at the begining of the rainy season
#'
#' Dspell_start function compute the dry spell at the begining of the rainy season.
#' @param x the rainfall vector
#' @param threshold the default value of rain quantity to be counted as a rainy day
#' @param period period of time in days from rain start to bloom
#' @param from from which element of x to start
#' @param Tolastrain this parameter controls the endpoint of the dry spell period
#' @return result is a consecutive number of dry days
#' @examples
#'
#'
#'
#' @export


Dspell_start <- function(x, from = dt_start(x), period = 50, threshold = .85, Tolastrain = TRUE){


  if (is.na(from)) return(NA)

  to <- from + period

  if (Tolastrain) { to <- begin_to_end(x, from = from , period = period) }

  return( dry_spell(x[from:to]))

}
