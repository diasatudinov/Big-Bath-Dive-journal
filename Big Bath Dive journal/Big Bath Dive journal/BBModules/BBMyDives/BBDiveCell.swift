//
//  BBDiveCell.swift
//  Big Bath Dive journal
//
//  Created by Dias Atudinov on 20.11.2025.
//

import SwiftUI

struct BBDiveCell: View {
    var dive: DiveModel
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text(DateFormatter.shortEnglish.string(from: dive.date))
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(.white)
                Spacer()
                Image(dive.mood.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
            }
            Spacer()
            HStack {
                Text(dive.location.rawValue)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(Color(hex: "FDE402") ?? .yellow)
                Spacer()
                Text("\(dive.depth) m / \(dive.duration) min")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(.white)
            }
            
        }
        .padding()
        .frame(height: 70)
        .background(Color(hex: "005399")?.opacity(0.8))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    BBDiveCell(dive: DiveModel(
        location: .greatBlueHole,
        date: Date.now,
        depth: "27",
        duration: "50",
        mood: .happy,
        wildlife: [Wildlife(
            name: "Azure Stingray",
            description: "Wings with vivid blue edges that glow faintly in deep water."
        )]
    ))
}
