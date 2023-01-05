//
//  ColorViewModel.swift
//  ColorNotes
//
//  Created by JunHyuk Lim on 5/1/2023.
//

import SwiftUI
import RealmSwift

class ColorViewModel : ObservableObject {
    
    @Published var preferredName : String = ""
    @Published var colorDescription : String = ""
    

    @Published var openAddPage = false
    
    //Fetched Data
    @Published var colors : [ColorModel] = []
    
    
    init(){
        fetchData()
    }
    
    
    //Fetching Data
    func fetchData(){
        guard let dbRef = try? Realm() else {return}
        
        let results = dbRef.objects(ColorModel.self)
        
        //Display result
        self.colors = results.compactMap({ (color) -> ColorModel in
            return color
        })
    }
    
    //Realm Adding New Data
    func addData() {
        let color = ColorModel()
        color.preferredName = preferredName
        color.colorDescription = colorDescription
        
        guard let dbRef = try? Realm() else {return}
        
        //Write Data
        try? dbRef.write({
            dbRef.add(color)
            
            //Updating UI
            fetchData()
        })
    }
    

    
}
