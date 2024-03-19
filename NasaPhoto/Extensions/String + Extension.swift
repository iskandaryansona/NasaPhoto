//
//  String + Extension.swift
//  NasaPhoto
//
//  Created by Sona on 19.03.24.
//

import Foundation


extension String {
    
    func convertDateFormat() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = inputFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MMMM dd, yyyy"
            
            let outputDate = outputFormatter.string(from: date)
            return outputDate
        }
        return ""
    }
    
    func convertToDate() -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: self) ?? Date()
    }
    
}
