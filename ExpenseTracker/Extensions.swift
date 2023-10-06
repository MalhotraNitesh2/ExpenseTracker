//
//  Extensions.swift
//  ExpenseTracker
//
//  Created by Nitesh Malhotra on 27/09/23.
//

import Foundation
import SwiftUI

extension Color{
    static let systemBackground = Color(uiColor: .systemBackground)
}

extension DateFormatter{
    static var allNumericUSA : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        return formatter
    }()
}
    
extension String {
       func  dateParsed()-> Date{
            guard let parsedDate = DateFormatter.allNumericUSA.date(from: self)else{return Date()}
            
            return parsedDate
        }
    }
extension Date:Strideable{
    func formatted() -> String{
        return self.formatted(.dateTime.year().month().day())
    }
}
extension Double {
    func Roundof2digits() -> Double
        {
            return (self*100).rounded() / 100
        }
    }
    
