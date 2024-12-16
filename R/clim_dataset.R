#' @title Create a climate dataset object
#' @description
#' clim_dataset creates a climate dataset object structure using s3 system.
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


clim_dataset <- function(data = NULL, vars = list(RAIN = 'RAIN', TMAX = 'TMAX', TMIN = 'TMIN', TMEAN = 'TMEAN'),
                                      time_vars = list( DATE = 'DATE', YEAR = 'YEAR', MONTH = 'MONTH', DAY = 'DAY'),
                                      coords = list(LONG = 'LONG', LAT = 'LAT'),
                                      t_step = 'daily', verbose = TRUE) {


clim_object <- list(
  data = data,
  time_step = t_step
)

class(clim_object) <- "clim_dataset"

if (is.null(data)) {
  return(clim_object)
}


stopifnot('data is not data.from or a tible object', any(c("data.frame", "tbl_df", "tbl") %in% class(data)) )


## variables rename step ----------

variables <- vars %>% unlist()
v <- variables[variables %in% names(data)]



}
