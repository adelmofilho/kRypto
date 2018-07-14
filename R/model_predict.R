#Model crypto data with hyperblm fit

#adjusting hyperbolic model
cryptomodel <- function(response,covariate1,covariate2,covariate3,covariate4){
  hyperblm(response~covariate1+covariate2+covariate3+covariate4)]}

#More information about this hyperbolic model function can be found at:
#https://www.rdocumentation.org/packages/GeneralizedHyperbolic/versions/0.8-4