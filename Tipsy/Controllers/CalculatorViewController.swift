//
//  ViewController.swift
//  Tipsy
//
//  Created by Adilet Abdukarim on 2021/05/31.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    
    @IBOutlet weak var splitNumberLabel: UILabel!

    var tip = 0.10
    var numberOfPeople = 2
    var billTotal = 0.0
    var billTotalAsString = ""
    var tipAsString = ""
    

    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        sender.isSelected = true
        
        let buttonTitle = Double(String(sender.currentTitle!.dropLast()))!
        
        tip = buttonTitle / 100
        
        tipAsString = String(format: "%.0f", buttonTitle)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        billTextField.endEditing(true)
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        numberOfPeople = Int(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let bill = billTextField.text
        
        if bill != "" {
            billTotal = Double(bill!)!
            let result = billTotal * (1 + tip) / Double(numberOfPeople)
            let resultTo2DecimalPlaces = String(format: "%.2f", result)
            print(resultTo2DecimalPlaces)
            billTotalAsString = resultTo2DecimalPlaces
        }
        
        performSegue(withIdentifier: "goToResult", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            
            destinationVC.totalBill = billTotalAsString
            destinationVC.billDescription = "Split between \(numberOfPeople) people with \(tipAsString)%"
            
        }
    
    }
}
