//
//  DiveModel.swift
//  Big Bath Dive journal
//
//


import SwiftUI


struct DiveModel: Codable, Hashable, Identifiable {
    var id = UUID()
    var location: DiveLocation
    var date: Date
    var depth: String
    var duration: String
    var mood: Mood
    var wildlife: [Wildlife]
    var imageData: Data?
    
    var image: UIImage? {
        get {
            guard let imageData else { return nil }
            return UIImage(data: imageData)
        }
        set {
            imageData = newValue?.jpegData(compressionQuality: 0.8)
        }
    }
    
}

extension DiveModel {
    var depthMeters: Double? {
        Double(firstNumber(in: depth))
    }
    
    var durationMinutes: Double? {
        if duration.contains(":") {
            let parts = duration.split(separator: ":").map { String($0) }
            guard parts.count >= 2,
                  let first = Double(parts[0]),
                  let second = Double(parts[1]) else {
                return Double(firstNumber(in: duration))
            }
            return first * 60 + second
        } else {
            return Double(firstNumber(in: duration))
        }
    }
    
    /// Достаём первое число из строки
    private func firstNumber(in string: String) -> String {
        let digits = string
            .filter { "0123456789.".contains($0) }
        // Например, "18 m" → "18", "42 min" → "42"
        return digits
    }
}

enum DiveLocation: String, Codable, CaseIterable {
    case greatBlueHole = "Great Blue Hole"
    case coralBay = "Coral Bay"
    case mantaReef = "Manta Reef"
    case turtleGarden = "Turtle Garden"
    case blueRibbonCaves = "Blue Ribbon Caves"
    case stingrayLaggon = "Stingray Lagoon"
    
}

enum Mood: String, Codable, CaseIterable, Identifiable {
    var id: String { rawValue }
    case happy = "happyIcon"
    case calm = "calmIcon"
    case neutral = "neutralIcon"
    case nervous = "nervousIcon"
    case excited = "excitedIcon"
    case sad = "sadIcon"
    case confident = "confidentIcon"
    case angry = "angryIcon"
}

extension Mood {
    var name: String {
        switch self {
        case .happy:     return "Happy"
        case .calm:      return "Calm"
        case .neutral:   return "Neutral"
        case .nervous:   return "Nervous"
        case .excited:   return "Excited"
        case .sad:       return "Sad"
        case .confident: return "Confident"
        case .angry:     return "Angry"
        }
    }
}

extension Mood {
    var color: Color {
        switch self {
        case .happy:     return Color(hex: "00AAFF") ?? .blue.opacity(0.5)
        case .calm:      return Color(hex: "0066FF") ?? .blue.opacity(0.7)
        case .neutral:   return Color(hex: "3700FF") ?? .blue
        case .nervous:   return Color(hex: "00FFD4") ?? .cyan
        case .excited:   return Color(hex: "FF00BF") ?? .pink
        case .sad:       return Color(hex: "FF8000") ?? .orange
        case .confident: return Color(hex: "00FF00") ?? .green
        case .angry:     return Color(hex: "FF0004") ?? .red
        }
    }
}

struct Wildlife: Codable, Hashable {
    var id = UUID()
    var name: String
    var description: String
    
    var imageData: Data?
    
    var image: UIImage? {
        get {
            guard let imageData else { return nil }
            return UIImage(data: imageData)
        }
        set {
            imageData = newValue?.jpegData(compressionQuality: 0.8)
        }
    }
}
