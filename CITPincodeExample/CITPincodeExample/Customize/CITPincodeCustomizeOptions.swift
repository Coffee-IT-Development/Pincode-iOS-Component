//
//  CITPincodeCustomizeOptions.swift
//  CITPincodeExample
//
//  Created by Lex Brouwers on 02/08/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import SwiftUI
import CITPincode

struct CITPincodeCustomizeOptions: View {
    @Binding var config: CITPincodeConfig
    @Binding var customBackgroundColor: Color
    @Binding var error: String?
    
    @State private var dividerIndex: Int = 0
    @State private var showResendButton = true
    @State private var customResendButton = CITPincodeResendButtonConfig.plain
    @State private var resendText = "Send code again"
    @State private var resendCooldown: CGFloat = 60
    @State private var resendAlignLeading = true
    @State private var errorValue = ""
    
    var body: some View {
        ScrollView {
            VStack {
                codeFormat
                cellVisuals
                placeholder
                errorTextfield
                colors
                extras
                resendButton
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .foregroundColor(.coffeeItColor)
        .padding(20)
        .padding(.bottom, 20)
        .background(Color.white)
        .cornerRadius(20)
        .padding(.bottom, -20)
    }
    
    var codeFormat: some View {
        VStack {
            CITPincodeLabeledIntPicker(label: "Code length:", range: 1...6, value: $config.codeLength)
            CITPincodeLabeledIntPicker(label: "Divider after index:", range: 0...5, value: $dividerIndex)
        }
        .onChange(of: dividerIndex) { newValue in
            config.divider = dividerIndex > 0 ? .plain(afterIndex: dividerIndex - 1) : .none
        }
    }
    
    @ViewBuilder
    var cellVisuals: some View {
        CITPincodeLabeledSlider(label: "Cell width:", range: 20...100, value: $config.cellSize.width)
        CITPincodeLabeledSlider(label: "Cell height:", range: 20...100, value: $config.cellSize.height)
        CITPincodeLabeledSlider(label: "Cell corner radius:", range: 0...max(config.cellSize.width, config.cellSize.height), value: $config.cellCornerRadius)
        CITPincodeLabeledSlider(label: "Cell border width:", range: 1...10, value: $config.selectedBorderWidth)
    }
    
    var placeholder: some View {
        CITPincodeLabeledTextField(label: "Placeholder:", placeholder: "Enter placeholder here..", value: $config.placeholder, keyboardType: config.codeType)
            .onChange(of: config.placeholder) { newValue in
                config.placeholder = String(newValue.prefix(config.codeLength))
            }
    }
    
    var errorTextfield: some View {
        CITPincodeLabeledTextField(label: "Error:", placeholder: "Enter error here..", value: $errorValue)
            .onChange(of: config.placeholder) { newValue in
                config.placeholder = String(newValue.prefix(config.codeLength))
            }
            .onChange(of: errorValue) { newValue in
                error = newValue.isEmpty ? nil : newValue
            }
    }
    
    @ViewBuilder
    var colors: some View {
        ColorPicker("Full view background color:", selection: $customBackgroundColor)
        ColorPicker("Text color:", selection: $config.textColor)
        ColorPicker("Error color:", selection: $config.errorColor)
        ColorPicker("Placeholder color:", selection: $config.placeholderColor)
        ColorPicker("Cell background color:", selection: $config.backgroundColor)
        ColorPicker("Selected cell background color:", selection: $config.selectedBackgroundColor)
        ColorPicker("Selected cell border color:", selection: $config.selectedBorderColor)
    }
    
    @ViewBuilder
    var extras: some View {
        Toggle(isOn: $config.alwaysShowSelectedBorder) {
            Text("Always show selected border:")
        }
        
        CITPincodeLabeledView(label: "Code type:") {
            Picker("Select code type", selection: $config.codeType) {
                Text("Number").tag(UIKeyboardType.numberPad)
                Text("Text").tag(UIKeyboardType.default)
            }
            .pickerStyle(.segmented)
        }
    }
    
    var resendButton: some View {
        VStack {
            CITPincodeLabeledView(label: "Resend button:") {
                Picker("Resend button:", selection: $showResendButton) {
                    Text("Yes").tag(true)
                    Text("No").tag(false)
                }
                .pickerStyle(.segmented)
            }
            .onChange(of: showResendButton) { show in
                if show {
                    updateResendButton()
                } else {
                    config.resendButton = .none
                }
            }
            
            if showResendButton {
                VStack {
                    CITPincodeLabeledTextField(label: "Text:", placeholder: "Enter text here..", value: $resendText)
                    CITPincodeLabeledSlider(label: "Cooldown:", range: 0...100, value: $resendCooldown)
                    CITPincodeLabeledView(label: "Alignment:") {
                        Picker("Resend button alignment:", selection: $resendAlignLeading) {
                            Text("Leading").tag(true)
                            Text("Trailing").tag(false)
                        }
                        .pickerStyle(.segmented)
                    }
                }
                .padding(.leading)
                .onChange(of: resendText) { _ in
                    updateResendButton()
                }
                .onChange(of: resendCooldown) { _ in
                    updateResendButton()
                }
                .onChange(of: resendAlignLeading) { _ in
                    updateResendButton()
                }
            }
        }
    }
    
    private func updateResendButton() {
        let cooldown: CITPincodeResendCodeCooldown = resendCooldown > 0 ? .duration(value: resendCooldown) : .none
        let alignment: HorizontalAlignment = resendAlignLeading ? .leading : .trailing
        config.resendButton = .plain(text: resendText, cooldown: cooldown, alignment: alignment)
    }
}
