test_that("run pmc",
          {
            library("geiger")
            geo <- get(data(geospiza))
            tmp <- treedata(geo$phy, geo$dat)
            phy <- tmp$phy
            dat <- tmp$data[,1]
            out <- pmc(phy, dat, "BM", "lambda", nboot = 10, mc.cores = 1)
            expect_is(out, "pmc")

            p <- plot(out)
            expect_is(p, "ggplot") 
          })
