#' Tidy data frame of ticker data for specificed cryptocurrencies
#'
#' Returns a tidy data frame of ticker data for specificed cryptocurrencies
#'
#' @details The tidy data frame constains general information about the selected cryptocurrencies on date.
#'
#' @return A data frame with fourteen columns.
#'
#' @name ticker
#'
#' @param cryptocurrency A vector with cryptocurrencies symbol
#'
#' @import dplyr
#'
#' @examples
#'
#' ticker_data <- ticker(cryptocurrency = c('BTC', 'PPC'))
#'
#'
#' @export
ticker <- function(cryptocurrency = c('BTC')) {

  cryptocurrency_list <- kRypto::cryptocurrency_list

  delta <- function(x){

    cols_change <- colnames(x)[1:4]

    x %>% dplyr::mutate_at(vars(cols_change), funs(as.character)) }

  we <- function(x){

    if (is.null(x)) {

      x <- NA

    } else{

      x <- x
    }

  }

  as <- function(x){

    dw <- httr::GET(url = paste0('https://api.coinmarketcap.com/v2/ticker/',x)) %>%
      httr::content()

    dados <- dw$data[1:8]

    dw_2 <- purrr::map(dados, we) %>% as.data.frame()

    dw_2 <- dw_2 %>% dplyr::bind_cols(as.data.frame(dw$data$quotes))

    dw_2
  }

  row <- which(cryptocurrency_list$symbol %in% cryptocurrency)

  id <- cryptocurrency_list %>%
    dplyr::slice(row) %>%
    dplyr::select(id) %>%
    unlist() %>% as.vector()

  ticker_data <- purrr::map(id, as) %>%
    purrr::map(delta) %>% bind_rows() %>%
    dplyr::as_tibble()

  return(ticker_data)
}
