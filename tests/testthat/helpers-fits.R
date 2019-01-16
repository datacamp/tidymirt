data <- mirt::expand.table(mirt::LSAT7)

mod_1f <-  mirt::mirt(data, 1, TOL = .01)

mod_1f_se <- mirt::mirt(data, 1, SE = TRUE, TOL = .01)

mod_2f <- mirt::mirt(data, 2, TOL = .01)
