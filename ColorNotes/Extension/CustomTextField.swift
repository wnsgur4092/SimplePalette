//
//  CustomTextField.swift
//  ColorNotes
//
//  Created by JunHyuk Lim on 2/2/2023.
//

import SwiftUI

struct CustomTextField: View {
    
//    @ObservedObject var vm = ViewModel()
    
    var placeholder : String
    
    
    @State var textInTextField : String
    @State var isFocusing : Bool
//    @State var numberOfText : String
    
    //    @Binding var textInTextField : String
    //    @Binding var isFocusing : Bool

    
    var body: some View {
        
        ZStack {
            FirstResponderTextField(text: $textInTextField, placeholder: placeholder, font: UIFont(name: "NanumGothicBold", size: 14), isFocused: $isFocusing)
                .foregroundColor(Color("text"))
                .padding(16)
//                .frame(width: 340, height: 52)
            
            
            
            
            RoundedRectangle(cornerRadius: 8)
                .stroke(isFocusing ? Color.blue : Color("border"), lineWidth: 1)
//                .frame(width: 340, height: 52)
            
        }

    }
}

//MARK: - FOCUS STATE in iOS 14
struct FirstResponderTextField : UIViewRepresentable {
    @Binding var text : String
    let placeholder : String
    let font: UIFont?
    @Binding var isFocused: Bool
    
    
    class Coordinator : NSObject, UITextFieldDelegate {
        @Binding var text : String
        @Binding var isFocused : Bool
        var becameFirstResponder = false
        
        init(text: Binding<String>, isFocused : Binding<Bool>){
            self._text = text
            self._isFocused = isFocused
        }
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
        func textFieldDidBeginEditing(_ textField: UITextField) {
            isFocused = true
        }
        func textFieldDidEndEditing(_ textField: UITextField) {
            isFocused = false
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, isFocused : $isFocused)
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.placeholder = placeholder
        if let font = font {
            textField.font = font
        }
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        if context.coordinator.becameFirstResponder {
            uiView.becomeFirstResponder()
            context.coordinator.becameFirstResponder = false
        }
    }
}



struct TextFieldSection_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(placeholder: "", textInTextField: "", isFocusing: false)
    }
}

