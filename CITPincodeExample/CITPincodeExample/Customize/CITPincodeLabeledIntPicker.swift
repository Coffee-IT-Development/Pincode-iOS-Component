//
//  CITPincodeLabeledIntPicker.swift
//  CITPincodeExample
//
//  Created by Lex Brouwers on 02/08/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import SwiftUI

struct CITPincodeLabeledIntPicker: View {
    let label: String
    let range: ClosedRange<Int>
    @Binding var value: Int
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Picker(label, selection: $value) {
                ForEach(range, id: \.self) {
                    Text(String($0))
                        .tag($0)
                }
            }
        }
    }
}
