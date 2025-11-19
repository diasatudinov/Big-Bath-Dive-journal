//
//  BBMyDivesView.swift
//  Big Bath Dive journal
//
//

import SwiftUI

struct BBMyDivesView: View {
    @ObservedObject var viewModel: BBMyDivesViewModel
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("My dives")
                        .font(.system(size: 24, weight: .semibold))
                    
                    Spacer()
                }.padding(.horizontal, 20)
                
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Your personal underwater diary")
                        .font(.system(size: 20, weight: .medium))
                        .padding(.top, 8)
                        .padding(.bottom, 115)
                    
                    Image(.noDivesImageBB)
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 31)
                    
                    VStack(alignment: .center, spacing: 8) {
                        Text("No dives yet")
                            .font(.system(size: 24, weight: .semibold))
                        // .multilineTextAlignment(.center)
                        
                        Text("Add your first one to start keeping an ocean diary.")
                            .font(.system(size: 20, weight: .medium))
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                    
                    
                    
                }.padding(.horizontal, 20)
                    .background(Color(hex: "DFF1FB"))
                    .ignoresSafeArea(edges: .bottom)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
            VStack {
                Spacer()
                Button {
                    
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
    BBMyDivesView(viewModel: BBMyDivesViewModel())
}
