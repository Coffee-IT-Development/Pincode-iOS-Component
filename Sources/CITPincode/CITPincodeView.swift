//
//  CITPincodeView.swift
//  
//
//  Created by Lex Brouwers on 03/06/2022.
//

import SwiftUI

public struct CITPincodeView: View {
    var config: CITPincodeConfig
    var cells: [CITPincodeCell]
    
    @State private var hasError: Bool = false
    @State private var resentCodeTimestamp: Date? = nil
    
    public init(config: CITPincodeConfig) {
        self.config = config
        
        var newCells: [CITPincodeCell] = []
        for i in 0 ..< config.codeLength {
            newCells.append(CITPincodeCell(
                config: config,
                character: "",
                isSelected: i == 0,
                hasError: false
            ))
        }
        
        self.cells = newCells
    }
    
    public var body: some View {
        VStack(alignment: config.resendButtonStyle.alignment) {
            HStack {
                ForEach((0 ..< config.codeLength), id: \.self) {
                    CITPincodeCellView(cell: cells[$0])
                    
                    if config.dividerStyle.afterIndex == $0 {
                        config.dividerView
                    }
                }
            }
            
            CITPincodeResendButton(config: config, resentCodeTimestamp: $resentCodeTimestamp)
        }
    }
}

struct CITPincodeView_Previews: PreviewProvider {
    static var previews: some View {
        CITPincodeView(config: .socialBlox)
    }
}
