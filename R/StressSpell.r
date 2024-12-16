

stress_spell = function(x, from = 1, to = length(x), setNA = 0.0, replaceNA = F, dropNA = F,dailyPET = 5.0, soilFull = 70.0) {

  
  # x est le vecteur de pluie
  # from: ou commence les calculs
  # to : ou fini les calculs
  # setNA: valeurs de remplacement des valeurs manquantes si ya lieu
  # replaceNA: indique si les valeurs manquantes seront remplacer ou non
  # dropNA: indique si on laisse tomber les valeurs manquantes ou pas
  # soilFull :  capacité au champs du soil
  # dailyPET: ETP journaliéres 

  x = x[from:to]  # on coupe le vecteur entre les deux extremites
  
  if(NAPercent(x) > NaMaxPercent) return(NA) # si trop de données manquante on ne calcul pas

  if(dropNA) {              # si on indique de suprimer les NA on suprime et on annul le remplacement
  
    x = x[!is.na(x)]
    replaceNA = F           # annulation du remplacement
  
  } else if (replaceNA) x[is.na(x)] = setNA   # sinon si il s'agit d'un replacemnt on l'effectue



  last_was_na = F            # un flag pour gerer les données manquantes
  bilan = 0.0                # variable du bilan hydrique
  stress_count = 0           # compte les jours de stress
  stress_vect = c()          # stoke les sequences de stress
  step = 0                   

  for (i in x) {
	
	  
    step = step + 1
    
    if(is.na(i) & step == 1){            # gere les cas ou ya NA au debut
      #stress_vect = c(stress_vect,NA)
      last_was_na = T
      next
      
    } else if(!is.na(i) & step == 1) {  # gestion de la premiere
      
      last_was_na = F     
    }
    
	  if(is.na(i)) bilan = 0.0  # si on est é une données manquante on annule le bilan hydrique         
	
	  if(is.na(i) & !last_was_na) {  # si la valeur est manquante et le dernier n'est pas une valeur mqnante 
		  stress_vect = c(stress_vect,stress_count) # on ajoute la valeur au vecteur de strees
		  stress_count = 0
		  last_was_na = T
	
	  } 

	  if(!is.na(i) & last_was_na) {     # si la valeur n'est pas manquante et la derniere est maqnante on joute na (on vien dsortir d'une sequence de NA)
		  stress_vect = c(stress_vect,NA)
		  last_was_na = F                 # on leve le flag
	
	  }
	
	  if(!is.na(i)) {                  # si la valeur n'est pas manquante alors on fait le calcul necessaire
		  bilan = sum(c(bilan, i, -dailyPET), na.rm = T) # le bilan est la somme de la pluie + bilan - etp
		
		  if(bilan <= 0.0){              # si le bilan est negatif on on compte comme stress et on maintien le bilan é 0.0
			  stress_count = stress_count + 1 
			  bilan = 0.0
		
		  } else {  
		  
		    stress_vect = c(stress_vect,stress_count)
		    stress_count = 0
		  
		  }
		
		  if (bilan >= soilFull) bilan = soilFull
		
		    last_was_na = F
	
	  }
  }

  if(is.na(i)) stress_vect = c(stress_vect, NA) else stress_vect = c(stress_vect, stress_count)

  stress_vect = stress_vect[stress_vect != 0]

  if(is.null(stress_vect)) return(NA)

  return (stress_vect)

}