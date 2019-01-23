//
//  Double+.swift
//  DoorDashAssignment
//
//  Created by Renu Punjabi on 1/21/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation

/// Double extension to help with converting double into currency and other relevant helper methods
extension Double {
    
    func convertIntoCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = self - Double(Int(self)) == 0 ? 0 : 2

        guard let formattedCurrency = formatter.string(from: self as NSNumber) else {
            return String(describing: self)
        }
        return String(describing: formattedCurrency)
    }
}
