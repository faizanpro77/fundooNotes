//
//  String + Extension.swift
//  fundooNotes
//
//  Created by Yashom on 10/03/22.
//

import Foundation

import Foundation
import UIKit

//struct Faizan {
//    var label: UILabel = UILabel()
//}
//
//
//extension Faizan {
//    func blackHair() {
//        label.textColor = .black
//    }
//}
//
//func sslfkj() {
//    let fz = Faizan()
//
//    fz.blackHair()
//}

extension String {
    func validateEmailId() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        return applyPredicateOnRegex(regexStr: emailRegEx)
    }
    
    func validatePassword(mini: Int = 8, max: Int = 8) -> Bool {
        //Minimum 8 chatacter at least 1 Alphabet and 1 Number:
        var passRegEx = ""
        if mini >= max {
            // print("inside if ....8")
            passRegEx = "(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{\(mini),}$"
        } else {
            // print("inside else ....9")
            passRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{\(mini),\(max)}$"
        }
        return applyPredicateOnRegex(regexStr: passRegEx)
    }
    
    func applyPredicateOnRegex(regexStr: String) -> Bool {
        //let trimmedString = "faizanShaikh".trimmingCharacters(in: .whitespaces)
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        let validateOtherString = NSPredicate(format: "SELF MATCHES %@", regexStr)
        let isValidateOtherString = validateOtherString.evaluate(with: trimmedString)
        return isValidateOtherString
    }
}

//https://stackoverflow.com/a/39284766/8201581
