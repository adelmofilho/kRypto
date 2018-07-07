# Retrive historical data per cryptocoin id
#
# This function is used to get data from coinmarketcap website
retrive_data <- function(id){

  Date <- dia <- Open. <- Market.Cap <- Volume <- coin <- NULL

  startdate <- '20000101'

  enddate <- Sys.Date() %>% stri_replace_all_regex("([-])", "")

  url_historical <- paste0('https://coinmarketcap.com/currencies/',id,'/historical-data/?start=',
                           startdate, '&end=',enddate)

  page_hist <- read_html(url_historical)

  hist_clean <- page_hist %>%
    html_nodes('table') %>%
    html_table() %>%
    data.frame() %>%
    mutate(dia = format(mdy(Date),"%Y-%m-%d")) %>%
    mutate(coin = id) %>%
    select(-Date) %>% select(coin, dia, Open.:Market.Cap) %>%
    mutate(Volume = suppressWarnings(as.numeric(str_remove_all(Volume, "[,]")))) %>%
    mutate(Market.Cap = suppressWarnings(as.numeric(str_remove_all(Market.Cap, "[,]"))))

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
#' @param cryptocurrency A vector with cryptocurrency symbols
#'
#' @import dplyr
#' @import httr
#' @importFrom  purrr map
#' @import rvest
#' @import stringr
#' @import xml2
#' @importFrom  lubridate mdy
#' @import stringi
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
    slice(row) %>%
    select(website_slug) %>%
    unlist() %>% as.vector()

  historical_data <- purrr::map(id, retrive_data) %>%
    bind_rows() %>%
    dplyr::as_tibble()

  return(historical_data)

}
