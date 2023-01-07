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
    @Environment(\.presentationMode) var presentation
    @Environment(\.dismiss) var dismiss
    
    
    //MARK: - BODY
    var body: some View {
        NavigationView {
            VStack {
                RoundedRectangle(cornerRadius: 6)
                    .foregroundColor(Color(UIColor(red: modelData.colorRed, green: modelData.colorGreen, blue: modelData.colorBlue, alpha:modelData.colorAlpha)))
//                    .foregroundColor(modelData.swiftUIColor)
                    .frame(maxWidth: .infinity, maxHeight: 180)
                    .padding(.horizontal, 20)
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
                                
                            } label: {
                                Image(systemName: "doc.on.doc")
                            }

                        }
  
                    }
                    
                    
                    Section {
                        //INPUT preferred Name -> "COLOR NAME"
                        TextField("Enter Color Name", text: $modelData.preferredName)
                        
                        //INPUT colorDescription -> "COLOR DESCRIPTION"
                        TextField("Enter Description", text: $modelData.colorDescription)
                            .frame(minHeight: 120)
                    } header: {
                        Text("Optional")
                    }
                    .listStyle(GroupedListStyle())
                    
                }
                
                //Save Button
                Button{
                    modelData.addData(presentation: presentation)
                    dismiss()
                } label : {
                    HStack{
                        Image(systemName: "plus.app.fill")
                        Text("Save")
                    }
                }
            } //: VSTACK
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
