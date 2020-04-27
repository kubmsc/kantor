//
//  ViewController.swift
//  kantor
//
//  Created by Kuba  on 23/04/2020.
//  Copyright © 2020 Kuba . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var currentCurrencyLabel: UILabel!
    @IBOutlet weak var plnLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var eurLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var kantorManager = KantorManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        kantorManager.delegate = self
    }
}
//MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate{
    
    @IBAction func searchButton(_ sender: UIButton) {
        searchTextField.endEditing(true)
        let text = searchTextField.text
        currentCurrencyLabel.text =  text
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        let text = searchTextField.text
        currentCurrencyLabel.text = text
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = ""
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let currency = searchTextField.text {
            kantorManager.getCurrencyPrice(currencyName: currency)
        }
        searchTextField.text = ""
    }
}
 //MARK: - KantorManagerDelegate

extension ViewController: KantorManagerDelegate {
    func didUpdateCurrency(_ kantorManager: KantorManager, kantor: KantorModel) {
        DispatchQueue.main.async {
            self.currentCurrencyLabel.text = kantor.base
            self.plnLabel.text = kantor.plnString
            self.usdLabel.text = kantor.usdString
            self.eurLabel.text = kantor.eurString
            self.gbpLabel.text = kantor.gbpString
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}



