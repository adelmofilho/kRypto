context("test-listing")

test_that("Number of colums", {
  expect_equal(ncol(kRypto::listing()), 4)
})
