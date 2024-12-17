#' @title Compute the maximum dry spell in a rainfall vector
#' @description
#' This function compute the maximum dry spell in a rainfall vector
#' @importFrom magrittr %>%
#' @param x A numeric vector of rainfall
#' @param threshold the daily rainfall threshold
#' @param from start computation from (default to 1)
#' @param to end of computation
#' @return result is an integer giving the maximum dry spell
#' @examples
#'
#'
#' @export

maxDrySpell <- function(x, threshold = 0.85, from = 1, to = length(x)) {

  vect <- x
  dry_1 <- dry_spell(x, threshold = threshold, replaceNA = FALSE, NAvalues = 0.0, MaxNAPercent = .25, return_max = TRUE)
  dry_2 <- dry_spell(x, threshold = threshold, replaceNA = TRUE, NAvalues = (threshold + 2.0), MaxNAPercent = .25, return_max = TRUE)

  if(any(is.na(c(dry_1, dry_2)))) return(NA)

  if (dry_2 == dry_1) return(dry_1) else return(NA)
}
