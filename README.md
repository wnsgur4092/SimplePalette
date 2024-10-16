# SimplePalette
> Simple Palette is a straightforward iOS app that allows users to input, visualize, and save color codes.
It’s designed for users who want a simple way to manage their color choices on the go.

Development periold: 05.01.2023 ~ 06.02.2023

[![appStore](https://user-images.githubusercontent.com/50910456/173174832-7d395623-ceb3-4796-b718-22e550af6934.svg)](https://apps.apple.com/au/app/simple-palette/id1667732751)

## Preview

<img src="https://user-images.githubusercontent.com/43236727/222941973-4d5ec342-6e56-408c-b556-023d82b91629.png">

![Simulator Screen Recording - iPhone 14 Pro - 2023-03-05 at 15 47 06](https://user-images.githubusercontent.com/43236727/222942198-c5229c52-aa7e-4262-ac56-7c3fc77ce0b8.gif)

## Update
- Version 1.0.0 : Realse on AppStore (08.02.2023)

## Develop Environment
- Language : Swift 5.6
- iOS Deployment Target : 14.0
- Xcode : 14.2

## Technical Skills
- UIKit
- SwiftUI
- MVVM
- Combine

## Libary
- Realm  
- SSToastMessage

## Privacy Policy
- [Privacy Policy](https://wnsgur4092.notion.site/Privacy-Policy-19722dcba877400784abd66352623d04)


## 💡Challenge
### 1. Why Realm?
Simple Palette uses MongoDB's Realm database, chosen for its ease of use with Swift and its powerful data visualization tool, Realm Studio. In the early stages of app development, it is often essential to visually inspect stored data, and Realm Studio makes this process straightforward, allowing developers to quickly verify data structures and contents.

Additionally, the following code snippet shows how you can retrieve the Realm database file location:
```Swift
class ColorListViewModel: ObservableObject {
    init() {
        getColorData()
        print("---> Realm Data File Location: \(Realm.Configuration.defaultConfiguration.fileURL!)")
        bind()
    }
}
```

### 2. UIKit + SwiftUI
The app's deployment target is iOS 14.0, which does not support the `@FocusState` (iOS 15.0 +) property. To handle text field focus states, I implemented CustomTextField and CustomTextEditor using UIKit. These custom components allow flexible management of focus states, improving user interaction even without `@FocusState.`

```swift
struct CustomTextField: View {
    var placeholder : String
    @State var textInTextField : Binding<String>
    @State var isFocusing : Bool
    
    
    var body: some View {
        
        ZStack {
            FirstResponderTextField(text: textInTextField, placeholder: placeholder, font: UIFont(name: "NanumGothic", size: 14), isFocused: $isFocusing)
                .foregroundColor(Color("text"))
                .padding(16)

            RoundedRectangle(cornerRadius: 8)
                .stroke(isFocusing ? Color.blue : Color("border"), lineWidth: 1)  
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
```

