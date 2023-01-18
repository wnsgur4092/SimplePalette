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
    @ObservedObject var vm : ColorListViewModel
        
    let layout : [GridItem] = [
        GridItem(.flexible()),
    ]
    
    //MARK: - BODY
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: layout, alignment: .leading) {
                    ForEach(vm.keys, id:\.self) { key in
                        Section {
                            let items = vm.dic[key] ?? []
                            let orderedItems = items.sorted(by: {$0.addDate > $1.addDate})
                            
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
                        } header: {
                            HStack(spacing: 7) {
                                Image(systemName: "pin.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(Color.gray)
                                    .frame(height: 23)
                                    .fontWeight(.bold)
                                Text(key)
                            }.foregroundColor(Color.black)
                                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
  
                        }
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))
                        Divider()
                        
                    }
                    .onAppear{
                        vm.getColorData()
                    }
                }
            }
        }.padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
    }
    

}

//MARK: - PREVIEW
struct ColorListView_Previews: PreviewProvider {
    static var previews: some View {
        ColorListView(vm: ColorListViewModel())
    }
}
