//
//  BBOnboardingView.swift
//  Big Bath Dive journal
//
//

import SwiftUI

struct BBOnboardingView: View {
    
    var getStartBtnTapped: () -> ()
    @State var count = 0
    
    var onbImage: Image {
        switch count {
        case 0:
            Image(.onboardingImg1)
        case 1:
            Image(.onboardingImg2)
        case 2:
            Image(.onboardingImg3)
        default:
            Image(.onboardingImg1)
        }
    }
    
    var onbTitle: String {
        switch count {
        case 0:
            "Record Every Dive"
        case 1:
            "Track Who You Meet\nUnderwater"
        case 2:
            "Understand Your Diving\nPatterns"
        default:
            "Record Every Dive"
        }
    }
    
    var onbDescription: String {
        switch count {
        case 0:
            "Save your depth, duration, photos, emotions, and locations - build your personal underwater story."
        case 1:
            "Choose from the built-in marine life list or create your own creatures to remember every encounter."
        case 2:
            "See your top creatures, mood distribution, and monthly diving stats at a glance."
        default:
            "Save your depth, duration, photos, emotions, and locations - build your personal underwater story."
        }
    }
    
    var body: some View {
        VStack {
            onbImage
                .resizable()
                .scaledToFit()
                .ignoresSafeArea(edges: .top)
            
            VStack {
                Text(onbTitle)
                    .font(.system(size: 32, weight: .semibold))
                    .multilineTextAlignment(.center)
                
                Text(onbDescription)
                    .font(.system(size: 20, weight: .medium))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                
            }.padding(.horizontal, 10)
            
            Spacer()
            
            VStack {
                
                HStack {
                    if count == 0 {
                        Rectangle()
                            .fill(Color(hex: "FE6404") ?? .orange)
                            .frame(width: 20, height: 10)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    } else {
                        Circle()
                            .stroke(lineWidth: 2)
                            .fill(Color(hex: "005399") ?? .blue)
                            .frame(width: 10, height: 10)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    
                    
                    if count == 1 {
                        Rectangle()
                            .fill(Color(hex: "FE6404") ?? .orange)
                            .frame(width: 20, height: 10)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    } else {
                        Circle()
                            .stroke(lineWidth: 2)
                            .fill(Color(hex: "005399") ?? .blue)
                            .frame(width: 10, height: 10)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    
                    if count == 2 {
                        Rectangle()
                            .fill(Color(hex: "FE6404") ?? .orange)
                            .frame(width: 20, height: 10)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    } else {
                        Circle()
                            .stroke(lineWidth: 2)
                            .fill(Color(hex: "005399") ?? .blue)
                            .frame(width: 10, height: 10)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }                }
                
                Button {
                    if count < 2 {
                        withAnimation {
                            count += 1
                        }
                    } else {
                        getStartBtnTapped()
                    }
                } label: {
                    Text(count < 2 ? "Next" : "Get Started")
                        .font(.system(size: 36, weight: .semibold))
                        .foregroundStyle(Color(hex: "005399") ?? .blue)
                        .padding(.vertical, 13)
                        .frame(width: 220)
                        .background(Color(hex: "FDE402"))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }.padding(.bottom, 30)
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color(hex: "DFF1FB"))
            .ignoresSafeArea()
    }
}

#Preview {
    BBOnboardingView(getStartBtnTapped: { })
}

//"DFF1FB"
//"FDE402"
