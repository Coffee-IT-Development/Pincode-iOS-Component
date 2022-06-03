////
////  InputCodeModel.swift
////
////
////  Created by Lex Brouwers on 03/06/2022.
////
//
//import Combine
//import SwiftUI
//
//class InputCodeModel: ObservableObject {
//    @Published var enteredCode: String = ""
//    @Published var codeToCheck: String?
//    
//    var currentIndex: Int { enteredCode.count }
//    let codeLength: Int
//    
//    /// Returns the currently inserted characters and fills the the rest with empty strings
//    var characters: [String] {
//        (0..<codeLength).reduce(into: [String]()) { partialResult, index in
//            if index <= enteredCode.count - 1 {
//                partialResult += [String(enteredCode[String.Index(encodedOffset: index)])]
//            } else {
//                partialResult += [""]
//            }
//        }
//    }
//    private var subscriptions: Set<AnyCancellable> = []
//    private var codeToCheckPublisher: AnyPublisher<String?, Never> {
//        $enteredCode
//            .map { enteredCode in
//                if enteredCode.count == self.codeLength {
//                    return enteredCode
//                } else {
//                    return nil
//                }
//            }
//            .eraseToAnyPublisher()
//    }
//    
//    init(codeLength: Int) {
//        self.codeLength = codeLength
//        
//        codeToCheckPublisher
//            .receive(on: RunLoop.main)
//            .assign(to: &$codeToCheck)
//    }
//}
