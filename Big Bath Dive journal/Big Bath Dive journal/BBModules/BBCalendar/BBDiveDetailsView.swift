//
//  BBDiveDetailsView.swift
//  Big Bath Dive journal
//
//

import SwiftUI

struct BBDiveDetailsView: View {
    @Environment(\.dismiss) private var dismiss

    @State var dive: DiveModel
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        HStack(spacing: 13) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 24, weight: .regular))
                            
                            Text("\(DateFormatter.shortEnglish.string(from: dive.date))")
                                .font(.system(size: 24, weight: .semibold))
                        }.foregroundStyle(.black)
                    }
                    
                    Spacer()
                }.padding(.horizontal, 20)
                
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text(dive.location.rawValue)
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundStyle(Color(hex: "FE6404") ?? .orange)
                            Spacer()
                            Image(dive.mood.rawValue)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 20)
                        }
                        
                        Text("\(dive.depth) m / \(dive.duration) min")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundStyle(.black)
                    }
                    
                    ScrollView(showsIndicators: false) {
                        VStack {
                            ForEach(dive.wildlife, id: \.self) { wildlife in
                                BBWildlifeCellView(wildlife: wildlife)
                            }
                        }
                    }
                    
                }.padding(.horizontal, 20).padding(.top, 20)
                    .background(Color(hex: "DFF1FB"))
                    .ignoresSafeArea(edges: .bottom)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
        }.background(Color(hex: "EBF8FF").ignoresSafeArea())
    }
}

#Preview {
    BBDiveDetailsView(dive: DiveModel(
        location: .greatBlueHole,
        date: Date.now,
        depth: "27",
        duration: "50",
        mood: .happy,
        wildlife: [
            Wildlife(
                name: "Azure Stingray",
                description: "Wings with vivid blue edges that glow faintly in deep water."
            ),
            Wildlife(
                name: "Azure Stingray",
                description: "Wings with vivid blue edges that glow faintly in deep water."
            ),
            Wildlife(
                name: "Azure Stingray",
                description: "Wings with vivid blue edges that glow faintly in deep water."
            )
        ]
    )
    )
}
