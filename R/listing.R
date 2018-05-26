#' Tidy data frame of all active cryptocurrency at coinmarketcap
#'
#' Returns a tidy data frame of all active cryptocurrency at coinmarketcap
#'
#' @details The tidy data frame constains meta data about all active cryptocurrency,
#' including (1) all active cryptocurrency´s id, (2) cryptocurrency name, (3) symbol, and the (4)
#' correspondent website slug.
#'
#' @return A data frame with four columns: \code{id}, \code{name}, \code{symbol} and \code{website_slug},
#'
#' @name listing
#'
#' @import dplyr
#' @import httr
#' @import purrr
#'
#'
#' @examples
#'
#' coins <- listing()
#'
#'
#' @export

listing <- function() {

  delta <- function(x){x %>% mutate_all(as.character)}

  a <- 'https://api.coinmarketcap.com/v2/listings/' %>%
    httr::GET() %>%
    httr::content()

   b <- a$data %>%
    purrr::map(as.data.frame) %>%
    purrr::map(delta) %>%
    dplyr::bind_rows() %>%
    dplyr::as_tibble()

  return(b)
}
