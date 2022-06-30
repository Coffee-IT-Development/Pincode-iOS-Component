//
//  File 2.swift
//  
//
//  Created by Lex Brouwers on 24/06/2022.
//

import SwiftUI

public struct CITPincodeDivider: View {
    private let config: CITPincodeConfig
    
    public init(config: CITPincodeConfig) {
        self.config = config
    }
    
    public var body: some View {
        RoundedRectangle(cornerRadius: config.dividerStyle.cornerRadius)
            .foregroundColor(config.dividerStyle.color)
            .frame(width: config.dividerStyle.size.width, height: config.dividerStyle.size.height)
    }
}
