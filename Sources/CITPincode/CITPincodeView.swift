//
//  CITPincodeView.swift
//  
//
//  Created by Lex Brouwers on 03/06/2022.
//

import SwiftUI

public struct CITPincodeView<Content> : View where Content : View {
    let config: CITPincodeConfig
    var cells: [CITPincodeCell]
    let content: (([CITPincodeCell]) -> Content)?
    
    public init(config: CITPincodeConfig, content: (([CITPincodeCell]) -> Content)? = nil) {
        self.config = config
        self.content = content
        
        var newCells: [CITPincodeCell] = []
        for i in 0 ..< config.codeLength {
            newCells.append(CITPincodeCell(
                config: config,
                character: "",
                isSelected: i == 0
            ))
        }
        
        self.cells = newCells
    }
    
    public var body: some View {
        HStack {
            ForEach((0 ..< config.codeLength), id: \.self) {
                CITPincodeCellView(cell: cells[$0])
                
                if config.dividerStyle.afterIndex == $0 {
                    config.dividerView
                }
            }
        }
    }
}

struct CITPincodeView_Previews: PreviewProvider {
    static var previews: some View {
        CITPincodeView(config: .socialBlox) { cells in
            Text("Just like that")
        }
    }
}
