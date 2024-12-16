#' Convert julian days to normal days
#'
#' julian_todate function convert julian dates to normal dates
#' @param julian is the julian date (number of days since the degining of the year)
#' @param year the year of the date (julian dates dont carry year component) default null
#' @param leap This specify if year is leap year or not
#' @param format this parameter controle the format of the date
#' @return result is a date or a date like format string (%dd/%mm) if year not specify
#' @examples
#'
#'julian_1 <- julian_todate(178)
#'julian_2 <-  julian_todate(-20) ## will return NA because day must be positive
#'julian_3 <- julian_todate(390) ## will return NA because days must be less than 366
#'
#' @export



julian_todate <- function(julian, year = NULL, leap = TRUE, format = "%yyyy/%mm/%dd") {

  julian <- as.integer(julian)

  if (julian > 366 | julian <= 0) {

    warning("More than number of days in a year provided or negitive value. NA returned")
    return(NA)

  }

  if (!is.null(year)) {

    leap <- is_leapyear(year)
  }

  if (leap) { nbjrs_mois <- c(31,29,31,30,31,30,31,31,30,31,30,31) }
  else { nbjrs_mois <- c(31,28,31,30,31,30,31,31,30,31,30,31) }

  names(nbjrs_mois) <- c("Jan", "Feb" ,"Mar", "Apr", "May" ,"Jun", "Jul" ,"Aug" ,"Sep", "Oct", "Nov" ,"Dec")

  mois <- 0

  jour <- 0

  cumul <- 0

  if (is.na(julian)) {

    return(NA)

  }

  for( i in nbjrs_mois) {


      mois <- mois + 1

    cumul <- cumul + i

    if (cumul == julian){

      jour <- nbjrs_mois[mois]

      date_ <-  paste0(jour,"/",names(nbjrs_mois)[mois])
      break

    } else if (cumul > julian ) {

        if (mois == 1) {

            jour <- julian
            date_ <-  paste0(jour,"/",names(nbjrs_mois)[mois])
            break

            } else {

            jour <- julian - sum(nbjrs_mois[1:(mois-1)])

        }

        date_ <-  paste0(jour,"/",names(nbjrs_mois)[mois])
        break
    }
  }

  if (!is.null(year)) { return( paste0(date_, "/", year)) } else { return(date_)}


}
