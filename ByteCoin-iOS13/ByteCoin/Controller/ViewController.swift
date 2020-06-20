//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblBitcoin: UILabel!
    @IBOutlet weak var lblCurrency: UILabel!
    @IBOutlet weak var pckCurrency: UIPickerView!

    var coinManager = CoinManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        pckCurrency.delegate = self
        pckCurrency.dataSource = self
        coinManager.delegate = self
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: currency)
    }
}

// MARK: - CoinManagerDelegate
extension ViewController: CoinManagerDelegate {

    func didUpdateCoin(coin: CoinModel) {
        DispatchQueue.main.async {
            self.lblBitcoin.text = String(format: "%.2f", coin.rate)
            self.lblCurrency.text = coin.asset_id_quote
        }
    }

    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
}
