

gregoire <- function(mes_dates) {
  
  resultat <- c()
  
  for (i in mes_dates) {
    
    if (is.na(i)) resultat <- c(resultat,NA)
    
    else resultat <- c(resultat, gregory_date(i))
  }
  
  return(resultat)
}