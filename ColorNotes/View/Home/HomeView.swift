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
    @State var isAnimated : Bool = false
    @State var isAddViewPresenting : Bool = false
    
    
    
    var body: some View {
        NavigationView {
            VStack{
                //MARK: - NAVIGATION VIEW
                HStack(alignment:.center){
                    
                    navigationBarView
                    
                    Spacer()
                    
                    createButtonView
                    
                }
                .padding(.horizontal, 16)
                .frame(maxHeight: 36)
                .opacity(isAnimated ? 1 : 0)
                .offset(x: 12, y:isAnimated ? 0 : -25)
                .onAppear {
                    withAnimation(.easeOut(duration: 0.5)) {
                        isAnimated = true
                    }
                }
                .sheet(isPresented: $isAddViewPresenting) {
                    let vm = ColorAddViewModel(isPresented: $isAddViewPresenting, colors: $colorListViewModel.colors)
                    ColorAddView(vm: vm)
                }
                
                //MARK: - COLOR LIST
                ColorListView(vm: colorListViewModel)
                    .edgesIgnoringSafeArea(.bottom)
            }//: VSTACK
            .background(Color.white)
        } //: NAVIGATION
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    
    //MARK: - COMPONENTS
    var navigationBarView : some View {
        HStack{
            Text("Simple".uppercased())
                .font(.title3)
                .fontWeight(.black)
                .foregroundColor(.black)
            
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30, alignment: .center)
            
            Text("Palette".uppercased())
                .font(.title3)
                .fontWeight(.black)
                .foregroundColor(.black)
        }
        .padding(.vertical, 8)
        
    }
    var createButtonView : some View{
        Button {
            isAddViewPresenting = true
        } label: {
            Image(systemName: "square.and.pencil")
                .resizable()
                .scaledToFit()
                .foregroundColor(.black)
                .frame(width: 20, height: 20)
                .padding(.horizontal, 20)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
