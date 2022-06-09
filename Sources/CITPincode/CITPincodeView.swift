//
//  CITPincodeView.swift
//  
//
//  Created by Lex Brouwers on 03/06/2022.
//

import SwiftUI

public struct CITPincodeView: View {
    let config: CITPincodeConfig
    var cells: [CITPincodeCell]
    
    public init(config: CITPincodeConfig) {
        self.config = config
        
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
            ForEach(cells, content: CITPincodeCellView.init)
        }
    }
}

struct CITPincodeView_Previews: PreviewProvider {
    static var previews: some View {
        CITPincodeView(config: .socialBlox)
    }
}
