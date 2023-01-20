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
    @Environment(\.dismiss) var dismiss
    @StateObject var vm : ColorAddViewModel
    
    @FocusState private var focusField : Field?
    
    enum Field : Hashable {
        case cateogry, colorName, colorDescription
    }
    
    //    //MARK: - BODY
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section("Preview") {
                        
                        HStack {
                            Spacer()
                            VStack{
                                Rectangle()
                                    .foregroundColor(Color(UIColor(red: vm.colorRed, green: vm.colorGreen, blue: vm.colorBlue, alpha:vm.colorAlpha)))
                                
                                    .frame(width:180,height: 200)
                                    .cornerRadius(10)
                                    .padding(.horizontal, 6)
                                    .padding(.top, 6)
                                
                                
                            }
                            .frame(maxWidth: 200, maxHeight: 280)
                            .background(Color.primary.colorInvert())
                            .cornerRadius(10)
                            .shadow(color: Color.primary.opacity(0.05), radius: 1, x: 5, y: 5)
                            Spacer()
                        }
                        .padding(.bottom, 10)
                    }
                    
                    
                    Section("Select Color") {
                        ColorPicker("Select Color", selection: $vm.swiftUIColor)
                            .onChange(of: vm.swiftUIColor) { newValue in
                                vm.getColorsFromPicker(pickerColor: newValue)
                            }
                    }
                    
                    Section("Hexadecimal"){
                        HStack{
                            Text("\(vm.colorCode)")
                        }
                        
                    }
                    
                    
                    Section {
                        TextField("Enter Color's Cateogry", text: $vm.colorCategory)
                            .focused($focusField, equals: .cateogry)
                            .onTapGesture {
                                focusField = .cateogry
                            }
                    } header:{
                        Text("Category")
                    }
                    
                    Section {
                        TextField("Enter Color's name", text: $vm.preferredName, axis: .vertical)
                            .focused($focusField, equals: .colorName)
                            .onTapGesture {
                                focusField = .colorName
                            }
                        
                    } header: {
                        Text("Color Name")
                    }
                    
                    Section {
                        TextField("Enter Color's description", text: $vm.colorDescription, axis: .vertical)
                            .focused($focusField, equals: .colorDescription)
                            .onTapGesture {
                                focusField = .colorDescription
                            }
                            .multilineTextAlignment(.leading)
                            .lineLimit(5...5)
                            .frame(minHeight: 100)
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
                            .frame(width:200, height: 60)
                            .background(Color("LogoColor"))
                            .cornerRadius(30)
                            .font(.system(size:20)).fontWeight(.medium).foregroundColor(.white)
                            .shadow(color: Color.primary.opacity(0.15), radius: 1, x: 5, y: 5)
                            
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
                        dismiss()
                        
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
