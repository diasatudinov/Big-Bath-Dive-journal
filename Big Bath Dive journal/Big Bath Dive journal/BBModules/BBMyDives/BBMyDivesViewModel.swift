//
//  BBMyDivesViewModel.swift
//  Big Bath Dive journal
//
//

import SwiftUI

class BBMyDivesViewModel: ObservableObject {
    // MARK: – Dives
    @Published var myDives: [DiveModel] = [
        DiveModel(
            location: .greatBlueHole,
            date: Date.now,
            depth: 27,
            duration: 50,
            mood: .happy,
            wildlife: Wildlife(
                name: "Azure Stingray",
                description: "Wings with vivid blue edges that glow faintly in deep water."
            )
        ),
        DiveModel(
            location: .greatBlueHole,
            date: Date.now,
            depth: 27,
            duration: 50,
            mood: .happy,
            wildlife: Wildlife(
                name: "Azure Stingray",
                description: "Wings with vivid blue edges that glow faintly in deep water."
            )
        ),
        DiveModel(
            location: .greatBlueHole,
            date: Date.now,
            depth: 27,
            duration: 50,
            mood: .happy,
            wildlife: Wildlife(
                name: "Azure Stingray",
                description: "Wings with vivid blue edges that glow faintly in deep water."
            )
        ),
        DiveModel(
            location: .greatBlueHole,
            date: Date.now,
            depth: 27,
            duration: 50,
            mood: .happy,
            wildlife: Wildlife(
                name: "Azure Stingray",
                description: "Wings with vivid blue edges that glow faintly in deep water."
            )
        ),
        DiveModel(
            location: .greatBlueHole,
            date: Date.now,
            depth: 27,
            duration: 50,
            mood: .happy,
            wildlife: Wildlife(
                name: "Azure Stingray",
                description: "Wings with vivid blue edges that glow faintly in deep water."
            )
        ),
        DiveModel(
            location: .greatBlueHole,
            date: Date.now,
            depth: 27,
            duration: 50,
            mood: .happy,
            wildlife: Wildlife(
                name: "Azure Stingray",
                description: "Wings with vivid blue edges that glow faintly in deep water."
            )
        ),
        
        DiveModel(
            location: .greatBlueHole,
            date: Date.now,
            depth: 27,
            duration: 50,
            mood: .happy,
            wildlife: Wildlife(
                name: "Azure Stingray",
                description: "Wings with vivid blue edges that glow faintly in deep water."
            )
        ),
        DiveModel(
            location: .greatBlueHole,
            date: Date.now,
            depth: 27,
            duration: 50,
            mood: .happy,
            wildlife: Wildlife(
                name: "Azure Stingray",
                description: "Wings with vivid blue edges that glow faintly in deep water."
            )
        ),
        DiveModel(
            location: .greatBlueHole,
            date: Date.now,
            depth: 27,
            duration: 50,
            mood: .happy,
            wildlife: Wildlife(
                name: "Azure Stingray",
                description: "Wings with vivid blue edges that glow faintly in deep water."
            )
        ),
        DiveModel(
            location: .greatBlueHole,
            date: Date.now,
            depth: 27,
            duration: 50,
            mood: .happy,
            wildlife: Wildlife(
                name: "Azure Stingray",
                description: "Wings with vivid blue edges that glow faintly in deep water."
            )
        ),
        DiveModel(
            location: .greatBlueHole,
            date: Date.now,
            depth: 27,
            duration: 50,
            mood: .happy,
            wildlife: Wildlife(
                name: "Azure Stingray",
                description: "Wings with vivid blue edges that glow faintly in deep water."
            )
        ),
        DiveModel(
            location: .greatBlueHole,
            date: Date.now,
            depth: 27,
            duration: 50,
            mood: .happy,
            wildlife: Wildlife(
                name: "Azure Stingray",
                description: "Wings with vivid blue edges that glow faintly in deep water."
            )
        )
    ] {
        didSet { saveMyDives() }
    }
    
    // MARK: – UserDefaults keys
    private let myDivesKey = "myDivesKey"
    
    // MARK: – Init
    init() {
        loadMyDives()
    }
    
    // MARK: – Save / Load Backgrounds
    
    private func saveMyDives() {
        guard let data = try? JSONEncoder().encode(myDives) else { return }
        UserDefaults.standard.set(data, forKey: myDivesKey)
    }
    
    private func loadMyDives() {
        if let data = UserDefaults.standard.data(forKey: myDivesKey),
           let items = try? JSONDecoder().decode([DiveModel].self, from: data) {
            myDives = items
        }
    }
    
    // MARK: – Example buy action
    func add(myDive: DiveModel) {
        guard !myDives.contains(myDive) else { return }
        myDives.append(myDive)
        
    }
}

struct DiveModel: Codable, Hashable {
    var id = UUID()
    var location: DiveLocation
    var date: Date
    var depth: Double
    var duration: Double
    var mood: Mood
    var wildlife: Wildlife
}

enum DiveLocation: String, Codable {
    case greatBlueHole = "Great Blue Hole"
    case coralBay = "Coral Bay"
    case mantaReef = "Manta Reef"
    case turtleGarden = "Turtle Garden"
    case blueRibbonCaves = "Blue Ribbon Caves"
    case stingrayLaggon = "Stingray Lagoon"
    
}

enum Mood: String, Codable {
    case happy = "happyIcon"
    case calm = "calmIcon"
    case neutral = "neutralIcon"
    case nervous = "nervousIcon"
    case excited = "excitedIcon"
    case sad = "sadIcon"
    case confident = "confidentIcon"
    case angry = "angryIcon"
}

struct Wildlife: Codable, Hashable {
    var id = UUID()
    var name: String
    var description: String
}
