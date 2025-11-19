//
//  BBMenuView.swift
//  Big Bath Dive journal
//
//

import SwiftUI

struct BBMenuContainer: View {
    
    @AppStorage("firstOpen") var firstOpen: Bool = true
    var body: some View {
        ZStack {
            if firstOpen {
                BBOnboardingView(getStartBtnTapped: {
                    firstOpen = false
                })
            } else {
                BBMenuView()
            }
        }
    }
}

struct BBMenuView: View {
    @State var selectedTab = 0
    private let tabs = ["My dives", "Calendar", "Stats"]
        
    var body: some View {
        ZStack {
            
            switch selectedTab {
            case 0:
                BBMyDivesView(viewModel: BBMyDivesViewModel())
            case 1:
                Text("2")
            case 2:
                Text("3")
            default:
                Text("default")
            }
            VStack {
                Spacer()
                
                HStack(spacing: 24) {
                    ForEach(0..<tabs.count) { index in
                        Button(action: {
                            selectedTab = index
                        }) {
                            VStack {
                                Image(selectedTab == index ? selectedIcon(for: index) : icon(for: index))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 44)
                                
                                Text(text(for: index))
                                    .font(.system(size: 10, weight: .medium))
                                    .foregroundStyle(.white)
                            }
                            
                        }
                        
                    }
                }.padding(.vertical, 12)
                    .padding(.horizontal, 30)
                    .background(Color(hex: "005399")?.opacity(0.8))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                
                
            }.padding(.bottom, 30)
            .ignoresSafeArea()
                
            
        }
    }
    
    private func icon(for index: Int) -> String {
        switch index {
        case 0: return "tab1Icon"
        case 1: return "tab2Icon"
        case 2: return "tab3Icon"
        default: return ""
        }
    }
    
    private func selectedIcon(for index: Int) -> String {
        switch index {
        case 0: return "tab1IconSelected"
        case 1: return "tab2IconSelected"
        case 2: return "tab3IconSelected"
        default: return ""
        }
    }
    
    private func text(for index: Int) -> String {
        switch index {
        case 0: return "My dives"
        case 1: return "Calendar"
        case 2: return "Stats"
        default: return ""
        }
    }
}


#Preview {
    BBMenuView()
}
