
//
//  CalcvulatorController.swift
//  Calculator2027
//

import UIKit

// MARK: Calculator Controller
class CalculatorController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var display: UITextField!
    var isTyping = false
    var isZeroOperand = false

    override func viewDidLoad() {
        super.viewDidLoad()
        display.text = "0"
    }

    // MARK: Ham xu ly phim so
    @IBAction func digitProcessing(_ sender: UIButton) {
        let digit = sender.titleLabel!.text!
        let currentDisplay = display.text!
        if !isTyping {
            display.text = digit

            if digit != "0" {
                isTyping = true
            }
            else    {
                //co kha nang la so 0 la toan hang
                isZeroOperand = true
            }
        }
        else {
            display.text = currentDisplay + digit
        }
    }

    // MARK: Bien tinh toan trung gian
    var displayValue: Double? {
        get {
            if let strNumber = display.text,
               let number = Double(strNumber) {
                return number
            } else {
                return nil
            }
        }

        set {
            if let value = newValue {
                if !value.isNaN {

                    let pn = value.soChuSoPhanNguyen()
                    let ptp = value.soChuSoPhanThapPhan()

                    if pn + ptp <= 12 {
                        // Khong can lam tron
                        if ptp == 0 {
                            display.text = String(format: "%.0f", value)
                        } else {
                            display.text = String(value)
                        }
                    } else {
                        // Lam tron phan thap phan
                        display.text = String(
                            format: "%.\(max(0, 12 - pn))f",
                            value
                        )
                    }
                } else {
                    display.text = String(Double.nan)
                }
            }
        }
    }

    // MARK: Khai bao doi tuong M (CalculatorBrain)
    let brain = CaculatorBrain()

    // MARK: Ham xu ly chuc nang
    @IBAction func functionProcessing(_ sender: UIButton) {

        // Lay ky hieu phep toan
        let functionSymbol = sender.titleLabel!.text!

        // Gui gia tri can tinh cho Model
        if let value = displayValue {
            if isTyping{
                // Buoc 1: Gui gia tri can tinh cho M
                brain.sendOperand(value)
                
            }
            else{
                if isZeroOperand{
                    brain.sendOperand(value)
                    
                    //xoa co
                    isZeroOperand = false
                }
                
            }
            // Buoc 2: Gui phep toan cho M
            brain.performMathFuncion(functionSymbol)
        }

        // Lay ket qua tra ve tu M
        displayValue = brain.result

        // Xoa trang thai phim so
        isTyping = false
    }
}

// MARK: Extension Double
extension Double {
    func soChuSoPhanNguyen() -> Int {
        return (self.isNaN||self.isInfinite) ? -1 : String(self).split(separator: ".")[0].count
    }

    func soChuSoPhanThapPhan() -> Int {
        return (self.isNaN||self.isInfinite) ? -1 : String(self).split(separator: ".")[1] == "0" ? 0 : String(self).split(separator: ".")[1].count
    }
}
