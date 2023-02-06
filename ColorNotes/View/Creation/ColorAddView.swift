//
//  AddColorView.swift
//  ColorNotes
//
//  Created by JunHyuk Lim on 5/1/2023.
//

import SwiftUI
import RealmSwift

struct ColorAddView: View {
    //MARK: - PROPERTIES
    //    @EnvironmentObject var vm : ColorListViewModel
    @Environment(\.presentationMode) var presentationMode
    @StateObject var vm : ColorAddViewModel

    //    //MARK: - BODY
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 28){
                    //MARK: - 1. PREVIEW
                    previewSection

                    //MARK: - SELECT COLOR
                    selectColorSection
                    
                    //MARK: - 2.HEXADECIMAL
                    hexadecimalSection

                    //MARK: - 3.CATEOGRY
                    categorySection

                    //MARK: - 4.COLOR NAME
                    colorNameSection

                    //MARK: - 5. COLOR DESCRIPTION
                    colorDescriptionSection
                }
                .padding(.horizontal, 25.5)
            }
            .background(Color.white)
            .navigationTitle("Add New Color")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    dismissButton
       
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    createButton
                }
            }
        }
    }
    
    //MARK: - COMPONENTS
    var previewSection : some View {
        VStack(alignment:.leading, spacing: 10){
            Rectangle()
                .foregroundColor(Color(UIColor(red: vm.colorRed, green: vm.colorGreen, blue: vm.colorBlue, alpha:vm.colorAlpha)))

                .frame(width:180,height: 200)
                .cornerRadius(10)
                .padding(.horizontal, 6)
                .padding(.top, 6)
        }
    }
    
    var selectColorSection : some View {
        VStack(alignment:.leading, spacing: 10){
            ZStack{
                ColorPicker("SELECT COLOR", selection: $vm.swiftUIColor)
                    .onChange(of: vm.swiftUIColor) { newValue in
                        vm.getColorsFromPicker(pickerColor: newValue)
                    }
                    .font(.custom("NanumGothic", size: 14))
                    .padding(16)

                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("border"), lineWidth: 1)
            }
        }
    }
    
    var hexadecimalSection : some View {
        VStack(alignment:.leading, spacing: 10){
            HStack(spacing: 12) {
                Image(systemName: "number.square")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 23)
                
                TitleView(title: "HEXADECIMAL")
          
            }

            ZStack{
                HStack {
                    Text("\(vm.colorCode)")
                        .font(.custom("NanumGothic", size: 14))
                        .padding(16)
                    Spacer()
                }


                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("border"), lineWidth: 1)
            }

        }
    }
    
    var categorySection : some View {
        VStack(alignment:.leading, spacing: 10){
            HStack(spacing: 12) {
                Image(systemName: "tag")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 23)
                
                TitleView(title: "CATEGORY")
            }
           
            CustomTextField(placeholder: "Enter Category of Color", textInTextField: $vm.colorCategory, isFocusing: vm.isCategoryFocuing)
        }
    }
    
    var colorNameSection : some View {
        VStack(alignment:.leading, spacing: 10){
            HStack(spacing: 12) {
                Image(systemName: "pencil")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 23)
                
                TitleView(title: "COLOR NAME")
            }
            CustomTextField(placeholder: "Enter preferred Color name", textInTextField: $vm.preferredName, isFocusing: vm.isNameFocusing)
        }
    }
    
    var colorDescriptionSection : some View {
        VStack(alignment:.leading, spacing: 10){
            HStack(spacing: 12) {
                Image(systemName:"ellipsis.message")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 23)
                
                TitleView(title: "COLOR DESCRIPTION")
            }
            CustomTextEditor(textInTextEditor: $vm.colorDescription, isFocusing: vm.isDescriptionFocusing)
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
    
    var dismissButton : some View {
        Button {
            presentationMode.wrappedValue.dismiss()

        } label: {
            Image(systemName: "arrow.left")
                .foregroundColor(.black)
        }
    }
    
    var createButton : some View {
        Button {
            vm.saveData()
        } label: {
            Text("Create")
        }
    }
}



//MARK: - PREVIEW
struct AddColorView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = ColorAddViewModel(isPresented: .constant(false), colors: .constant([]))
        
        ColorAddView(vm: vm)
    }
}
