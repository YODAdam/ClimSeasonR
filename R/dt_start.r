#' Compute the start of rainy season
#'
#' dt_start function compute the start of the rainy season in julian days using Sivakoumar like conditions
#' @param x the rainfall vector
#' @param limit the maximum length of x or the latest not included date
#' @param SumVdays the total rainfall over V (n_Vdays) consicutive days for starting condition
#' @param n_Vdays numbers of consecutive days to compute SumVdays on
#' @param maxDrySpell_aft maximum of dry spell after SumVdays condition realized
#' @param onMaxdays maximum of consecutive days for maxDrySpell computation
#' @return result in percent of NA number
#' @examples
#'
#'
#'
#' @export



dt_start <- function(x, early = 91,
                         limit = length(x),
                         SumVdays = 20.0,
                         n_Vdays = 3,
                         maxDrySpell_aft = 20,
                         onMaxdays = 30
                         ){


  # if (NAPercent(x) > NaMaxPercent) return (NA)


  result <- NA

  # Loops overs the rainfall vector

  for (i in early:limit) {

    # if no date before limit date return NA

    if( i>= limit) {
      return (NA)
    }

    # Sum of the rainfall over initial consecutive days

    sum_3days  = sum(x[i:(i + n_Vdays - 1)],na.rm = TRUE)
    sum_withNA = sum(x[i:(i + n_Vdays - 1)])

    # checking first conditions

      if (sum_3days >= SumVdays) {

      mon_vect <- x[i:(i+n_Vdays -1)]

      # computing the exact days the condition occured

      flag <- total_at(mon_vect, total = SumVdays)

      # computing maximum dry spell

      ss_chesse <- dry_spell(x[(i + flag + 1):(i+ onMaxdays - 1)])[[1]]

      if (is.na(ss_chesse)) return (NA)

      if (ss_chesse <= maxDrySpell_aft) {


        result <- i + flag

      if (result >= limit) return(NA)

        return (result)

        } else if (is.na(sum_withNA)) return(NA) else next

    } else if (is.na(sum_withNA)) return(NA) else next

  }

   if (is.na(result)) return(NA)

}
