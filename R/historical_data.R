# Retrive historical data per cryptocoin id
#
# This function is used to get data from coinmarketcap website
retrive_data <- function(id){

  Date <- dia <- Open. <- Market.Cap <- Volume <- coin <- NULL

  startdate <- '20000101'

  enddate <- Sys.Date() %>% stringi::stri_replace_all_regex("([-])", "")

  url_historical <- paste0('https://coinmarketcap.com/currencies/',id,'/historical-data/?start=',
                           startdate, '&end=',enddate)

  page_hist <- xml2::read_html(url_historical)

  hist_clean <- page_hist %>%
    rvest::html_nodes('table') %>%
    rvest::html_table()

  hist_clean <- hist_clean[[1]] %>%
    data.frame() %>%
    dplyr::mutate(dia = format(lubridate::mdy(Date),"%Y-%m-%d")) %>%
    dplyr::mutate(coin = id) %>%
    dplyr::select(-Date) %>%
    dplyr::select(coin, dia, Open.:Market.Cap) %>%
    dplyr::mutate(Volume = suppressWarnings(as.numeric(stringr::str_remove_all(Volume, "[,]")))) %>%
    dplyr::mutate(Market.Cap = suppressWarnings(as.numeric(stringr::str_remove_all(Market.Cap, "[,]"))))

  return(hist_clean)

}

#' Returns a Tidy data frame of historical data for selected cryptocurrencies
#'
#' Returns a tidy data frame of historical data for specificed cryptocurrencies
#'
#' @details The tidy data frame constains general information about the selected cryptocurrencies on date.
#'
#' @return A data frame with fourteen columns.
#'
#' @name historical_data
#'
#' @import dplyr
#'
#' @param cryptocurrency A vector with cryptocurrency symbols
#'
#' @examples
#'
#' data <- historical_data(cryptocurrency = c('BTC'))
#'
#'
#' @export
historical_data <- function(cryptocurrency = c('BTC', 'PPC')){

  website_slug <- NULL

  cryptocurrency_list <- kRypto::cryptocurrency_list

  row <- which(cryptocurrency_list$symbol %in% cryptocurrency)

  id <- cryptocurrency_list %>%
    dplyr::slice(row) %>%
    dplyr::select(website_slug) %>%
    unlist() %>% as.vector()

  historical_data <- purrr::map(id, retrive_data) %>%
    dplyr::bind_rows() %>%
    dplyr::as_tibble()

  return(historical_data)

}
