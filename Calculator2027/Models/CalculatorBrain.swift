//
//  CalculatorBrain.swift
//  Calculator2027
//
//  Created by  User on 25.10.2026.
//

import Foundation

class CaculatorBrain{
    
    //MARK : cac bien thanh phan cuaS
    private var accumulator:Double?
    
    //dinh nghia cau truc luu toan hang 1 va phep toan
    struct Pending
    {
        var firstOpenand:Double
        var funcion:(Double, Double)->Double
    }
    //dinh nghia bien thanh phan de luu du lieu phep 2 ngoi
    private var pending:Pending? = nil
    
    //MARK: cac phuong thuc cua lop M
    func sendOperand(_ operand: Double){
        //luu gia tri de xu ly sau
       accumulator = operand
    }
    //phuong thuc thuc hien phep toan
    func performMathFuncion(_ function:String){
        
        switch function {
          case "e": accumulator = M_E
          case "π", "𝜋": accumulator = Double.pi
          case "√": if let number = accumulator {
              accumulator = sqrt(number)
          }
          case "cos": if let number = accumulator {
              accumulator = cos(number)
          }
          case "∓", "±", "≠": if let number = accumulator {
              accumulator = -number
          }
        case "−":
                //luu phep toan va toang hang 1
            if let value = accumulator{
                pending = Pending(firstOpenand: value, funcion: {(a:Double,b:Double) in a-b})
                    accumulator = nil
                
            }
             
        case "+":
            if let value = accumulator{
                pending = Pending(firstOpenand: value, funcion: {(a:Double,b:Double) in a+b})
                accumulator = nil

                
            }

        case "×":
            if let value = accumulator{
                pending = Pending(firstOpenand: value, funcion: {(a:Double,b:Double) in a*b})
                accumulator = nil

                
            }
        case "÷":
            if let value = accumulator{
                pending = Pending(firstOpenand: value, funcion: {(a:Double,b:Double) in a/b})
                accumulator = nil

                
            }
        case "=":
            //thuc hien phep tinh 2 ngoi
            if let secondOperand = accumulator, let pending = pending{
               accumulator = pending.funcion(pending.firstOpenand, secondOperand)
                self.pending = nil
            }
            
          default : break
          }
    }
    
    
    //MARK Dinh nghia bien tinh toan de C lay ket qua tra ve tu M
    var result:Double?  {
        get{
            return accumulator
        }
    }
}
