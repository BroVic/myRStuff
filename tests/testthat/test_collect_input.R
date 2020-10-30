

# test_that("Input for 'character.only' param is properly validated", {
#   expect_warning(collect_input(character.only = rep(TRUE, 2)))
#   expect_error(collect_input(character.only = 4))
#   expect_error(collect_input(character.only = ""))
#   expect_error(collect_input(character.only = "string"))
#   expect_error(collect_input(character.only = NA))
#   expect_error(collect_input(character.only = NULL))
#   expect_error(collect_input(character.only = NaN))
#   expect_error(collect_input(character.only = Inf))
#   expect_error(collect_input(character.only = -Inf))
# })

## TODO: Review how these tests are conducted because of the prompt generated