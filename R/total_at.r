#' Compute the exact days or step a certain total quantity is obtain
#'
#' dt_start function compute the start of the rainy season in julian days using Sivakoumar like conditions
#' @param total the rainfall vector
#' @param total the total rainfall to have
#' @return result the step
#' @examples
#'
#'
#'
#' @export


total_at <- function(x, total = 20.0) {

  longueur <- length(x)

  for (i in 1:longueur) {

    if(sum(x[1:i],na.rm = T) >= total )
      return(i-1)
  }

}
