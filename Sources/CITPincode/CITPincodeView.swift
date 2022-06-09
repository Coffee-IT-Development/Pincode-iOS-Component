//
//  CITPincodeView.swift
//  
//
//  Created by Lex Brouwers on 03/06/2022.
//

import SwiftUI

public struct CITPincodeView: View {
    let config: CITPincodeConfig
    
    @State var cells: [CITPincodeCell] = []
    
    public init(config: CITPincodeConfig) {
        self.config = config
        setupCells()
    }
    
    private func setupCells() {
        for i in 0 ..< config.codeLength {
            cells.append(CITPincodeCell(
                config: config,
                character: "\(i)",
                isSelected: i == 0
            ))
        }
    }
    
    public var body: some View {
        HStack {
            CITPincodeCell.exampleCell(character: "", isSelected: false)
            Text(String(cells.count))
            
            ForEach(cells, content: CITPincodeCellView.init)
        }
    }
}

struct CITPincodeView_Previews: PreviewProvider {
    static var previews: some View {
        CITPincodeView(config: .socialBlox)
    }
}
