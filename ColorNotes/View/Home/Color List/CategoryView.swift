//
//  CategoryView.swift
//  ColorNotes
//
//  Created by JunHyuk Lim on 1/2/2023.
//

import SwiftUI

struct CategoryView: View {
    //MARK: - PROPERTIES
    
    @State var text : String
    
    //MARK: - PROPERTIES
    var body: some View {
        HStack(alignment:.center, spacing: 8){
            Image("tag")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20, alignment: .center)
                .foregroundColor(.gray)
            
            Text(text)
                .font(.custom("Futura", size: 18).italic())
                .foregroundColor(.gray)
            
        }
        .padding(12)
        .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3),lineWidth: 1)        .shadow(color: .black.opacity(0.07), radius: 1, x: 2, y: 2))
        .padding(.vertical, 4)

        
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(text: "Font")
    }
}
