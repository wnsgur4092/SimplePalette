//
//  ColorAddViewModel.swift
//  ColorNotes
//
//  Created by JunHyuk Lim on 11/1/2023.
//

import SwiftUI
import Combine
import RealmSwift

class ColorAddViewModel : ObservableObject {
    
    @Published var isPresented : Binding<Bool>
    
    @Published var colors : Binding<[ColorModel]>
    @Published var color : ColorModel = ColorModel()
    
    @Published var preferredName : String = "" //Color Name
    @Published var colorDescription : String = "" //Color Description
    
    @Published var colorRed : Double = 1.0 //Color R
    @Published var colorBlue : Double = 0.0 //Color B
    @Published var colorGreen : Double = 0.0 //Color G
    @Published var colorAlpha : Double = 1.0 //Color A
    @Published var colorCode : String = "#EB4E3D" //Color Code -> #
    @Published var colorCategory : String = ""
    @Published var isFavorited : Bool = false //Favorite
    
    //Extension For Color Properties
    @Published var swiftUIColor : Color = Color.red
    @Published var drawUIColor : UIColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
    @Published var selectedColor : Color = Color.blue
    
    var subscriptions = Set<AnyCancellable>()
    
    init(isPresented: Binding<Bool>, colors: Binding<[ColorModel]>){
        self.isPresented = isPresented
        self.colors = colors
        
        $colorCode.sink { colorCode in
            self.update(colorCode: colorCode)
        }.store(in: &subscriptions)
        
        $preferredName.sink { preferredName in
            self.update(preferredName: preferredName)
        }.store(in: &subscriptions)
        
        $colorRed.sink { colorRed in
            self.update(colorRed: colorRed)
        }.store(in: &subscriptions)
        
        $colorBlue.sink { colorBlue in
            self.update(colorBlue: colorBlue)
        }.store(in: &subscriptions)
        
        $colorGreen.sink { colorGreen in
            self.update(colorGreen: colorGreen)
        }.store(in: &subscriptions)
        
        $colorAlpha.sink { colorAlpha in
            self.update(colorAlpha: colorAlpha)
        }.store(in: &subscriptions)
        
        $colorCategory.sink { colorCategory in
            self.update(colorCategory: colorCategory)
        }.store(in: &subscriptions)
        
        $colorDescription.sink { colorDescription in
            self.update(colorDescription: colorDescription)
        }.store(in: &subscriptions)
    }
    
    //MARK: - FUNCTION
    private func update(preferredName : String) {
        self.color.preferredName = preferredName
    }
    
    private func update(colorRed : Double) {
        self.color.colorRed = colorRed
    }
    
    private func update(colorGreen : Double) {
        self.color.colorGreen = colorGreen
    }
    
    private func update(colorBlue : Double) {
        self.color.colorBlue = colorBlue
    }
    
    private func update(colorAlpha : Double) {
        self.color.colorAlpha = colorAlpha
    }
    
    private func update(colorCode : String) {
        self.color.colorCode = colorCode
    }
    
    private func update(colorDescription: String) {
        self.color.colorDescription = colorDescription
    }
    
    private func update(colorCategory : String) {
        self.color.colorCategory = colorCategory
    }
    
    //    private func update(isFavorited : Bool) {
    //        self.color.isFavorited = isFavorited
    //    }
    
    func saveData(){
        guard let realm = try? Realm() else {return}
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        self.color.addDate = formatter.string(from: Date())
        print("---> current time: \(color.addDate)")
        colors.wrappedValue.append(color)
        
        do{
            try realm.write{
                realm.add(color)
            }
        } catch let error{
            print("!!!! ColorAddViewModel realm error : \(error)")
        }
        
        isPresented.wrappedValue = false
        color = ColorModel()
        eraseForm()
        
        print(color.colorCode)
    }
    
    private func eraseForm(){
        preferredName = ""
        colorCode = "EB4E3D"
        colorRed = 0.0
        colorBlue = 0.0
        colorGreen = 0.0
        colorAlpha = 1.0
        colorCategory = ""
        colorDescription = ""
        
        swiftUIColor = Color.red
    }
    
    
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
            colorAlpha = Double(alpha)
            
            // Update hex
            let rgb:Int = (Int)(round(r*255))<<16 | (Int)(round(g*255))<<8 | (Int)(round(b*255))<<0
            var hexadecimal = String(format: "#%06X", rgb)
            
            colorCode = hexadecimal
        }
    }
}
