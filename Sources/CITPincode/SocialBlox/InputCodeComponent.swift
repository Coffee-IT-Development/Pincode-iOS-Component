////
////  InputCodeComponent.swift
////  SocialBlox
////
////  Created by Mark Meesters on 22/10/2021.
////
//
////import Introspect
//import SwiftUI
//
//struct InputCodeComponent: View {
//    @ObservedObject private var inputModel: InputCodeModel
//    @State var textField: UITextField?
//    @State var didShowKeyboardInitially = false
//    
//    @Binding private var shouldShowKeyboard: Bool
//    private let shouldShowInvalidCodeState: Bool
//    
//    var body: some View {
//        ZStack {
//            backingTextField
//                .keyboardType(.numberPad)
//            
//            HStack {
//                ForEach(0..<inputModel.codeLength) { index in
//                    InputCodeCellComponent(
//                        character: inputModel.characters[index],
//                        isSelected: inputModel.currentIndex == index,
//                        isError: shouldShowInvalidCodeState
//                    )
//                    .onTapGesture {
//                        self.textField?.becomeFirstResponder()
//                    }
//                    .frame(maxWidth: .infinity)
//                }
//            }
//        }
//        .onChange(of: shouldShowKeyboard) { newValue in
//            if newValue {
//                textField?.becomeFirstResponder()
//            } else {
//                textField?.resignFirstResponder()
//            }
//        }
//    }
//    
//    private var backingTextField: some View {
//        TextField("", text: $inputModel.enteredCode)
////            .introspectTextField { textField in
////                self.textField = textField
////
////                if shouldShowKeyboard && !didShowKeyboardInitially {
////                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
////                        self.textField?.becomeFirstResponder()
////                        self.didShowKeyboardInitially = true
////                    }
////                }
////            }
//            .keyboardType(.numberPad)
//            .disableAutocorrection(true)
//            .opacity(0)
//    }
//    
//    init(inputModel: InputCodeModel, shouldShowKeyboard: Binding<Bool>, shouldShowInvalidCodeState: Bool) {
//        self.inputModel = inputModel
//        self._shouldShowKeyboard = shouldShowKeyboard
//        self.shouldShowInvalidCodeState = shouldShowInvalidCodeState
//    }
//}
//
//struct PincodeView_Previews: PreviewProvider {
//    static var previews: some View {
//        InputCodeComponent(inputModel: InputCodeModel(codeLength: 6), shouldShowKeyboard: .constant(false), shouldShowInvalidCodeState: false)
//    }
//}
