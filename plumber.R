# install.packages("plumber")


# plumber.R

# Load plumber
library(plumber)

# Enable CORS
#* @filter cors
function(req, res) {
  res$setHeader("Access-Control-Allow-Origin", "*")
  if (req$REQUEST_METHOD == "OPTIONS") {
    res$setHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
    res$setHeader("Access-Control-Allow-Headers", req$HTTP_ACCESS_CONTROL_REQUEST_HEADERS)
    return(res)
  } else {
    plumber::forward()
  }
}

#* @apiTitle Calculate Score Card

#* Parameters to calculate the scores
#* @param age_at_diagnosis Age at diagnosis of the person
#* @param hemoglobin Hemoglobin of the person
#* @param platelets
#* @param herythroproietin
#* @param pnh_clone
#* @param telomere_length
#* @post /score


function(age_at_diagnosis, hemoglobin, platelets, herythroproietin, pnh_clone, telomere_length) {
  
  # Type conversion
  age_at_diagnosis <- as.numeric(age_at_diagnosis)
  hemoglobin <- as.numeric(hemoglobin)
  platelets <- as.numeric(platelets)
  herythroproietin <- as.numeric(herythroproietin)
  
  
  if(telomere_length=="Not Available"){
    # Calculate Score Card without TL
    score <- 18 + ifelse(age_at_diagnosis < 47, -2, 4) +
      ifelse(hemoglobin < 10.8, 1, -1) +
      ifelse(platelets < 54, 1, -1) +
      ifelse(pnh_clone=="Absent", -1, 2)
    if(herythroproietin < 50){
      score <- score - 2
    } else if (herythroproietin > 1800) {
      score <- score - 1
    } else {
      score <- score + 1
    }
  } else {
    # Calculate Score Card with TL
    score <- 13 + ifelse(age_at_diagnosis < 48, -1, 3) +
      ifelse(hemoglobin < 10.8, 3, -3) +
      ifelse(pnh_clone=="Absent", -1, 3) +
      ifelse(telomere_length=="Normal", 1, -1)
  }
  
  return(list(score = score))
}


