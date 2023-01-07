//
//  HomeView.swift
//  ColorNotes
//
//  Created by JunHyuk Lim on 5/1/2023.
//

import SwiftUI
import RealmSwift

struct HomeView: View {
    //MARK: - PROPERTIES
    @ObservedObject var modelData = ColorViewModel()
    
    //MARK: - BODY
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    Text("Color Notes")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button {
                        modelData.openAddPage.toggle()
                    } label: {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.black)
                            .frame(width: 30, height: 30)
                        
                    }
                }
                .padding()
                
                Divider()
                
                ScrollView{
                    
                    VStack(spacing:15)
                     {
                        ForEach(modelData.colors, id:\.self) { colorValue in
                            
                            //Color List
                            HStack{
                                HStack {
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(Color(UIColor(red: colorValue.colorRed, green: colorValue.colorGreen, blue: colorValue.colorBlue, alpha: colorValue.colorAlpha)))
                                        .frame(width: 140)
                                        .clipped()
                                    
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text(colorValue.colorCode)
                                                .font(.headline)
                                                .fontWeight(.medium)
                                            
                                            
                                            Spacer()
                                            
                                            Text("Alpha: \(Int(colorValue.colorAlpha * 100))%")
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                        }
                                        .padding(.bottom, 6)
                                        
                                        
                                        
                                        VStack(alignment:.leading) {
                                            Text(colorValue.preferredName)
                                                .font(.headline)
                                                .foregroundColor(.secondary)
                                            
                                            
                                            Text(colorValue.colorDescription)
                                                .font(.footnote)
                                                .foregroundColor(.secondary)
                                        }
                                        .padding(.top, 8)
                                        
                                        
                                        Spacer()
                                        
                                        
                                        HStack(spacing: 0) {
                                            Spacer()
                                            
                                            Button {
                                                UIPasteboard.general.string = colorValue.colorCode
                                            } label: {
                                                Image(systemName: "doc.on.doc")
                                                    .frame(width: 32, height: 32)
                                            }

                                            

                                            
                                            Image(systemName: "heart")
                                                .imageScale(.large)
                                                .frame(width: 32, height: 32)
                                        }
                                    }
                                    .padding([.leading, .bottom], 12)
                                    .padding([.top, .trailing])
                                }
                                .frame(height: 150)
                                .background(Color.primary.colorInvert())
                                .cornerRadius(6)
                                .shadow(color: Color.primary.opacity(0.33), radius: 1, x: 2, y: 2)
                                .padding(.leading, 8)
                                
                                Button {
                                    modelData.updateObject = colorValue
                                    modelData.openAddPage.toggle()
                                    
                                    
                                    print(modelData.colorRed)
                                    
                                } label: {
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.black)
                                        .padding(.trailing, 8)
                                }
                                .onTapGesture {
                                    modelData.selectedColor = modelData.swiftUIColor
                                }
                                .onAppear {
                                    modelData.selectedColorPickerWithUIColor()
                                }
                                
                                
                            }
                            Button(action: {
                                modelData.deleteData(object: colorValue)
                            }, label: {
                                Image(systemName: "trash")
                            })
                            
                            .contentShape(RoundedRectangle(cornerRadius: 10))
                            .contextMenu {
                                
                                Button {
                                    modelData.deleteData(object: colorValue)
                                } label: {
                                    Text("Delete Item")
                                }
                                
                            }
                        }
                    }
                    
                }
                .sheet(isPresented: $modelData.openAddPage) {
                    AddColorView().environmentObject(modelData)
                }
            }
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
