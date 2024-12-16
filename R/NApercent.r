#' Compute the missing data percent
#'
#' This function compute the percentage of NA values in a numeric vector (rainfall data)
#' @param x the rainfall vector
#' @return result in percent of NA number
#' @examples
#' Np <- NAPercent( c(0.0, 0.4, 45.2, NA, 21, NA, NA, NA))  # should give 50 (%)
#' Np <- NAPercent( c(rnorm(75), rep(NA, 25)))  # should give 25 (%)
#'
#' @export


NAPercent <- function(x) {

  percent <- (sum(is.na(x), na.rm = TRUE)/length(x)) * 100

  return (percent)
}
