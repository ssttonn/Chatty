//
//  Colors.swift
//  Chatty
//
//  Created by GONOSEN on 11/08/2022.
//

import Foundation
import UIKit

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: a)
   }

   convenience init(rgb: Int, a: CGFloat = 1.0) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF,
           a: a
       )
   }
    
    static var primaryColor: UIColor{
        UIColor(rgb: 0x15133C, a: 1)
    }
    
}
