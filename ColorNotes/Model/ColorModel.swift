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
    
}
