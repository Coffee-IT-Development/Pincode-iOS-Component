# ``CITPincode``

A customisable pincode view.

## Overview

The CITPincode package provides a customisable pincode view. 
It comes with an optional resend code button with a built-in cooldown and an optional divider to be placed anywhere between the cells.

## Usage

Import CITPincode and add a CITPincodeView to your SwiftUI view.

```swift
import SwiftUI
import CITPincode

struct CITPincodeExample: View {
    @State private var code = ""
    @State private var error: String?
    
    var body: some View {
        CITPincodeView(
            code: $code,
            error: $error,
            config: .socialBlox,
            onEnteredCode: onEnteredCode,
            onResendCode: onResendCode
        )
    }
    
    private func onEnteredCode(_ code: String) {
        
    }
    
    private func onResendCode() {
        
    }
}
```

Extra details:
- The error can be set to any text message or nil, the CITPincodeView will update dynamically.
- The code input can be used realtime via the code binding, but the code is also automatically passed to the onEnteredCode method once enough characters have been entered.
- The CITPincodeView is set to receive One Time Passcode(s) and can alternatively be long pressed to let the user paste a code directly from their clipboard.


## Maintainer

Actively maintained by Lex Brouwers.

## Changelog

#### 1.0.0

- Setup CITPincodeView, add customization & documentation.
