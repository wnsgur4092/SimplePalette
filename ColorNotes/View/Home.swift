//
//  Home.swift
//  ColorNotes
//
//  Created by JunHyuk Lim on 11/1/2023.
//

import SwiftUI

struct Home: View {
    //MARK: - PROPERTIES
    @ObservedObject var vm : ColorListViewModel
    @State var isPresenting : Bool = false
    
    var body: some View {
        NavigationView {
            ColorListView(vm: vm)
            
            
                .toolbar {
                    ToolbarItem(placement:.principal) {
                        
                        HStack{
                            Text("Color Notes")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            Button {
                                print("New Button Tapped")
                                isPresenting = true
                            } label: {
                                Image(systemName: "plus.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.black)
                                    .frame(width: 30, height: 30)
                                
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    }
                }
                .accentColor(Color(.white))
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(
                    Color(.white),
                    for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
        }
        .sheet(isPresented: $isPresenting) {
            let vm = ColorAddViewModel(isPresented: $isPresenting, colors: $vm.colors)
            ColorAddView(vm: vm)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(vm: ColorListViewModel())
    }
}