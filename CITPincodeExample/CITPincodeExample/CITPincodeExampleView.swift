//
//  CITPincodeExampleView.swift
//  CITPincodeExample
//
//  MIT License
//
//  Copyright (c) 2022 Coffee IT
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import SwiftUI
import CITPincode

struct CITPincodeExampleView: View {
    private static let defaultBackgroundColor = #colorLiteral(red: 0.1906174421, green: 0.1514734626, blue: 0.2413256764, alpha: 1)
    
    @State private var code = ""
    @State private var error: String?
    @State private var forceCooldownOnce = false
    @State private var customConfig: CITPincodeView.Configuration = .example
    @State private var customBackgroundColor = Color(CITPincodeExampleView.defaultBackgroundColor)
    
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
    /// Should contain logic to send a OTP code to the user:
    /// - Make sure to include the text "code" somewhere in the message for auto-fill OTP to work.
    /// - May be called manually to send a code. In that case, set forceCooldownOnce to true so the user
    /// temporarily can't trigger sendCode again using the resendCode button.
    private func sendCode() {
        
    }
}

struct CITPincodeExampleView_Previews: PreviewProvider {
    static var previews: some View {
        CITPincodeExampleView()
    }
}
