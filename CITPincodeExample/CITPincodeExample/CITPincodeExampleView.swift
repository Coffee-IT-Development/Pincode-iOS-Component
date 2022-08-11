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
    @State private var forceCooldownOnce = false
    @State private var customConfig: CITPincodeView.Configuration = .example
    @State private var customBackgroundColor = Color(CITPincodeExampleView.defaultBackgroundColor)
    private static let defaultBackgroundColor = #colorLiteral(red: 0.1906174421, green: 0.1514734626, blue: 0.2413256764, alpha: 1)
    
    var body: some View {
        VStack {
            Spacer()
        
            CITPincodeView(
                code: $code,
                error: $error,
                forceCooldownOnce: $forceCooldownOnce,
                config: customConfig,
                onEnteredCode: sendCode,
                onResendCode: sendCode
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
        .onAppear {
            forceCooldownOnce = true
            sendCode()
        }
    }
    
    /// Called when a code has been entered (e.g. 6 out of 6 characters) and when the resendCode button is pressed.
    /// Should contain logic to send a OTP code to the user, make sure to include the text "code" somewhere in the message for auto-fill OTP to work.
    /// May be called manually on appear to send a code. In that case, set forceCooldownOnce to true so the user temporarily can't trigger sendCode again using the resendCode button.
    private func sendCode() {
        
    }
}

struct CITPincodeExampleView_Previews: PreviewProvider {
    static var previews: some View {
        CITPincodeExampleView()
    }
}
