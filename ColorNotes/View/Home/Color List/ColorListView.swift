//
//  HomeView.swift
//  ColorNotes
//
//  Created by JunHyuk Lim on 5/1/2023.
//

import SwiftUI
import RealmSwift


struct ColorListView: View {
    //MARK: - PROPERTIES
    @StateObject var vm : ColorListViewModel
    
    let layout : [GridItem] = [
        GridItem(.flexible()),
    ]
    
    //MARK: - BODY
    var body: some View {
       
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: layout, alignment: .leading) {
                    ForEach(vm.keys, id:\.self) { key in
                        ZStack {
                            VStack(alignment:.leading) {
                                let items = vm.dic[key] ?? []
                                let orderedItems = items.sorted(by: {$0.addDate > $1.addDate})
                                //MARK: - CATEGORY
                                CategoryView(text: key)
                                
                                
                                //MARK: - COLOR LISTS
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(alignment: .center, spacing: 10) {
                                        ForEach(orderedItems) { item in
                                            NavigationLink {
                                                let vm = ColorDetailViewModel(colors: $vm.colors, color: item)
                                                ColorDetailView(vm:vm)
                                            } label: {
                                                ColorCell(color: item)
                                                    .padding(8)
                                            }
                                        }
                                    }
                                }
                            } //: VSTACK
                            .zIndex(1)
                            .padding()
                            
                            // BACKGROUND
                            RoundedRectangle(cornerRadius: 11)
                                .foregroundColor(Color("backgroundColor"))
                        } //: ZSTACK
                        .padding(.bottom, 12)
                    }
                    .onAppear{
                        vm.getColorData()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 12)
            .padding(.vertical, 4)
    
    }
}

//MARK: - PREVIEW
//struct ColorListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ColorListView(vm: ColorListViewModel())
//    }
//}
