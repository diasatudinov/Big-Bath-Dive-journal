//
//  Untitled.swift
//  Big Bath Dive journal
//
//

import SwiftUI

extension DateFormatter {
    static let shortEnglish: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd MMM yyyy"  
        df.locale = Locale(identifier: "en_US_POSIX")
        return df
    }()
}
