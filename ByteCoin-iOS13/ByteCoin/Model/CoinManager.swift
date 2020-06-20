//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate  {

    func didUpdateCoin(coin: CoinModel)
    func didFailWithError(error: Error)
}

struct CoinManager {

    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "24AB72B9-6AAF-4D28-A9A8-4533FE3FA80B"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apiKey=\(apiKey)"
        performRequest(with: urlString)
    }

    func performRequest(with urlString: String) {
        guard let url = URL(string: urlString) else {return}

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                self.delegate?.didFailWithError(error: error)
                return
            }

            if let data = data {
                do {
                    let coinModel = try JSONDecoder().decode(CoinModel.self, from: data)
                    self.delegate?.didUpdateCoin(coin: coinModel)
                } catch {
                    print(error.localizedDescription)
                    self.delegate?.didFailWithError(error: error)
                    return
                }
            }
        }.resume()
    }
}
