//
//  AddColorView.swift
//  ColorNotes
//
//  Created by JunHyuk Lim on 5/1/2023.
//

import SwiftUI

struct AddColorView: View {
    //MARK: - PROPERTIES
    @EnvironmentObject var modelData : ColorViewModel
    @Environment(\.dismiss) var dismiss
    
    
    //MARK: - BODY
    var body: some View {
        NavigationView {
            VStack {
                
                Circle()
                    .foregroundColor(Color(UIColor(red: modelData.colorRed, green: modelData.colorGreen, blue: modelData.colorBlue, alpha:modelData.colorAlpha)))
                    .frame(maxHeight: 140)
                    .padding(.horizontal, 12)
                    .padding(.top,8)
                
                
                List {
                    Section("Select Color") {
                        ColorPicker("Select Color", selection: $modelData.swiftUIColor)
                            .onChange(of: modelData.swiftUIColor) { newValue in
                                modelData.getColorsFromPicker(pickerColor: newValue)
                            }
                            .onAppear {
                                modelData.selectedColorPickerWithUIColor()
                            }
                    }
                    
                    Section("Hexadecimal"){
                        HStack{
                            Text("\(modelData.colorCode)").bold()
                            
                            Spacer()
                            
                            Button {
                                UIPasteboard.general.string = modelData.colorCode
                            } label: {
                                Image(systemName: "doc.on.doc")
                                    .foregroundColor(.black)
                            }
                            
                        }
                        
                    }
                    
                    
                    Section {
                        //INPUT preferred Name -> "COLOR NAME"
                        TextField("Enter Color's name", text: $modelData.preferredName, axis: .vertical)
                        
                        
                        //INPUT colorDescription -> "COLOR DESCRIPTION"
                        //                        ScrollView(.vertical, showsIndicators: true) {
                        TextField("Enter Color's description", text: $modelData.colorDescription, axis: .vertical)
                            .lineLimit(2...12)
                            .frame(minHeight: 150)
                        //                        }
                    } header: {
                        Text("Optional")
                    }
                    
                    .listStyle(.insetGrouped)
                    
                }
                
                //Save Button
                Button{
                        modelData.addData()
                        dismiss()

                } label : {
                    Capsule()
                        .fill(Color.black)
                        .frame(maxWidth: 120, minHeight: 30, maxHeight: 55)
                        .overlay(Text("Save".uppercased())
                            .font(.system(size:20)).fontWeight(.medium).foregroundColor(.white))
                        .padding(.vertical,8)
                }
                
                
            } //: VSTACK
            .background(Color(UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1)))
            
            .navigationTitle((modelData.updateObject == nil) ? "Add New Color" : "Edit the Color")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.black)
                    }
                    
                }
            }
        }
        .onAppear(perform: {
            modelData.setUpInitialData()
        })
        .onDisappear {
            modelData.deInitData()
        }
    }
}

struct AddColorView_Previews: PreviewProvider {
    static var previews: some View {
        AddColorView().environmentObject(ColorViewModel())
    }
}
