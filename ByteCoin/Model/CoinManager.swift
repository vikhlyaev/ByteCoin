//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Anton Vikhlyaev on 01.05.2022.
//

import Foundation

//MARK: - CoinManagerDelegate

protocol CoinManagerDelegate {
    func didUpdatePrice(_ coinManager: CoinManager, currency: String, coin: String, price: String)
    func didFailWithError(error: Error)
}

struct CoinManager {
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/"
    let apiKey = "BF721634-2F5C-482D-8D60-777F55A1F722"
    
    var delegate: CoinManagerDelegate?
    
    let cryptoArray = ["BTC", "ETH", "LTC", "USDT", "ADA"]
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getPrice(coin: String, for currency: String) {
        let urlString = baseURL + coin + "/" + currency + "?apikey=" + apiKey
    
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                }
                if let safeData = data {
                    if let price = parseJSON(safeData) {
                        let priceString = String(format: "%.2f", price)
                        delegate?.didUpdatePrice(self, currency: currency, coin: coin, price: priceString)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            return decodedData.rate
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
