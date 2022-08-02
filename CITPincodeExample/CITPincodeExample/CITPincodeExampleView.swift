//
//  CITPincodeExampleView.swift
//  CITPincodeExample
//
//  Created by Lex Brouwers on 29/07/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import SwiftUI
import CITPincode

struct CITPincodeExampleView: View {
    @State private var code = ""
    @State private var error: String?
    @State private var customConfig: CITPincodeConfig = .example
    @State private var customBackgroundColor = Color(CITPincodeExampleView.defaultBackgroundColor)
    private static let defaultBackgroundColor = #colorLiteral(red: 0.1906174421, green: 0.1514734626, blue: 0.2413256764, alpha: 1)
    
    var body: some View {
        VStack {
            Spacer()
        
            CITPincodeView(
                code: $code,
                error: $error,
                config: customConfig,
                onEnteredCode: onEnteredCode,
                onResendCode: onResendCode
            )
            .padding(.vertical, 80)
            
            Spacer()
            
            CITPincodeCustomizeOptions(
                config: $customConfig,
                customBackgroundColor: $customBackgroundColor,
                error: $error
            )
        }
        .ignoresSafeArea(.container, edges: .bottom)
        .background(customBackgroundColor)
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
