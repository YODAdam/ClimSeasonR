#' @title Extract the number of day in a year or julian date
#' @description
#' doy extract the julian date from the date
#' @importFrom lubridate is.Date
#' @importFrom lubridate day
#' @importFrom lubridate month
#' @importFrom lubridate year
#' @importFrom magrittr %>%
#' @param date is the currente date to be converted
#' @param format this parameter controle the format of the date
#' @return result is a julian day
#' @examples
#'
#'
#' @export


doy <- function(date, format = '%Y/%m/%d') {


  if (!is.Date(date)) { date <- as.Date(date, format = format ) }

  stopifnot("No validate date or formating error: enter valide date or format" == is.na(date))

  year_ <- year(date)
  month_ <- month(date)
  day_ <- day(date)

  month_days <- c(31,28,31,30,31,30,31,31,30,31,30,31)

  if (is_leapyear(year)) {

    month_days[2] <- 29

  }







}
