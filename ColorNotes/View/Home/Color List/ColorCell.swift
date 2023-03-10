//
//  ColorCell.swift
//  ColorNotes
//
//  Created by JunHyuk Lim on 11/1/2023.
//

import SwiftUI


struct ColorCell: View {
    //MARK: - PROPERTIES
    var color : ColorModel
    
    
    //MARK: - BODY
    var body: some View {
        VStack{
            Rectangle()
                .fill(Color(UIColor(red: color.colorRed, green: color.colorGreen, blue: color.colorBlue, alpha: color.colorAlpha)))
                .frame(width:180,height: 200)
                .cornerRadius(10)
                .padding(.horizontal, 6)
                .padding(.top, 6)
            
            
            Divider()
            
            VStack{
                
                HStack {
                    Text(color.colorCode)
                        .font(.custom("NanumGothicRegular", size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Spacer()

                }
                
                
                
                HStack {
                    
                    Text("Opacity: \(Int(color.colorAlpha * 100))%")
                        .font(.custom("NanumGothicRegular", size: 14))
                        .foregroundColor(Color.gray)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    
                }
            }
            .padding(.vertical,4)
            .padding(.bottom, 4)
            .padding(.horizontal, 12)
            
            
        }

        .frame(maxWidth: 200, maxHeight: 280)
        .background(Color.white)
        .background(Color.primary.colorInvert())
        .cornerRadius(10)
        
        .shadow(color: Color.primary.opacity(0.05), radius: 1, x: 5, y: 5)

    }
    
    
    
    //MARK: - EXTENSION

}

//MARK: - PREVIEW
struct ColorCell_Previews: PreviewProvider {
    static var previews: some View {
        
        ColorCell(color: ColorModel())
    }
}
