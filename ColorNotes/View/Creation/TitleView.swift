//
//  TitleView.swift
//  ColorNotes
//
//  Created by JunHyuk Lim on 2/2/2023.
//

import SwiftUI

struct TitleView: View {
    var title : String = ""
    
    var body: some View {
        
        Text(title)
            .foregroundColor(.black)

        
        
        
    }
}


struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
    }
}
