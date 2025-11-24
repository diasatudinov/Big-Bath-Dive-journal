//
//  BBNewDiveView.swift
//  Big Bath Dive journal
//
//

import SwiftUI
import PhotosUI

struct BBNewDiveView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: BBMyDivesViewModel
    @State private var showingImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var location: DiveLocation?
    @State private var showLocationList = false
    @State private var date: Date = Date.now
    @State private var depth: String = ""
    @State private var duration: String = ""
    @State private var mood: Mood?
    @State private var wildlife: [Wildlife] = []
    
    private let columns = [
        GridItem(.adaptive(minimum: 50), spacing: 50)
    ]
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
                            
                            Text("New dive")
                                .font(.system(size: 24, weight: .semibold))
                        }.foregroundStyle(.black)
                    }
                    Spacer()
                }.padding(.horizontal, 20)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Spacer()
                            if let selectedImage = selectedImage {
                                ZStack(alignment: .topTrailing) {
                                    
                                    
                                    Image(uiImage: selectedImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 120, height: 120)
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                        .overlay(alignment: .topTrailing) {
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(lineWidth: 1)
                                                .fill(Color(hex: "FE6404") ?? .orange)
                                            
                                        }
                                    
                                    Circle()
                                        .fill(Color(hex: "FE6404") ?? .orange)
                                        .frame(width: 22, height: 22)
                                        .overlay {
                                            Image(systemName: "xmark")
                                                .resizable()
                                                .frame(width: 12, height: 12)
                                        }
                                        .offset(x: 10, y: -10)
                                        .onTapGesture {
                                            withAnimation {
                                                self.selectedImage = nil
                                            }
                                        }
                                    
                                }
                                
                            } else {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color(hex: "005399")?.opacity(0.8) ?? .blue)
                                    .overlay {
                                        VStack {
                                            Image(systemName: "plus")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 42)
                                                .bold()
                                                .foregroundStyle(Color(hex: "FDE402") ?? .yellow)
                                                .frame(maxHeight: .infinity)
                                            
                                            Text("Select photo")
                                                .font(.system(size: 12))
                                                .foregroundStyle(.white)
                                        }.padding(10)
                                    }
                                    .frame(width: 120, height: 120)
                                    .onTapGesture {
                                        withAnimation {
                                            showingImagePicker = true
                                        }
                                    }
                            }
                            
                            Spacer()
                        }.padding(.top, 20)
                        
                        VStack(spacing: 16) {
                            
                            VStack(spacing: 16) {
                                dataCollectCell(title: "Location") {
                                    
                                    HStack(alignment: .bottom) {
                                        if let location = location {
                                            Text(location.rawValue)
                                                .font(.system(size: 16, weight: .regular))
                                            
                                            
                                        } else {
                                            Text("Choose a location")
                                                .font(.system(size: 16, weight: .regular))
                                                .foregroundStyle(Color(hex: "969696") ?? .secondary)
                                        }
                                        Spacer()
                                        Text("Select")
                                            .font(.system(size: 12, weight: .regular))
                                            .foregroundStyle(Color(hex: "005399") ?? .blue)
                                            .onTapGesture {
                                                withAnimation {
                                                    showLocationList = true
                                                }
                                            }
                                        
                                    }
                                }
                                
                                dataCollectCell(title: "Date") {
                                    
                                    HStack(alignment: .bottom) {
                                        DatePicker(
                                            "",
                                            selection: $date,
                                            displayedComponents: .date
                                        ).labelsHidden()
                                        
                                        Spacer()
                                        
                                    }
                                }
                                
                                dataCollectCell(title: "Depth, m") {
                                    
                                    HStack(alignment: .bottom) {
                                        TextField(text: $depth) {
                                            Text("Enter depth")
                                        }.keyboardType(.decimalPad)
                                        
                                        
                                    }
                                }
                                
                                dataCollectCell(title: "Duration, min") {
                                    
                                    HStack(alignment: .bottom) {
                                        TextField(text: $duration) {
                                            Text("Enter duration")
                                        }.keyboardType(.decimalPad)
                                        
                                        
                                    }
                                }
                                
                                dataCollectCell(title: "Mood") {
                                    
                                    LazyVGrid(columns: columns, spacing: 16) {
                                        ForEach(Mood.allCases) { mood in
                                            Button {
                                                self.mood = mood
                                            } label: {
                                                VStack(spacing: 8) {
                                                    Image(mood.rawValue)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 48, height: 48)
                                                    
                                                }
                                                .frame(maxWidth: .infinity)
                                                .background(
                                                    Circle()
                                                        .stroke(
                                                            self.mood == mood ? Color(hex: "FE6404") ?? .orange : Color.clear,
                                                            lineWidth: 10
                                                        )
                                                )
                                            }
                                            .buttonStyle(.plain)
                                        }
                                    }
                                    
                                }
                                
                                dataCollectCell(title: "Sea Creatures") {
                                    
                                    HStack(alignment: .bottom) {
                                        
                                        if !wildlife.isEmpty {
                                            Text(wildlife.first?.name ?? "")
                                                .font(.system(size: 16, weight: .regular))
                                            
                                            
                                        } else {
                                            Text("Add Wildlife")
                                                .font(.system(size: 16, weight: .regular))
                                                .foregroundStyle(Color(hex: "969696") ?? .secondary)
                                        }
                                        Spacer()
                                        
                                        
                                        NavigationLink {
                                            BBWildlifeView(wildlifes: $wildlife)
                                                .navigationBarBackButtonHidden()
                                        } label: {
                                            Text("+ Add")
                                                .font(.system(size: 12, weight: .regular))
                                                .foregroundStyle(Color(hex: "005399") ?? .blue)
                                        }
                                        
                                    }
                                }
                                
                            }
                            
                            Button {
                                if let selectedImage = selectedImage, let location = location, depth != "", duration != "", let mood = mood {
                                    viewModel.add(myDive: DiveModel(
                                        location: location,
                                        date: date,
                                        depth: depth,
                                        duration: duration,
                                        mood: mood,
                                        wildlife: wildlife,
                                        imageData: selectedImage.jpegData(compressionQuality: 0.8)
                                    ))
                                }
                                
                                if let location = location, selectedImage == nil, depth != "", duration != "", let mood = mood {
                                    viewModel.add(myDive: DiveModel(
                                        location: location,
                                        date: date,
                                        depth: depth,
                                        duration: duration,
                                        mood: mood,
                                        wildlife: wildlife
                                    ))
                                    
                                }
                                
                                dismiss()
                            } label: {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(checkDataFull() ? Color(hex: "FDE402") ?? .yellow : Color(hex: "969696") ?? .gray)
                                    .frame(width: 220, height: 70)
                                    .overlay {
                                        Text("Save")
                                            .font(.system(size: 36, weight: .semibold))
                                            .foregroundStyle(checkDataFull() ? Color(hex: "005399") ?? .blue : Color(hex: "2E2E2E") ?? .black)
                                    }
                            }
                            
                        }
                        
                        Spacer()
                    }.padding(.horizontal, 20)
                    
                }.background(Color(hex: "DFF1FB"))
                    .ignoresSafeArea(edges: .bottom)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(selectedImage: $selectedImage, isPresented: $showingImagePicker)
            }
            
            
            
            if showLocationList {
                
                ZStack {
                    Color.white.opacity(0.7).blur(radius: 5, opaque: false)
                    
                    
                    VStack(alignment: .leading) {
                        ForEach(DiveLocation.allCases, id: \.self) { location in
                            HStack {
                                
                                if location == self.location {
                                    Circle()
                                        .fill(Color(hex: "FDE402") ?? .yellow)
                                        .frame(height: 20)
                                        .overlay {
                                            Circle()
                                                .stroke(lineWidth: 1)
                                                .fill(Color(hex: "FE6404") ?? .orange)
                                        }
                                } else {
                                    Circle()
                                        .stroke(lineWidth: 1)
                                        .fill(Color(hex: "FE6404") ?? .orange)
                                        .frame(height: 20)
                                }
                                
                                Text(location.rawValue)
                                    .font(.system(size: 16))
                                    .foregroundStyle(.black)
                                
                            }
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                self.location = location
                                withAnimation {
                                    showLocationList = false
                                }
                            }
                            
                            if location != .stingrayLaggon {
                                RoundedRectangle(cornerRadius: 1)
                                    .fill(Color(hex: "005399") ?? .blue)
                                    .frame(height: 1)
                            }
                        }
                    }.padding(.vertical, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color(hex: "EBF8FF") ?? .white)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding(.horizontal, 60)
                    
                }
            }
        }
    }
    
    func checkDataFull() -> Bool {
        location != nil && depth != "" && duration != "" && mood != nil
    }
    
    func loadImage() {
        if let selectedImage = selectedImage {
            print("Selected image size: \(selectedImage.size)")
        }
    }
    
    func dataCollectCell<Content: View>(
        title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 20, weight: .medium))
            
            VStack(spacing: 4) {
                content()
                
                RoundedRectangle(cornerRadius: 1)
                    .fill(Color(hex: "005399") ?? .blue)
                    .frame(height: 1)
            }
        }
    }
}

#Preview {
    BBNewDiveView(viewModel: BBMyDivesViewModel())
}
