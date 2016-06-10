test_that("we can use ouch-based functions", {
  library("ouch")
  data(anoles)
  
  tree <- with(anoles, ouchtree(node, ancestor, time / max(time), species))

  A <- pmc_fit(tree, log(anoles["size"]), "hansen", regimes = anoles["OU.LP"], sqrt.alpha = 1, sigma = 1)
  sims <- simulate(A)
  s <- format_sims(sims)
  
  ou3v4 <- pmc(tree, log(anoles["size"]), modelA = "hansen", modelB = "hansen", 
             optionsA = list(regimes = anoles["OU.LP"]), 
             optionsB = list(regimes = anoles["OU.4"]),
             nboot = 100, sqrt.alpha = 1, sigma = 1, mc.cores = 1)
  expect_is(ou3v4, "pmc")
})
