# tests for listing

context("Listing Cryptocurrency Data")

suppressPackageStartupMessages(library(dplyr))

test_that("Number of colums", {
  d <- kRypto::listing()
  expect_equal(ncol(d), 4)
})
