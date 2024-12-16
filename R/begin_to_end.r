#' @title Compute the starting point of the dry spell computation at the begining of the rainy season
#' @description
#' dry_spell function compute the end of the rainy season in julian days using water balance methode.
#' @param x the rainfall vector
#' @param threshold the default value of rain quantity to be counted as a rainy day
#' @param period period of time in days from rain start to bloom
#' @param from from which element of x to start
#' @return result is an integer
#' @examples
#'
#'
#'
#' @export


begin_to_end <- function(x,  from = dt_start(x), period =  50, threshold = .85){


  if (is.na(from)) return (NA)


  return( max(which(x[1:(from + period) ] >= threshold )))

  }
