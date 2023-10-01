## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(levitate)

## -----------------------------------------------------------------------------
head(hotel_rooms)

## -----------------------------------------------------------------------------
df <- hotel_rooms

df$lev_ratio <- lev_ratio(df$expedia, df$booking)
df$lev_partial_ratio <- lev_partial_ratio(df$expedia, df$booking)
df$lev_token_sort_ratio <- lev_token_sort_ratio(df$expedia, df$booking)
df$lev_token_set_ratio <- lev_token_set_ratio(df$expedia, df$booking)

## -----------------------------------------------------------------------------
best_match <- function(a, b, FUN) {
  scores <- FUN(a = a, b = b)
  best <- order(scores, decreasing = TRUE)[1L]
  b[best]
}

best_match("cat", c("cot", "dog", "frog"), lev_ratio)

## -----------------------------------------------------------------------------
best_match_by_fun <- function(FUN) {
  best_matches <- character(nrow(hotel_rooms))
  for (i in seq_along(best_matches)) {
    best_matches[i] <- best_match(hotel_rooms$expedia[i], hotel_rooms$booking, FUN)
  }
  best_matches
}

df$lev_ratio_best_match <- best_match_by_fun(FUN = lev_ratio)
df$lev_partial_ratio_best_match <- best_match_by_fun(FUN = lev_partial_ratio)
df$lev_token_sort_ratio_best_match <- best_match_by_fun(FUN = lev_token_sort_ratio)
df$lev_token_set_ratio_best_match <- best_match_by_fun(FUN = lev_token_set_ratio)

## -----------------------------------------------------------------------------
message("`lev_ratio()`: ", sum(df$lev_ratio_best_match == df$booking) / nrow(df))

message("`lev_partial_ratio()`: ", sum(df$lev_partial_ratio_best_match == df$booking) / nrow(df))

message("`lev_token_sort_ratio()`: ", sum(df$lev_token_sort_ratio_best_match == df$booking) / nrow(df))

message("`lev_token_set_ratio()`: ", sum(df$lev_token_set_ratio_best_match == df$booking) / nrow(df))

