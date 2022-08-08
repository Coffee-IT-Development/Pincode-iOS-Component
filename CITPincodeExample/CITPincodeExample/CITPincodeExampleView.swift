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
    @State private var customConfig: CITPincodeView.Configuration = .example
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
        .padding(.top, 40)
        .background(customBackgroundColor)
        .ignoresSafeArea(.container, edges: [.bottom, .top])
    }
    
    private func onEnteredCode(_ code: String) {
        // Called when a full-size code has been entered, e.g. 6 out of 6 characters.
    }
    
    private func onResendCode() {
        // Called on init if triggerResendCodeOnInit is true and when the Resend Code button is pressed.
        // Add code here to (re)send an OTP to the user's phone.
        // Make sure to include "code" somewhere in the message for auto-fill OTP to work.
    }
}

struct CITPincodeExampleView_Previews: PreviewProvider {
    static var previews: some View {
        CITPincodeExampleView()
    }
}
