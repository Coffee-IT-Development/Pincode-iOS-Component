//
//  CITPincodeCellView.swift
//  
//
//  Created by Lex Brouwers on 03/06/2022.
//

import SwiftUI

struct CITPincodeCellView: View {
    let cell: CITPincodeCell
    
    var body: some View {
        Text(cell.character)
            .font(cell.font)
            .foregroundColor(cell.foregroundColor)
            .frame(width: cell.size.width, height: cell.size.height)
            .background(cell.backgroundColor)
            .cornerRadius(cell.cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cell.cornerRadius)
                    .stroke(cell.selectedBorderColor, lineWidth: cell.isSelected ? 1 : 0)
            )
    }
}

extension CITPincodeCell {
    static func exampleCell(character: String, isSelected: Bool) -> CITPincodeCellView {
        CITPincodeCellView(
            cell: CITPincodeCell.init(
                config: .socialBlox,
                character: character,
                isSelected: isSelected
            )
        )
    }
}

struct CITPincodeCellView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            CITPincodeCell.exampleCell(character: "A", isSelected: false)
            CITPincodeCell.exampleCell(character: "B", isSelected: false)
            CITPincodeCell.exampleCell(character: "C", isSelected: false)
            CITPincodeCell.exampleCell(character: "", isSelected: true)
        }
    }
}
