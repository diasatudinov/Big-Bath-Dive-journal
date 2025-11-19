//
//  Untitled.swift
//  Big Bath Dive journal
//
//  Created by Dias Atudinov on 19.11.2025.
//


import SwiftUI

extension Color {
    init?(hex: String) {
        // Убираем пробелы и решётку
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexString = hexString.replacingOccurrences(of: "#", with: "")

        // Поддерживаем 6 (RRGGBB) или 8 (AARRGGBB) символов
        guard hexString.count == 6 || hexString.count == 8,
              let int = UInt64(hexString, radix: 16) else {
            return nil
        }

        let r, g, b, a: Double

        if hexString.count == 6 {
            r = Double((int & 0xFF0000) >> 16) / 255
            g = Double((int & 0x00FF00) >> 8)  / 255
            b = Double(int & 0x0000FF) / 255
            a = 1.0
        } else {
            a = Double((int & 0xFF000000) >> 24) / 255
            r = Double((int & 0x00FF0000) >> 16) / 255
            g = Double((int & 0x0000FF00) >> 8)  / 255
            b = Double(int & 0x000000FF) / 255
        }

        self.init(.sRGB, red: r, green: g, blue: b, opacity: a)
    }
}
