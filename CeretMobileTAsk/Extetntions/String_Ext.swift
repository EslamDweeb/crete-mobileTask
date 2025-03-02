//
//  String_Ext.swift
//  Leedo
//
//  Created by eslam dweeb on 21/09/2022.
//

import Foundation
extension String {
   

        func isValidEmail() -> Bool {
             //guard email != nil else { return false }
            let emailRegEx = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" +
                "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
                "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" +
                "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" +
                "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
                "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
            "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
            
            let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
            return emailTest.evaluate(with: self)
        }
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 8 characters total
        //(?=.*[A-Z])
        //(?=.*[a-z])
        func isValidPassword() -> Bool {
          //  guard password != nil else { return false }
            if self.count < 8 {
                return false
            }else{
                return true
            }
        }
        func isValidName() -> Bool {
            //guard name != nil else { return false }
            if self.count < 6 {
                return false
            }else{
                return true
            }
        }
        func isValidPhone() -> Bool {
            //guard password != nil else { return false }
            let passwordTest = NSPredicate(format: "SELF MATCHES %@","[0-9]{9,14}")
            return passwordTest.evaluate(with: self)
        }
    func tail(s: String) -> String {
        return String(s.suffix(from: s.index(s.startIndex, offsetBy: 1)))
    }
}
extension Date{
    func getFormattedDate(format:String,dateString:String)-> Date? {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = format
        return  dateFormater.date(from: dateString) ?? nil
        
    }
    func getFormatedDateString(format:String)->String{
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = format
        return  dateFormater.string(from: self)
    }
}
extension Int{
    func formatNumber() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""

        switch num {
        case 1_000_000_000...:
            var formatted = num / 1_000_000_000
            formatted = formatted.rounded(.awayFromZero)
            return "\(sign)\(formatted)B"

        case 1_000_000...:
            var formatted = num / 1_000_000
            formatted = formatted.rounded(.awayFromZero)
            return "\(sign)\(formatted)M"

        case 1_000...:
            var formatted = num / 1_000
            formatted = formatted.rounded(.awayFromZero)
            return "\(sign)\(formatted)K"

        case 0...:
            return "\(self)"

        default:
            return "\(sign)\(self)"
        }
    }
}
