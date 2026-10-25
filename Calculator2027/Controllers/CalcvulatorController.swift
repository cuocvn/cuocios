
//
//  CalcvulatorController.swift
//  Calculator2027
//
//  Created by User on 14.10.2026.
//

import UIKit

// MARK: Calculator Controller

class CalculatorController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var display: UITextField!
    var isTyping = false

    override func viewDidLoad() {
        super.viewDidLoad()
        display.text = "0"
    }

    //MARK: Ham xu ly phim so
    @IBAction func digitProcessing(_ sender: UIButton) {
        let digit = sender.titleLabel!.text!
        let currentDisplay = display.text!
        if !isTyping {
            display.text = digit
            if digit != "0" {
                isTyping = true
            }
        }
        else {
            display.text = currentDisplay + digit
        }
    }

    //MARK: Bien tinh toan trung gian giua phuong thuc functionProcessing va MH display
    var displayValue:Double? {
        get {
            if let strNumber = display.text, let number = Double(strNumber) {
                return number
            }
            else {
                return nil
            }
        }
        set {
            if let value = newValue{
                if !value.isNaN{
                    
                
                let pn = newValue!.soChuSoPhanNguyen()
                let ptp = newValue!.soChuSoPhanThapPhan()
                if pn + ptp <= 12 { // Khong can lam tron
                    display.text = String(newValue!)
                }
                    else {
                        display.text = String(format: "%.\(max(0,12-pn))f", newValue!)
                    }
                    
                    
                }
                else{display.text=String(Double.nan)}
            }
        }
    }

    //MARK: Ham xu ly chuc nang
    @IBAction func functionProcessing(_ sender: UIButton) {
        // Xu ly cac truong hop tinh toan
        let functionSymbol = sender.titleLabel!.text!
        switch functionSymbol {
        case "e": displayValue = M_E
        case "π", "𝜋": displayValue = Double.pi
        case "√": if let number = displayValue {
            displayValue = sqrt(number)
        }
        case "cos": if let number = displayValue {
            displayValue = cos(number)
        }
        case "∓", "±", "≠": if let number = displayValue {
            displayValue = -number
        }
        default : break
        }

        // Xoa trang thai phim so
        isTyping = false
    }
}

extension Double {
    func soChuSoPhanNguyen()->Int {
        return String(self).split(separator: ".")[0].count
    }
    func soChuSoPhanThapPhan()->Int {
        let parts = String(self).split(separator: ".")
        return parts.count > 1 ? parts[1].count : 0
    }
}
