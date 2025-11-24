//
//  BBMyDivesViewModel.swift
//  Big Bath Dive journal
//
//

import SwiftUI

class BBMyDivesViewModel: ObservableObject {
    // MARK: – Dives
    @Published var myDives: [DiveModel] = [
        
    ] {
        didSet { saveMyDives() }
    }
    
    // MARK: – UserDefaults keys
    private var fileURL: URL {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return dir.appendingPathComponent("myDives.json")
    }
    // MARK: – Init
    init() {
        loadMyDives()
    }
    
    // MARK: – Save / Load Backgrounds
    
    private func saveMyDives() {
        let url = fileURL
        do {
            let data = try JSONEncoder().encode(myDives)
            try data.write(to: url, options: [.atomic])
        } catch {
            print("Failed to save myDives:", error)
        }
    }
    
    private func loadMyDives() {
        let url = fileURL
        guard FileManager.default.fileExists(atPath: url.path) else {
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let dives = try JSONDecoder().decode([DiveModel].self, from: data)
            myDives = dives
        } catch {
            print("Failed to load myDives:", error)
        }
    }
    
    // MARK: – Example buy action
    func add(myDive: DiveModel) {
        guard !myDives.contains(myDive) else { return }
        myDives.append(myDive)
        
    }
    
    func delete(myDive: DiveModel) {
        guard let index = myDives.firstIndex(of: myDive) else { return }
        myDives.remove(at: index)
    }
    
    func showAvgDepth(monthDives: [DiveModel]) -> Double {
        var sumDepth = 0.0
        for dive in monthDives {
            sumDepth += (Double(dive.depth) ?? 0.0)
        }
        return sumDepth / Double(monthDives.count)
    }
    
    func showAvgDuration(monthDives: [DiveModel]) -> Double {
        var sumDuration = 0.0
        for dive in monthDives {
            sumDuration += (Double(dive.duration) ?? 0.0)
        }
        return sumDuration / Double(monthDives.count)
    }
    
    func showTop10Wildlife(monthDives: [DiveModel]) -> [(wildlife: Wildlife, count: Int)] {
        // Ключ — название, значение — (любой Wildlife с таким именем, количество)
        var counts: [String: (wildlife: Wildlife, count: Int)] = [:]
        
        for dive in monthDives {
            for item in dive.wildlife {
                let name = item.name
                
                if var entry = counts[name] {
                    entry.count += 1
                    counts[name] = entry
                } else {
                    counts[name] = (wildlife: item, count: 1)
                }
            }
        }
        
        // Берём массив значений, сортируем по count убыванию
        let sorted = counts.values.sorted { $0.count > $1.count }
        
        // Возвращаем только топ-10
        return Array(sorted.prefix(10))
    }
}
