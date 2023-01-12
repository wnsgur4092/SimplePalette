//
//  ColorDetailViewModel.swift
//  ColorNotes
//
//  Created by JunHyuk Lim on 11/1/2023.
//

import SwiftUI
import RealmSwift

class ColorDetailViewModel : ObservableObject{
    @Published var colors : Binding<[ColorModel]>
    @Published var color : ColorModel
    
    init(colors: Binding<[ColorModel]>, color: ColorModel) {
        self.colors = colors
        self.color = color
    }
    
    func deleteColorData(){
        let predicate = NSPredicate(format: "id == %@", color.id as CVarArg)
        
        guard let realm = try? Realm() else {return}
        if let filteredData = realm.objects(ColorModel.self).filter(predicate).first{
            try! realm.write{
                realm.delete(filteredData)
            }
        }
        
        color = ColorModel()
    }
    
    func getColorData() {
        guard let realm = try? Realm() else {return}
        
        let savedColor = realm.objects(ColorModel.self)
        
        try! realm.write{
            colors.wrappedValue = savedColor.compactMap({$0})
        }
    }
}


