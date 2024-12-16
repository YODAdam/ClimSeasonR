#' Compute the dry spell in rainy  season
#'
#' dry_spell function compute the maximul dry spell or all dry spells in rainfall data
#' @param x the rainfall vector
#' @param threshold the default value of rain quantity to be counted as a rainy day
#' @param replaceNA Replace missing values by a specified value defaulted to 0.0 mm
#' @param NAvalues missing data replacement values
#' @param MaxNAPercent maximum percentage of missing data
#' @param return_max return maximum or detail values
#' @return result is a consecutive number of dry days
#' @examples
#'
#'
#'
#' @export

dry_spell <- function(x, threshold = 0.85, replaceNA = TRUE, NAvalues = 0.0, MaxNAPercent = .25, return_max = TRUE){


  x <- as.numeric(x)

  if (length(x) == 0){

    warning("Empty vector, NA returned")
    return(NA)

  }


  if (!replaceNA) {

    if (NAPercent(x) > MaxNAPercent) {

      warning("Number of NAs exced limit or all values in vector are NA or non-numeric. NA returned")
      return (NA)

    }

  } else {

    x[is.na(x)] <- NAvalues

  }

   count <- 0

   ss <- 0

    for (i in 1:length(x)){


      if (x[i] < threshold){

        count <- count + 1

        } else {

          ss <- c(ss,count)

          count <- 0
      }
   }

    ss <- c(ss,count)

  #


   #################################################################################*
   #### La formule ci dessous est une version plus coourte et econnomique
   #

    # ss <- which(x>= seuil_pluie)
    #
    # if (x[length(x)] >= seuil_pluie)  ss_sechesse <- c(ss[1], ss[2:length(ss)] - ss[1:(length(ss) - 1)], length(x) - ss[length(ss)]) - 1
    #
    # else {
    #   ss_sechesse <- c(ss[1], ss[2:length(ss)] - ss[1:(length(ss) - 1)], length(x) - ss[length(ss)] + 1) - 1
    # }
    #
    # ss_sechesse <- ss_sechesse[ ss_chesse != 0]

    if(is_empty(ss)) return(NA)

    if (return_max)  return( max(ss, na.rm = T) )  else  return (list( maximum = max(ss, na.rm = T),all_spells = ss[ss !=0]))

}
