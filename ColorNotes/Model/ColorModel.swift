//
//  ColorModel.swift
//  ColorNotes
//
//  Created by JunHyuk Lim on 5/1/2023.
//

import SwiftUI
import RealmSwift


//Create Realm Object

class ColorModel : Object, Identifiable {
    
    @Persisted(primaryKey : true) var id : ObjectId
    @Persisted var preferredName : String = ""
    @Persisted var colorDescription : String = ""
    @Persisted var colorRed : Double = 0.0
    @Persisted var colorBlue : Double = 0.0
    @Persisted var colorGreen : Double = 0.0
    @Persisted var colorAlpah : Double = 0.0
    @Persisted var colorCode : String = ""
    @Persisted var isFavorited : Bool = false
    
    
    
}
