#' Webscraping historical data for selected cryptocurrencies
#'
#' Scraps historical data for specificed cryptocurrencies
#'
#' @details The tidy data frame contains historical data for selected cryptocurrencies in list format.
#'
#' @return A list.
#'
#' @name retrive_data
#'
#' @param id A vector with cryptocurrency slug name
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
#' data <- retrive_data(id = c('bitcoin'))
#'
#'
#' @export

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
