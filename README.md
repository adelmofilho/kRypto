# kRypto <img src="tools/logo.png" align="right" height="300" width="275"/>

kRypto: Pull cryptocurrency data in tidy format from coinmarketcap API
---------------

**Author :** [Adelmo Filho](http://adelmofilho.github.io/)<br/>
**License:** [GPL-3.0](https://opensource.org/licenses/GPL-3.0)

[![Build Status](https://api.travis-ci.org/adelmofilho/kRypto.svg?branch=master)](https://travis-ci.org/adelmofilho/kRypto)
[![DOI](https://zenodo.org/badge/134989472.svg)](https://zenodo.org/badge/latestdoi/134989472)

### Installation

You can install the development version from Github with [devtools](https://github.com/hadley/devtools):

```r
library(devtools)
install_github("adelmofilho/kRypto")
```

### Usage

To get the updated cryptocurrencies' data, use the function `ticker`. 


```r
library(kRypto)

current_data <- ticker(cryptocurrency = c("BTC", "PPC"))

current_data
```

```
## # A tibble: 2 x 14
##   id    name     symbol website_slug  rank circulating_supply total_supply
##   <chr> <chr>    <chr>  <chr>        <int>              <dbl>        <dbl>
## 1 1     Bitcoin  BTC    bitcoin          1           17057262     17057262
## 2 5     Peercoin PPC    peercoin       193           24777461     24777461
## # ... with 7 more variables: max_supply <dbl>, USD.price <dbl>,
## #   USD.volume_24h <dbl>, USD.market_cap <dbl>,
## #   USD.percent_change_1h <dbl>, USD.percent_change_24h <dbl>,
## #   USD.percent_change_7d <dbl>
```

To obtain historical data for cryptocurrencies, use the function `historical_data`


```r
historical <- historical_data(cryptocurrency = "BTC")

historical
```

```
## # A tibble: 1,855 x 8
##    coin    dia        Open.  High   Low Close..     Volume   Market.Cap
##    <chr>   <chr>      <dbl> <dbl> <dbl>   <dbl>      <dbl>        <dbl>
##  1 bitcoin 2018-05-26 7486. 7595. 7349.   7356. 4051540000 127682000000
##  2 bitcoin 2018-05-25 7592. 7659. 7393.   7480. 4867830000 129470000000
##  3 bitcoin 2018-05-24 7561. 7739. 7331.   7587. 6049220000 128925000000
##  4 bitcoin 2018-05-23 8037. 8055. 7508.   7558. 6491120000 137024000000
##  5 bitcoin 2018-05-22 8420. 8423. 8005.   8042. 5137010000 143534000000
##  6 bitcoin 2018-05-21 8522. 8558. 8365.   8419. 5154990000 145264000000
##  7 bitcoin 2018-05-20 8247. 8562. 8205.   8513. 5191060000 140556000000
##  8 bitcoin 2018-05-19 8256. 8372. 8183.   8247. 4712400000 140689000000
##  9 bitcoin 2018-05-18 8092. 8274. 7975.   8251. 5764190000 137881000000
## 10 bitcoin 2018-05-17 8370. 8446. 8054.   8094. 5862530000 142608000000
## # ... with 1,845 more rows
```

**This package was written during the #IIISER - [International Seminar on Statistics with R](https://ser2018.weebly.com), at Rio de Janeiro, Brazil.**

<img src="tools/ser.jpg" href = "https://ser2018.weebly.com" align="middle" height="100%" width="100%"/>
