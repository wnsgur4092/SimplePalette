//
//  ColorDetailView.swift
//  ColorNotes
//
//  Created by JunHyuk Lim on 11/1/2023.
//

import SwiftUI
import SSToastMessage

struct ColorDetailView: View {
    //MARK: - PROPERTIES
    @StateObject var vm : ColorDetailViewModel
    @Environment(\.dismiss) var dismiss
    
    @GestureState var dragOffset = CGSize.zero
    
    @State var showingAlert = false
    @State var copyingAlert = false
    
    //MARK: - BODY
    var body: some View {
        VStack{
            ScrollView{
                VStack(alignment: .center, spacing: 0) {
                    Rectangle()
                        .fill(Color(UIColor(red: vm.color.colorRed, green: vm.color.colorGreen, blue: vm.color.colorBlue, alpha: vm.color.colorAlpha)))
                        .background(Color.primary.colorInvert())
                        .cornerRadius(10)
                        .shadow(color: Color.primary.opacity(0.15), radius: 1, x: 5, y: 5)
                        .frame(width: 300, height:200, alignment: .center)
                        .padding(.horizontal, 16)
                        .padding(.vertical,12)
                    
                    Spacer().frame(height: 15)
                    HStack(alignment: .center, spacing: 3) {
                        Spacer()
                        Text("Opacity: \(Int(vm.color.colorAlpha * 100))%")
                        Spacer()
                    }
                    
                    Divider().padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                    
                    HStack(alignment: .center) {
                        Image(systemName: "tag")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 23)
                        
                        Spacer().frame(width: 15)
                        Text(vm.color.colorCode)
                        
                        Spacer()
                        
                        Button {
                            UIPasteboard.general.string = vm.color.colorCode
                            copyingAlert = true
                        } label: {
                            Image(systemName: "doc.on.doc")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16)
                                .foregroundColor(.black)
                        }
                        
                        
                    }
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    
                    Divider().padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                    
                    VStack(alignment: .leading) {
                        
                        HStack(alignment: .center) {
                            Image(systemName: "pencil")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 23)
                            
                            Spacer().frame(width: 13)
                            Text("Color Name")
                                .fontWeight(.bold)
                                .frame(alignment: .leading)
                        }
                        
                        Spacer().frame(height:15)
                        Text(vm.color.preferredName)
                            .foregroundColor(Color.gray)
                        
                            .padding(.leading, 36)
                        Spacer().frame(height: 30)
                        
                        HStack(alignment: .center) {
                            Image(systemName:"ellipsis.message")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 23)
                            Spacer().frame(width: 13)
                            Text("Color Description")
                                .fontWeight(.bold)
                        }
                        
                        Spacer().frame(height: 15)
                        
                        Text(vm.color.colorDescription)
                            .foregroundColor(.gray)
                            .padding(.leading, 36)
                            .lineSpacing(5)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack{
                        Text(vm.color.colorCode)
                            .foregroundColor(Color.black)
                    }
                }
            }
        }
        .toolbarBackground(Color.white, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton, trailing: deleteButton)
        .present(isPresented: $copyingAlert, type: .floater(), position: .bottom, autohideDuration: 1.3) {
            copyToClipboardView()
        }
        
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
            if(value.startLocation.x < 20 && value.translation.width > 100) {
                self.dismiss()
            }
        }))
        
    }
    
    //MARK: - EXTENSION
    func copyToClipboardView() -> some View{
        VStack {
            Text("Copy to Clipboard")
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: 40)
        .background(Color(.gray))
        .cornerRadius(10)
        .padding(EdgeInsets(top: 10, leading: 50, bottom: 10, trailing: 50))
    }
    
    var backButton : some View {
        Button(
            action: {
                self.dismiss()
            }) {
                Image(systemName: "chevron.backward")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.black)
                    .frame(height: 40)
            }
    }
    
    
    var deleteButton : some View {
        Button {
            showingAlert = true
        } label: {
            Image(systemName: "trash")
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .frame(width: 16)
        }
        .alert("Delete this color", isPresented: $showingAlert) {
            Button("Cancel", role:.cancel){
                showingAlert = false
            }
            
            Button("Delete", role: .destructive){
                vm.deleteColorData()
                showingAlert = false
                self.dismiss()
            }
        } message: {
            Text("Are you sure to delete it?")
        }
        
    }
    
}
//MARK: - PREVIEW
struct ColorDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ColorDetailView(vm: ColorDetailViewModel(colors: .constant([]), color: ColorModel()))
    }
}
