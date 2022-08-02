//
//  CITPincodeLabeledView.swift
//  CITPincodeExample
//
//  Created by Lex Brouwers on 02/08/2022.
//

import SwiftUI

struct CITPincodeLabeledView<TrailingView: View>: View {
    let label: String
    let trailingView: () -> TrailingView
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            trailingView()
        }
    }
}
