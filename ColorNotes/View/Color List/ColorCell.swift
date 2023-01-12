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
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "doc.on.doc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                    }
                }
                
                
                
                HStack {
                    
                    Text("Opacity: \(Int(color.colorAlpha * 100))%")
                        .font(.footnote)
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
        .background(Color.primary.colorInvert())
        .cornerRadius(10)
        .shadow(color: Color.primary.opacity(0.15), radius: 1, x: 5, y: 5)

        
        
    }
}

struct ColorCell_Previews: PreviewProvider {
    static var previews: some View {
        
        ColorCell(color: ColorModel())
    }
}
