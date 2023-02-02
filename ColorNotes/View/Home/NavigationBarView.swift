//
//  NavigationBarView.swift
//  ColorNotes
//
//  Created by JunHyuk Lim on 1/2/2023.
//

import SwiftUI

struct NavigationBarView: View {
    //MARK: - PROPERTIES
    @ObservedObject var colorListViewModel = ColorListViewModel()
    @State var isAnimated : Bool = false
    @State var isAddViewPresenting : Bool = false
    

    
    //MARK: - BODY
    var body: some View {
        HStack(alignment:.center){
            
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
            
            Spacer()
            
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
    }
}

//MARK: - PREVIEW
struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView()
    }
}
