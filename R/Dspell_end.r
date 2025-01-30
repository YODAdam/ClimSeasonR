#' Compute the dry spell at the end of the season
#'
#' Dspell_end function compute the dry spell at the end of the rainy season.
#' @param x the rainfall vector
#' @param threshold rain threshold. Minimum rain quantity to be considered as a beneficial rain
#' @param Fromstart This parameter control how many days from the start of the season to look for end spell
#' @param Fromlastrain this parameter controle if to start from a rainy day or not
#' @param from from which element of x to start
#' @param to laste date for the computation it usually correspond to the end of the season.
#' @return result is a consecutive number of dry days
#' @examples
#'
#'
#'
#' @export

Dspell_end <- function(x, from = dt_start(x) ,  to = end_season(x), Fromstart = 50, threshold = 0.85, Fromlastrain = TRUE) {


  if (is.na(from)) {return(NA)}

  start <- from + Fromstart

  if (Fromlastrain) {start <- begin_to_end(x, from = from, period = Fromstart, threshold = threshold) }

  return( dry_spell(x[ start:to], threshold = threshold, return_max = TRUE))

}
