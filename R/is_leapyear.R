#' Test if a given year is leap year or note
#'
#' This function return True if a year is a leap year and False otherwise.
#' @param year this parameter is the year of the date
#' @return result is a boolean
#' @examples
#'
#' is_leapyear(2020) ## TRUE
#' is_leapyear(2021) ## FALSE
#'
#' @export



is_leapyear <- function(year = 2021) {

  return( ((year %% 4 == 0) &  !(year %% 100 == 0) )| (year %% 400 == 0)  )
}
