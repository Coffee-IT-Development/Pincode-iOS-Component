//
//  CITPincodeDivider.swift
//  
//
//  Created by Lex Brouwers on 24/06/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import SwiftUI

struct CITPincodeDivider: View {
    private let config: CITPincodeView.Configuration
    
    init(config: CITPincodeView.Configuration) {
        self.config = config
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: config.dividerStyle.cornerRadius)
            .foregroundColor(config.dividerStyle.color)
            .frame(width: config.dividerStyle.size.width, height: config.dividerStyle.size.height)
    }
}
