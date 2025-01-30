#' @title Compute the dry spell in rainy  season
#' @description
#' dry_spell function compute the maximul dry spell or all dry spells in rainfall data
#' @param x the rainfall vector
#' @param threshold the default value of rain quantity to be counted as a rainy day
#' @param replaceNA Replace missing values by a specified value defaulted to 0.0 mm
#' @param NAvalues missing data replacement values
#' @param MaxNAPercent maximum percentage of missing data
#' @param from from which element of x to start
#' @param to last element for dry spell computing
#' @param IncludeNA Include missing value in the output result
#' @param DropNA drop missing values before computing
#' @return result is a consecutive number of dry days
#' @examples
#'
#'
#'
#' @export


dry_spell_2 <- function(x , threshold = 0.85, NAValues = 0.0, from = 1, to = length(x),  IncludeNA = TRUE, DropNA = FALSE, NaMaxPercent = .25 ) {

  if(!is.numeric(x)) {
    warning("Non numeric values: check the vector data type: NA returned")
  }

  x <- x[from:to]

  if (length(x) == 0) {
   warning("Empty vector: NA returned ")
   return(NA)

  }


  if (NAPercent(x) > NaMaxPercent) return (NA)

  if(IncludeNA) DropNA = FALSE
  if(DropNA) IncludeNA = FALSE

  if(DropNA){

    x <-  x[!is.na(x)]


  } else {

    if(!IncludeNA){

      x[is.na(x)] <- NAValues

      }
  }



  count <- 0

  ss <- 0

  is_na <- FALSE

  for (i in 1:length(x)) {

    if (is.na(x[i])){

      ss <- c(ss,count)
      count <- 0
      is_na = TRUE

    } else if (x[i] < seuil_pluie) {

      count <- count + 1

    } else {

      if (is_na){
        ss <- c(ss,NA)
        is_na = FALSE

      }
      ss <- c(ss,count)

      count <- 0
    }
  }

  ss <- c(ss,count)


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

  if(length(ss) == 0) return(NA)

  return (list( maximum = max(ss, na.rm = T),dry_spls= ss[ss !=0]))

}
