//
//  BBWildlifeCellView.swift
//  Big Bath Dive journal
//
//

import SwiftUI

struct BBWildlifeCellView: View {
    var wildlife: Wildlife
    var body: some View {
        HStack(alignment: .center) {
            
            if let image = wildlife.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .padding(-16)
            } else {
                Image(systemName: "photo.fill")
                    .resizable()
                    .scaledToFit()
                    .padding(-16)
            }
            
            VStack(alignment: .leading ,spacing: 2) {
                HStack {
                    Text(wildlife.name)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(Color(hex: "FDE402") ?? .yellow)
                    Spacer()
                }
                
                Text(wildlife.description)
                    .font(.system(size: 12, weight: .medium))
                    .lineLimit(2)
                    .frame(height: 35)
                    .foregroundStyle(.white)
            }.padding(.leading)
                
            
        }
        .padding()
        .frame(height: 70)
        .background(Color(hex: "005399"))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        
    }
}

#Preview {
    BBWildlifeCellView(wildlife: Wildlife(name: "Azure", description: "asdasdasd dsadsad "))
}
