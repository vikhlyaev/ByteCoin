//
//  ViewController.swift
//  ByteCoin
//
//  Created by Anton Vikhlyaev on 30.04.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cryptoLogo: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var cryptoPicker: UIPickerView!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        cryptoPicker.dataSource = self
        cryptoPicker.delegate = self
        
        coinManager.delegate = self
        
        cryptoPicker.selectRow(0, inComponent: 0, animated: true)
        currencyPicker.selectRow(0, inComponent: 0, animated: true)
    }
}

//MARK: - UIPickerViewDataSource

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerView.tag == 0 ? coinManager.cryptoArray.count : coinManager.currencyArray.count
    }
}

//MARK: - UIPickerViewDelegate

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerView.tag == 0 ? coinManager.cryptoArray[row] : coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCrypto = coinManager.cryptoArray[cryptoPicker.selectedRow(inComponent: 0)]
        let selectedCurrency = coinManager.currencyArray[currencyPicker.selectedRow(inComponent: 0)]
        
        coinManager.getPrice(coin: selectedCrypto, for: selectedCurrency)
    }
}

//MARK: - CoinManagerDelegate

extension ViewController: CoinManagerDelegate {
    func didUpdatePrice(_ coinManager: CoinManager, currency: String, coin: String, price: String) {
        DispatchQueue.main.async {
            self.cryptoLogo.image = UIImage(named: "Icon\(coin)")
            self.priceLabel.text = price
            self.currencyLabel.text = currency
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}


