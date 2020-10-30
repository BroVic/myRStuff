# test_cheatsheet.R

test_that("Specific cheatsheet can be found", {
  expect_null(cheatsheet())
  expect_message(cheatsheet("notasheet"))
})