#' Build ATP dataset using Jeff Sackman Github data
#'
#' @param path file path for directory of yearly match data csvs
#'
#' @return dataframe of yearly ATP match data with season id
#' @export
#'
build_atp_data <- function(path) {

  keep_cols <- c("tourney_id", "tourney_name", "surface", "tourney_level", "tourney_date",
                 "winner_id", "winner_seed", "winner_entry", "winner_name", "winner_hand",
                 "winner_ht", "winner_ioc", "winner_age", "loser_id", "loser_seed",
                 "loser_entry", "loser_name", "loser_hand", "loser_ht", "loser_ioc",
                 "loser_age", "score", "round", "minutes", "w_ace", "w_df", "w_svpt",
                 "w_1stIn", "w_1stWon", "w_2ndWon", "w_SvGms", "w_bpSaved", "w_bpFaced",
                 "l_ace", "l_df", "l_svpt", "l_1stIn", "l_1stWon", "l_2ndWon",
                 "l_SvGms", "l_bpSaved", "l_bpFaced", "winner_rank", "loser_rank", "season"
  )

  fs::dir_ls(path = path) |>
    purrr::map_df(~readr::read_csv(.)) |>
    dplyr::mutate(season = stringr::str_sub(.data$tourney_date, start = 1L, end = 4L),
                  tourney_date = lubridate::ymd(.data$tourney_date)) |>
    dplyr::select(keep_cols)
}
