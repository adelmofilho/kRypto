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
