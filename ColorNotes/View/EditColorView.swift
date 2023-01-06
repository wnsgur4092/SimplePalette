//
//  EditColorView.swift
//  ColorNotes
//
//  Created by JunHyuk Lim on 6/1/2023.
//

import SwiftUI

struct EditColorView: View {
    //MARK: - PROPERTIES
    @EnvironmentObject var modelData : ColorViewModel
    @Environment(\.dismiss) var dismiss
     

 
    
    //MARK: - BODY
    var body: some View {
        
        
        NavigationView {
            VStack {
                RoundedRectangle(cornerRadius: 6)
                    .foregroundColor(Color(UIColor(red: modelData.colorRed, green: modelData.colorGreen, blue: modelData.colorBlue, alpha:modelData.colorAlpha)))
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
                    modelData.addData()
                    dismiss()
                } label : {
                    HStack{
                        Image(systemName: "plus.app.fill")
                        Text("Save")
                    }
                }
            } //: VSTACK
            .navigationTitle((modelData.updateObject != nil) ? "Edit Color" : "Add New Color" )
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

struct EditColorView_Previews: PreviewProvider {
    static var previews: some View {
        EditColorView()
    }
}
