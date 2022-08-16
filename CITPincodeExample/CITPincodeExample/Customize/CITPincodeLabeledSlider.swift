//
//  CITPincodeLabeledSlider.swift
//  CITPincodeExample
//
//  Created by Lex Brouwers on 02/08/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import SwiftUI

struct CITPincodeLabeledSlider<Value>: View where Value: BinaryFloatingPoint, Value.Stride: BinaryFloatingPoint {
    let label: String
    let range: ClosedRange<Value>
    @Binding var value: Value

    var body: some View {
        HStack {
            Text(label)
            Spacer()
            
            Slider(
                value: $value,
                in: range,
                step: 1
            ) {
                EmptyView()
            } minimumValueLabel: {
                Text("\(Int(value.rounded()))")
            } maximumValueLabel: {
                Text("\(Int(range.upperBound.rounded()))")
            }
        }
    }
}
