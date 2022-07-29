//
//  CITPincodeExampleView.swift
//  CITPincodeExample
//
//  Created by Lex Brouwers on 29/07/2022.
//

import SwiftUI
import CITPincode

struct CITPincodeExampleView: View {
    @State private var code = ""
    @State private var error: String?
    
    var body: some View {
        CITPincodeView(
            code: $code,
            error: $error,
            config: .example,
            onEnteredCode: onEnteredCode,
            onResendCode: onResendCode
        )
    }
    
    private func onEnteredCode(_ code: String) {
        
    }
    
    private func onResendCode() {
        
    }
}

struct CITPincodeExampleView_Previews: PreviewProvider {
    static var previews: some View {
        CITPincodeExampleView()
    }
}
