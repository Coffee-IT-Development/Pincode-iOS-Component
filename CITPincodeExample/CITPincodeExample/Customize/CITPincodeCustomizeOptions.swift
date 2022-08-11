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
    @Binding var configuration: CITPincodeView.Configuration
    @Binding var customBackgroundColor: Color
    @Binding var error: String?
    
    @State private var dividerIndex: Int = 0
    @State private var showResendButton = true
    @State private var customResendButton = CITPincodeResendButtonConfiguration.plain
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
            CITPincodeLabeledIntPicker(label: "Code length:", range: 1...6, value: $configuration.codeLength)
            CITPincodeLabeledIntPicker(label: "Divider after index:", range: 0...5, value: $dividerIndex)
        }
        .onChange(of: dividerIndex) { _ in
            configuration.divider = dividerIndex > 0 ? .plain(afterIndex: dividerIndex - 1) : .none
        }
    }
    
    var cellVisuals: some View {
        Group {
            CITPincodeLabeledSlider(
                label: "Cell width:",
                range: 20...100,
                value: $configuration.cellSize.width
            )
            
            CITPincodeLabeledSlider(
                label: "Cell height:",
                range: 20...100,
                value: $configuration.cellSize.height
            )
            
            CITPincodeLabeledSlider(
                label: "Cell corner radius:",
                range: 0...max(configuration.cellSize.width, configuration.cellSize.height),
                value: $configuration.cellCornerRadius
            )
            
            CITPincodeLabeledSlider(
                label: "Cell border width:",
                range: 1...10, value: $configuration.selectedBorderWidth
            )
        }
    }
    
    var placeholder: some View {
        CITPincodeLabeledTextField(
            label: "Placeholder:",
            placeholder: "Enter placeholder here..",
            value: $configuration.placeholder,
            keyboardType: configuration.keyboardType
        )
        .onChange(of: configuration.placeholder) { newValue in
            configuration.placeholder = String(newValue.prefix(configuration.codeLength))
        }
    }
    
    var errorTextfield: some View {
        CITPincodeLabeledTextField(label: "Error:", placeholder: "Enter error here..", value: $errorValue)
            .onChange(of: configuration.placeholder) { newValue in
                configuration.placeholder = String(newValue.prefix(configuration.codeLength))
            }
            .onChange(of: errorValue) { newValue in
                error = newValue.isEmpty ? nil : newValue
            }
    }
    
    var colors: some View {
        Group {
            ColorPicker(
                "Full view background color:",
                selection: $customBackgroundColor
            )
            
            ColorPicker(
                "Text color:",
                selection: $configuration.textColor
            )
            
            ColorPicker(
                "Error color:",
                selection: $configuration.errorColor
            )
            
            ColorPicker(
                "Placeholder color:",
                selection: $configuration.placeholderColor
            )
            
            ColorPicker(
                "Cell background color:",
                selection: $configuration.backgroundColor
            )
            
            ColorPicker(
                "Selected cell background color:",
                selection: $configuration.selectedBackgroundColor
            )
            
            ColorPicker(
                "Selected cell border color:",
                selection: $configuration.selectedBorderColor
            )
        }
    }
    
    var extras: some View {
        Group {
            Toggle(isOn: $configuration.alwaysShowSelectedBorder) {
                Text("Always show selected border:")
            }
            
            CITPincodeLabeledView(label: "Keyboard type:") {
                Picker("Select keyboard type", selection: $configuration.keyboardType) {
                    Text("Number")
                        .tag(UIKeyboardType.numberPad)
                    
                    Text("Text")
                        .tag(UIKeyboardType.default)
                }
                .pickerStyle(.segmented)
            }
        }
    }
    
    var resendButton: some View {
        VStack {
            CITPincodeLabeledView(label: "Resend button:") {
                Picker("Resend button:", selection: $showResendButton) {
                    Text("Yes")
                        .tag(true)
                    
                    Text("No")
                        .tag(false)
                }
                .pickerStyle(.segmented)
            }
            .onChange(of: showResendButton) { show in
                if show {
                    updateResendButton()
                } else {
                    configuration.resendButton = .none
                }
            }
            
            if showResendButton {
                VStack {
                    CITPincodeLabeledTextField(label: "Text:", placeholder: "Enter text here..", value: $resendText)
                    CITPincodeLabeledSlider(label: "Cooldown:", range: 0...100, value: $resendCooldown)
                    CITPincodeLabeledView(label: "Alignment:") {
                        Picker("Resend button alignment:", selection: $resendAlignLeading) {
                            Text("Leading")
                                .tag(true)
                            
                            Text("Trailing")
                                .tag(false)
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
        configuration.resendButton = .plain(text: resendText, cooldown: cooldown, alignment: alignment)
    }
}
