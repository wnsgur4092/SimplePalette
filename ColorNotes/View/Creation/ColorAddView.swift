//
//  AddColorView.swift
//  ColorNotes
//
//  Created by JunHyuk Lim on 5/1/2023.
//

import SwiftUI
import RealmSwift

struct ColorAddView: View {
    //MARK: - PROPERTIES
    //    @EnvironmentObject var vm : ColorListViewModel
    //    @Environment(\.dismiss) var dismiss
    @StateObject var vm : ColorAddViewModel
    
    
    //    //MARK: - BODY
    var body: some View {
        NavigationView {
            VStack {
                Circle()
                    .foregroundColor(Color(UIColor(red: vm.colorRed, green: vm.colorGreen, blue: vm.colorBlue, alpha:vm.colorAlpha)))
                    .frame(maxHeight: 140)
                    .padding(.horizontal, 12)
                    .padding(.top,8)
                
                
                Form {
                    Section("Select Color") {
                        ColorPicker("Select Color", selection: $vm.swiftUIColor)
                            .onChange(of: vm.swiftUIColor) { newValue in
                                vm.getColorsFromPicker(pickerColor: newValue)
                            }
                    }
                    
                    Section("Hexadecimal"){
                        HStack{
                            Text("\(vm.colorCode)").bold()
                            
                            Spacer()
                            
                            Button {
                                UIPasteboard.general.string = vm.colorCode
                            } label: {
                                Image(systemName: "doc.on.doc")
                                    .foregroundColor(.black)
                            }
                            
                        }
                        
                    }
                    
                    
                    Section {
                        TextField("Enter Color's Cateogry", text: $vm.colorCategory)
                    } header:{
                        Text("Category")
                    }
                    
                    Section {
                        TextField("Enter Color's name", text: $vm.preferredName, axis: .vertical)
                    } header: {
                        Text("Color Name")
                    }
                    
                    Section {
                        TextField("Enter Color's description", text: $vm.colorDescription, axis: .vertical)
                            .lineLimit(2...12)
                            .frame(minHeight: 150)
                    } header: {
                        Text("Color Description")
                    }
                    
                    Section{
                        HStack{
                            Spacer()
                            
                            Button {
                                vm.saveData()
                            } label: {
                                Text("Save".uppercased())
                            }
                            .foregroundColor(.white)
                            .frame(width:300, height: 60)
                            .background(Color.green)
                            .cornerRadius(30)
                            .font(.system(size:20)).fontWeight(.medium).foregroundColor(.white)
                            
                            Spacer()
                        }
                    }
                    .listRowBackground(Color(UIColor.clear))
                    .background(.clear)
                }

            }
            
            .navigationTitle("Add New Color")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        //                                dismiss()
                        //                                vm.setUpInitialData()
                        //                                vm.deInitData()
                    } label: {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.black)
                    }
                    
                }
            }
        }
    }
}


//MARK: - PREVIEW
struct AddColorView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = ColorAddViewModel(isPresented: .constant(false), colors: .constant([]))
        
        ColorAddView(vm: vm)
    }
}
