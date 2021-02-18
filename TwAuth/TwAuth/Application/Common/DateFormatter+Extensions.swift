//
//  DateFormatter+Extensions.swift
//  TwAuth
//
//  Created by Marlon David Ruiz Arroyave on 14/02/21.
//

import Foundation

extension Date {

    func verifyStringFormat() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "MMM d yyy, h:mm a"
        return formatter.string(from: self)
    }
}
