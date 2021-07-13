//
//  Date+Formatter.swift
//  NASA
//
//  Created by Haresh Ghatala on 13/07/21.
//  Copyright © 2021 Haresh Ghatala. All rights reserved.
//

import Foundation

extension Date {
    
    func toString(format foramtStr: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = foramtStr
        
        return formatter.string(from: self)
    }
    
    func days(from fromDate: Date) -> Int {
        let dateComponents = Calendar.current.dateComponents([.day], from: fromDate, to: self)
        
        return dateComponents.day ?? 0
    }
    
    func daysFromNow() -> Int {
        return self.days(from: Date())
    }
}
