//
//  CategoryView.swift
//  ColorNotes
//
//  Created by JunHyuk Lim on 1/2/2023.
//

import SwiftUI

struct CategoryView: View {
    //MARK: - PROPERTIES
    let customFont = "RalewayRegular"
    
    var text : String
    
    //MARK: - PROPERTIES
    var body: some View {
        HStack(alignment:.center, spacing: 8){
            Image("tag")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20, alignment: .center)
                .foregroundColor(.gray)
            
            Text(text)
                .font(.custom("customFont", size: 18))
                .foregroundColor(.gray)
            
            Spacer()
        } //: HSTACK
        .padding()
        .background(Color.white.cornerRadius(12))
        .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray,lineWidth: 1))
        .padding(.top, 4)

    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(text: "test")
    }
}
