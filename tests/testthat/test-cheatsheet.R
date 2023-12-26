test_that("Specific cheatsheet can be found", {
  err <- "'doc' is not a character vector"
  expect_error(cheatsheet(999), err)
  expect_error(cheatsheet(NULL), err)
  expect_error(cheatsheet(TRUE), err)
  expect_message(cheatsheet("notasheet"), "The file 'notasheet' was not found")
})