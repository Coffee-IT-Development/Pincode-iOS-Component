//
//  CITPincodeLabeledSlider.swift
//  CITPincodeExample
//
//  Created by Lex Brouwers on 02/08/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import SwiftUI

struct CITPincodeLabeledSlider<V>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    let label: String
    let range: ClosedRange<V>
    let value: Binding<V>
    var onEditingChanged: (Bool) -> Void = { _ in }
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            
            Slider(
                value: value,
                in: range,
                step: 1
            ) {
                Text("Unused label")
            } minimumValueLabel: {
                Text("\(Int(value.wrappedValue.rounded()))")
            } maximumValueLabel: {
                Text("\(Int(range.upperBound.rounded()))")
            }
        }
    }
}
