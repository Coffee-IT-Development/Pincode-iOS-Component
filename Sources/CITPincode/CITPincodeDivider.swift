//
//  CITPincodeDivider.swift
//  
//
//  Created by Lex Brouwers on 24/06/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import SwiftUI

public struct CITPincodeDivider: View {
    private let configuration: CITPincodeView.Configuration
    
    public init(configuration: CITPincodeView.Configuration) {
        self.configuration = configuration
    }
    
    public var body: some View {
        RoundedRectangle(cornerRadius: configuration.dividerStyle.cornerRadius)
            .foregroundColor(configuration.dividerStyle.color)
            .frame(width: configuration.dividerStyle.size.width, height: configuration.dividerStyle.size.height)
    }
}
