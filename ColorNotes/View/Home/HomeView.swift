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
    

    
    var body: some View {
        NavigationView {
            VStack{
                //MARK: - NAVIGATION VIEW
                NavigationBarView()
                
//                if colorListViewModel.colors.isEmpty {
//                    VStack(alignment:.center) {
//                        Image("empty")
//                            .resizable()
//                            .scaledToFit()
//
//
//                        Text("Hmm...looks like you don't have any colors in Palette")
//                            .multilineTextAlignment(.center)
//                    }
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .padding(20)
//
//                } else {
                    
                    ColorListView(vm: colorListViewModel)
                        .edgesIgnoringSafeArea(.bottom)
        

 
            }//: VSTACK
            .background(Color.white)
            
 
        } //: NAVIGATION
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
