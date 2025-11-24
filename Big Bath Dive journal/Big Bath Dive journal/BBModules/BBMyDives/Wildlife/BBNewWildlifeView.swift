//
//  BBWildlifeView.swift
//  Big Bath Dive journal
//
//

import SwiftUI

struct BBNewWildlifeView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showingImagePicker = false
    @Binding var wildlifes: [Wildlife]
    @State private var selectedImage: UIImage?
    @State private var title: String = ""
    @State private var description: String = ""

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
                                
                                dataCollectCell(title: "Title") {
                                    
                                    HStack(alignment: .bottom) {
                                        TextField(text: $title) {
                                            Text("Enter the name")
                                        }.keyboardType(.decimalPad)
                                        
                                        
                                    }
                                }
                                
                                dataCollectCell(title: "Description") {
                                    
                                    HStack(alignment: .bottom) {
                                        TextField(text: $description) {
                                            Text("Enter description")
                                        }.keyboardType(.decimalPad)
                                        
                                        
                                    }
                                }
                                
                            }
                            
                            Button {
                                if let selectedImage = selectedImage, title != "", description != "" {
                                    
                                    wildlifes.append(
                                        Wildlife(
                                            name: title,
                                            description: description,
                                            imageData: selectedImage.jpegData(compressionQuality: 0.8)
                                        )
                                    )
                                    
                                }
                                
                                if selectedImage == nil, title != "", description != "" {
                                    wildlifes.append(
                                        Wildlife(
                                            name: title,
                                            description: description
                                        )
                                    )
                                    
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
        }
    }
    
    func checkDataFull() -> Bool {
        title != "" && description != ""
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
    
        func loadImage() {
            if let selectedImage = selectedImage {
                print("Selected image size: \(selectedImage.size)")
            }
        }
}

#Preview {
    BBNewWildlifeView(wildlifes: .constant([]))
}
