//
//  ColorViewModel.swift
//  ColorNotes
//
//  Created by JunHyuk Lim on 5/1/2023.
//

import SwiftUI
import RealmSwift
import Combine


class ColorListViewModel : ObservableObject {
    
    //MARK: - PREVIEW
    @Published var colors : [ColorModel] = []
    @Published var dic : [String : [ColorModel]] = [:]

    var subscription = Set<AnyCancellable>()
    
    init() {
        
        getColorData()
        print("---> Realm Data File Location :\(Realm.Configuration.defaultConfiguration.fileURL!)")
        bind()
        
    }
    
    var keys : [String] {
        return dic.keys.sorted {$0 < $1}
    }
    
    private func toArray(_ before: Results<ColorModel>) -> [ColorModel] {
        return before.compactMap{
            $0
        }
    }
    
    func getColorData() {
        guard let realm = try? Realm() else {return}
        
        let savedColor = realm.objects(ColorModel.self)
        
        try! realm.write{
            self.colors = savedColor.compactMap({$0})
        }
    }
    
    private func bind(){
        $colors.sink { items in
            print("---> List Changed : \(items)")
            self.dic = Dictionary(grouping: items, by: {$0.colorCategory})
            print("dic = \(self.dic)")
        }
        .store(in: &subscription)
    }

}
