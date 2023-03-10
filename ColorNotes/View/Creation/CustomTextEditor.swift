//
//  CustomTextField.swift
//  ColorNotes
//
//  Created by JunHyuk Lim on 2/2/2023.
//

import SwiftUI

struct CustomTextEditor: View {
    
    @State var textInTextEditor : Binding<String>
    @State var isFocusing : Bool
    
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 8).stroke(isFocusing ? Color.blue : Color("border"), lineWidth: 1)
                .foregroundColor(.white)
            
            FirstResponderTextEditor(text: textInTextEditor, font: UIFont(name: "NanumGothic", size: 14), isFocused: $isFocusing)
                .padding(16)
                .frame(height: 200, alignment: .topLeading)
            
        }
    }
}


struct FirstResponderTextEditor: UIViewRepresentable {
    @Binding var text: String
    let font: UIFont?
    @Binding var isFocused: Bool
    
    
    class Coordinator: NSObject, UITextViewDelegate {
        @Binding var text: String
        @Binding var isFocused: Bool
        var becameFirstResponder = false
        
        init(text: Binding<String>, isFocused: Binding<Bool>) {
            self._text = text
            self._isFocused = isFocused
        }
        
        func textViewDidChange(_ textView: UITextView) {
            text = textView.text
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            isFocused = true
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            isFocused = false
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, isFocused: $isFocused)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.text = text
        textView.textContainer.lineFragmentPadding = 0
        if let font = font {
            textView.font = font
        }
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        if isFocused {
            uiView.becomeFirstResponder()
        }
        
//        if context.coordinator.becameFirstResponder {
//            uiView.becomeFirstResponder()
//            context.coordinator.becameFirstResponder = false
//        }
    }
}

struct CustomTextEditor_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextEditor(textInTextEditor: .constant(""), isFocusing: false)
    }
}

