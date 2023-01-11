//
//  ColorModel.swift
//  ColorNotes
//
//  Created by JunHyuk Lim on 5/1/2023.
//

import SwiftUI
import RealmSwift


//Create Realm Object

class ColorModel : Object, Identifiable, Codable {
    
//    @Persisted(primaryKey: true) var colorId : ObjectId
    
    @Persisted var id : UUID = UUID()
    @Persisted var preferredName : String = ""
    @Persisted var colorDescription : String = ""
    @Persisted var colorRed : Double = 1.0
    @Persisted var colorBlue : Double = 0.0
    @Persisted var colorGreen : Double = 0.0
    @Persisted var colorAlpha : Double = 1.0
    @Persisted var colorCode : String = ""
    @Persisted var isFavorited : Bool = false
    @Persisted var addDate : String = ""
    
    @Persisted var colorCategory : String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

