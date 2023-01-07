//
//  ColorViewModel.swift
//  ColorNotes
//
//  Created by JunHyuk Lim on 5/1/2023.
//

import SwiftUI
import RealmSwift
import UIKit

class ColorViewModel : ObservableObject {
    
    //ColorProperties
    @Published var colorId : ObjectId = ObjectId()
    @Published var preferredName : String = ""
    @Published var colorDescription : String = ""
    
    @Published var colorRed : Double = 1.0
    @Published var colorBlue : Double = 0.0
    @Published var colorGreen : Double = 0.0
    @Published var colorAlpha : Double = 0.0
    @Published var colorCode : String = ""
    @Published var isFavorited : Bool = false
    
    //Extension For Color Properties
    @Published var swiftUIColor : Color = Color.red
    @Published var drawOpacity : Double = 1.0
    @Published var drawUIColor : UIColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
    @Published var selectedColor : Color = Color.blue
    

    //View Page
    @Published var openAddPage = false

    //Fetched Data
    @Published var colors : [ColorModel] = []
    
    //Data Updation
    @Published var updateObject : ColorModel?
    
    //MARK: - INITIALISE
    init(){
        fetchData()
       
    }
    
    //MARK: - FUNCTION
    func selectedColorPickerWithUIColor() {
        
        let r: Double = Double(colorRed)
        let g: Double = Double(colorGreen)
        let b: Double = Double(colorBlue)
        let a: Double = Double(colorAlpha)
        swiftUIColor = Color(red: r, green: g, blue: b, opacity: a)
    }
            
    func getColorsFromPicker(pickerColor: Color) {
        let colorString = "\(pickerColor)"
        let colorArray: [String] = colorString.components(separatedBy: " ")
        
        let colorInt = pickerColor
        print(colorInt)

        if colorArray.count > 1 {
            
            var r: CGFloat = CGFloat((Float(colorArray[1]) ?? 1))
            var g: CGFloat = CGFloat((Float(colorArray[2]) ?? 1))
            var b: CGFloat = CGFloat((Float(colorArray[3]) ?? 1))
            let alpha: CGFloat = CGFloat((Float(colorArray[4]) ?? 1))

            //
            if (r < 0.0) {r = 0.0}
            if (g < 0.0) {g = 0.0}
            if (b < 0.0) {b = 0.0}

            if (r > 1.0) {r = 1.0}
            if (g > 1.0) {g = 1.0}
            if (b > 1.0) {b = 1.0}
            //
            
            colorRed = r
            colorBlue = b
            colorGreen = g
            colorAlpha = alpha
            
            // Update UIColor
            drawUIColor = UIColor(red: r, green: g, blue: b, alpha: alpha)
            // Update Opacity
            drawOpacity = Double(alpha)
            
            

            // Update hex
            let rgb:Int = (Int)(round(r*255))<<16 | (Int)(round(g*255))<<8 | (Int)(round(b*255))<<0
            colorCode = String(format: "#%06X", rgb)
        }
        
        

    }
    
    
    //MARK: - REALM DATABASE
    //Fetching Data
    func fetchData(){
        guard let dbRef = try? Realm() else {return}
        
        let results = dbRef.objects(ColorModel.self).sorted(byKeyPath: "id", ascending: false)
        
        //Display result
        self.colors = results.compactMap({ (color) -> ColorModel in
            return color
        })
    }
    
    //Realm - Adding New Data
    func addData(presentation: Binding<PresentationMode>) {
        
        let color = ColorModel()
        color.preferredName = preferredName
        color.colorDescription = colorDescription
        color.colorCode = colorCode
        color.colorRed = colorRed
        color.colorBlue = colorBlue
        color.colorGreen = colorGreen
        color.colorAlpha = colorAlpha
        
        guard let dbRef = try? Realm() else {return}
        
        //Write Data
        try? dbRef.write({
            
            //Checking and Writing Data
            guard let availableObject = updateObject else {
                dbRef.add(color)
                return
            }

            availableObject.preferredName = preferredName
            availableObject.colorDescription = colorDescription
            availableObject.colorCode = colorCode
            availableObject.colorRed = colorRed
            availableObject.colorBlue = colorBlue
            availableObject.colorGreen = colorGreen
            availableObject.colorAlpha = colorAlpha
    

        })
        //Updating UI
        fetchData()
        
        presentation.wrappedValue.dismiss()
    }
    
    //Deleting Data
    func deleteData(object : ColorModel) {
        
        guard let dbRef = try? Realm() else { return }
        try? dbRef.write{
            dbRef.delete(object)
            
            fetchData()
        }
    }
    
    
    //Setting and Clearing Data
    func setUpInitialData() {
        guard let updateData = updateObject else { return }
        
        colorId = updateData.id
        preferredName = updateData.preferredName
        colorDescription = updateData.colorDescription
        colorCode = updateData.colorCode
        colorRed = updateData.colorRed
        colorGreen = updateData.colorGreen
        colorBlue = updateData.colorBlue
        colorAlpha = updateData.colorAlpha
        
    }
    
    func deInitData(){
        updateObject = nil
        preferredName = ""
        colorDescription = ""
        colorCode = ""
//        colorRed = 1.0
//        colorGreen = 0.0
//        colorBlue = 0.0
//        colorAlpha = 1.0
    }
    
}
