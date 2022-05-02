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
    }
}

//MARK: - UIPickerViewDataSource

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerView.tag == 1 ? coinManager.cryptoArray.count : coinManager.currencyArray.count
    }
}

//MARK: - UIPickerViewDelegate

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerView.tag == 1 ? coinManager.cryptoArray[row] : coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        var selectedCurrency: String
        var selectedCrypro: String
        
        switch pickerView.tag {
        case 1: selectedCrypro = coinManager.cryptoArray[row]
        case 2: selectedCurrency = coinManager.currencyArray[row]
        default: break
        }
        
        // coinManager.getPrice(coin: selectedCrypro, for: selectedCurrency)
    }
}


