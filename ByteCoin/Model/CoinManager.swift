//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Anton Vikhlyaev on 01.05.2022.
//

import Foundation

struct CoinManager {
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/"
    let apiKey = "BF721634-2F5C-482D-8D60-777F55A1F722"
    
    let cryptoArray = ["BTC", "ETH", "LTC", "USDT", "ADA"]
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
}
