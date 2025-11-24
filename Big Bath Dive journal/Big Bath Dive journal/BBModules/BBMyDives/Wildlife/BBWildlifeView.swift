//
//  BBWildlifeView.swift
//  Big Bath Dive journal
//
//

import SwiftUI

struct BBWildlifeView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var wildlifes: [Wildlife]
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
                            
                            Text("Add Wildlife")
                                .font(.system(size: 24, weight: .semibold))
                        }.foregroundStyle(.black)
                    }
                    
                    Spacer()
                }.padding(.horizontal, 20)
                
                
                VStack(alignment: .leading, spacing: 12) {
                    
                    
                    
                    if wildlifes.isEmpty {
                        Image(.noDivesImageBB)
                            .resizable()
                            .scaledToFit()
                            .padding(.horizontal, 31)
                            .padding(.top, 115)
                        
                        VStack(alignment: .center, spacing: 8) {
                            Text("No wildlife yet")
                                .font(.system(size: 24, weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .multilineTextAlignment(.center)
                            
                        }
                        Spacer()
                        
                    } else {
                        ScrollView(showsIndicators: false) {
                            VStack {
                                ForEach(wildlifes, id: \.self) { wildlife in
                                    BBWildlifeCellView(wildlife: wildlife)
                                }
                            }.padding(.top, 4).padding(.bottom)
                        }
                    }
                    
                }.padding(.horizontal, 20)
                    .background(Color(hex: "DFF1FB"))
                    .ignoresSafeArea(edges: .bottom)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
            VStack {
                Spacer()
                NavigationLink {
                    BBNewWildlifeView(wildlifes: $wildlifes)
                        .navigationBarBackButtonHidden()
                } label: {
                    Circle()
                        .fill(Color(hex: "FDE402") ?? .yellow)
                        .frame(height: 64)
                        .overlay {
                            Image(systemName: "plus")
                                .font(.system(size: 30, weight: .bold))
                                .foregroundStyle(Color(hex: "005399") ?? .blue)
                        }
                }
            }.padding(.bottom, 130)

        }
    }
}

#Preview {
    BBWildlifeView(wildlifes: .constant([]))
}
