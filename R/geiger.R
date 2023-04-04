
## Note: simulation method is univariate

#' simulate gfit
#'
#' simulate method for gfit objects
#' @param object a gfit object
#' @param nsim number of sims  
#' @param seed an optional seed for the simulations (not implemented)
#' @param ... additional arguments, not implemented for gfit simulations
#' @return simulated dataset
#' @importFrom geiger sim.char
#' @importFrom phytools rescale
simulate.gfit <- function(object, nsim = 1, seed = NULL, ...){
  att <- attributes(object$lik)
  model <- att$model
  phy <- phytools::rescale(att$cache$phy, model, coef(object)[[1]])
  z0 <- coef(object)[["z0"]]
  sigsq <- coef(object)[["sigsq"]]

  x <- geiger::sim.char(phy = phy, par = sigsq, nsim = nsim, model = "BM", root = z0)
  x[,1,]
}


#' update gfit
#'
#' update method for gfit objects
#' @param object a gfit object
#' @param ... additional arguments, such as the data to use to update 
#' @return updated gfit object 
#' @importFrom geiger fitContinuous
update.gfit <- function(object, ...){
  att <- attributes(object$lik)
  geiger::fitContinuous(phy = att$cache$phy, model = att$model, ..., ncores = 1)
}


