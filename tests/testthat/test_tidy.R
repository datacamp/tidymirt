context("tidy")

test_that("tidy works on the main mirt example", {
  expect_s3_class(
    tidy(mod_1f),
    "tbl_df"
  )
})

test_that("tidy no args returns expected 1 factor parameters", {
  expect_setequal(
    unique(tidy(mod_1f)$term),
    c("a1", "d", "g", "u", "MEAN_1", "COV_11")
  )
})

test_that("tidy no args returns 4 pars per item", {
  expect_equal(
    nrow(tidy(mod_1f, group_pars = FALSE)),
    5*4
  )
})


test_that("tidy adds par named a2, factor means, and covs for 2 factor model", {
  expect_setequal(
    unique(tidy(mod_2f)$term),
    c("a1", "a2", "d", "g", "u", "MEAN_1", "MEAN_2", "COV_11", "COV_21", "COV_22")
  )
})

test_that("tidy returns confidence intervals if available", {
  pars <- tidy(mod_1f_se)
  expect_equivalent(
    names(pars),
    c("item_number", "item", "term", "estimate", "conf.low", "conf.high")
  )

  expect_true(any(!is.na(pars$conf.low)))
  expect_true(any(!is.na(pars$conf.high)))
})


