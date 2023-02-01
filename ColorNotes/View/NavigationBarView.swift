//
//  NavigationBarView.swift
//  ColorNotes
//
//  Created by JunHyuk Lim on 1/2/2023.
//

import SwiftUI

struct NavigationBarView: View {
    //MARK: - PROPERTIES
    @State var isAnimated : Bool = false
    

    
    //MARK: - BODY
    var body: some View {
        HStack(alignment:.center){
            
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
        .padding(12)
        .opacity(isAnimated ? 1 : 0)
        .offset(x: 12, y:isAnimated ? 0 : -25)
        .onAppear {
            withAnimation(.easeOut(duration: 0.5)) {
                isAnimated.toggle()
            }
        }
    }
}

//MARK: - PREVIEW
struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView()
    }
}
