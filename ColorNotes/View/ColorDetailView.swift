//
//  ColorDetailView.swift
//  ColorNotes
//
//  Created by JunHyuk Lim on 11/1/2023.
//

import SwiftUI

struct ColorDetailView: View {
    //MARK: - PROPERTIES
    @StateObject var vm : ColorDetailViewModel
    
    //MARK: - BODY
    var body: some View {
        VStack{
            ScrollView{
                VStack(alignment: .leading, spacing: 0) {
                    
                    Rectangle()
                        .fill(Color(UIColor(red: vm.color.colorRed, green: vm.color.colorGreen, blue: vm.color.colorBlue, alpha: vm.color.colorAlpha)))
                        .cornerRadius(10)
                        .frame(height: 200)
                        .padding(.horizontal, 16)
                    
                    Spacer().frame(height:15)
                    
                    Divider().padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                    HStack(alignment: .center) {
                        Text(vm.color.colorCode)
                        
                        Spacer()
                        
                        Image(systemName: "doc.on.doc")
                    }
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    Divider().padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                }
                
                VStack(alignment: .leading) {
                    HStack(alignment: .center) {
                        Image(systemName: "tag")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 23)
                        
                        Spacer().frame(width: 13)
                        Text("Color Name")
                            .frame(alignment: .leading)
                        
                        Spacer()
                    }
                    Spacer().frame(height: 15)
                    Text("Yellow")
                        .padding(.leading, 36)
                    Spacer().frame(height: 30)
                    //                    Text(vm.color.preferredName)
                    
                    HStack(alignment: .center) {
                        Image(systemName: "ellipsis.message")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 23)
                        Spacer().frame(width: 13)
                        Text("Color Description")
                    }
                    
                    Spacer().frame(height: 15)
                    
                    Text(vm.color.colorDescription)
                        .padding(.leading,36)
                        .lineSpacing(5)
                        .frame(maxWidth:.infinity,maxHeight:.infinity,alignment: .leading)
                }
            }.padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
            
        }
        
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .principal) {
                VStack{
                    Text("Yellow")
                        .foregroundColor(Color.black)
                }
            }
        }

    }
    
    
    
}

//MARK: - PREVIEW
struct ColorDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ColorDetailView(vm: ColorDetailViewModel(colors: .constant([]), color: ColorModel()))
    }
}
