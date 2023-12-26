test_that("directory is opened", {
  expect_no_error(suppressMessages(book()))
  expect_message(book())
  expect_invisible(book())
  expect_type(book(), "character")
  expect_true(file.exists(book()))
})
