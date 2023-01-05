//
//  HomeView.swift
//  ColorNotes
//
//  Created by JunHyuk Lim on 5/1/2023.
//

import SwiftUI

struct HomeView: View {
    //MARK: - PROPERTIES
    @StateObject var modelData = ColorViewModel()
    
    //MARK: - BODY
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(spacing:15){
                    ForEach(modelData.colors) { colorValue in
                        
                        //Color List
                        HStack{
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color(.red))
                                .frame(width: 140)
                                .clipped()
                            
                            VStack(alignment: .leading) {
                                Text(colorValue.colorCode)
                                    .font(.headline)
                                    .fontWeight(.medium)
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
                                    
                                    Image(systemName: "doc.on.doc")
                                        .frame(width: 32, height: 32)
                                    
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
                        .padding(.vertical, 8)
                        
                        .contentShape(RoundedRectangle(cornerRadius: 10))
                        .contextMenu {
                            Button {
                                modelData.updateObject = colorValue
                                modelData.openAddPage.toggle()
                            } label: {
                                Text("Update Item")
                            }
                            
                            Button {
                                modelData.deleteData(object: colorValue)
                            } label: {
                                Text("Delete Item")
                            }

                        }
                    }
                }
                .navigationTitle("Color Notes")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            modelData.openAddPage.toggle()
                        } label: {
                            Image(systemName: "plus")
                                .font(.title2)
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
