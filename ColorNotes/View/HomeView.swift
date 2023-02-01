//
//  HomeView.swift
//  ColorNotes
//
//  Created by JunHyuk Lim on 1/2/2023.
//

import SwiftUI

struct HomeView: View {
    //MARK: - PROPERTIES
    @ObservedObject var colorListViewModel = ColorListViewModel()
    @State var isAddViewPresenting : Bool = false
    

    
    var body: some View {
        NavigationView {
            VStack{
                //MARK: - NAVIGATION VIEW
                NavigationBarView()
                
                ColorListView(vm: colorListViewModel)
                
                HStack{
                    Button {
                        print("New Button Tapped")
                        isAddViewPresenting = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                }
              
                
            }//: VSTACK
        } //: NAVIGATION
        .sheet(isPresented: $isAddViewPresenting) {
            let vm = ColorAddViewModel(isPresented: $isAddViewPresenting, colors: $colorListViewModel.colors)
            ColorAddView(vm: vm)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
