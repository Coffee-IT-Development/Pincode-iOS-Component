//
//  CITPincodeCustomizeOptions.swift
//  CITPincodeExample
//
//  MIT License
//
//  Copyright (c) 2022 Coffee IT
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import SwiftUI
import CITPincode

struct CITPincodeCustomizeOptions: View {
    @Binding var config: CITPincodeView.Configuration
    @Binding var customBackgroundColor: Color
    @Binding var error: String?
    
    @State private var dividerIndex: Int = 0
    @State private var showResendButton = true
    @State private var customResendButton = CITPincodeResendButtonConfiguration.plain
    @State private var resendText = "Send code again"
    @State private var resendCooldown: CGFloat = 60
    @State private var resendButtonAlignment: CITPincodeResendButtonAlignment = .leading
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
            CITPincodeLabeledIntPicker(
                label: "Code length:",
                range: 1...6,
                value: $config.codeLength
            )
            
            CITPincodeLabeledIntPicker(
                label: "Divider after index:",
                range: 0...5,
                value: $dividerIndex
            )
        }
        .onChange(of: dividerIndex) { newValue in
            config.divider = newValue > 0 ? .plain(afterIndex: newValue - 1) : .none
        }
    }
    
    var cellVisuals: some View {
        Group {
            CITPincodeLabeledSlider(
                label: "Cell width:",
                range: 20...100,
                value: $config.cellSize.width
            )
            
            CITPincodeLabeledSlider(
                label: "Cell height:",
                range: 20...100,
                value: $config.cellSize.height
            )
            
            CITPincodeLabeledSlider(
                label: "Cell corner radius:",
                range: 0...max(config.cellSize.width, config.cellSize.height),
                value: $config.cellCornerRadius
            )
            
            CITPincodeLabeledSlider(
                label: "Cell border width:",
                range: 1...10,
                value: $config.selectedBorderWidth
            )
        }
    }
    
    var placeholder: some View {
        CITPincodeLabeledTextField(
            label: "Placeholder:",
            placeholder: "Enter placeholder here..",
            value: $config.placeholder,
            keyboardType: config.keyboardType
        )
        .onChange(of: config.placeholder) { newValue in
            config.placeholder = String(newValue.prefix(config.codeLength))
        }
    }
    
    var errorTextfield: some View {
        CITPincodeLabeledTextField(
            label: "Error:",
            placeholder: "Enter error here..",
            value: $errorValue
        )
        .onChange(of: config.placeholder) { newValue in
            config.placeholder = String(newValue.prefix(config.codeLength))
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
                selection: $config.textColor
            )
            
            ColorPicker(
                "Error color:",
                selection: $config.errorColor
            )
            
            ColorPicker(
                "Placeholder color:",
                selection: $config.placeholderColor
            )
            
            ColorPicker(
                "Cell background color:",
                selection: $config.backgroundColor
            )
            
            ColorPicker(
                "Selected cell background color:",
                selection: $config.selectedBackgroundColor
            )
            
            ColorPicker(
                "Selected cell border color:",
                selection: $config.selectedBorderColor
            )
        }
    }
    
    var extras: some View {
        Group {
            Toggle(isOn: $config.alwaysShowSelectedBorder) {
                Text("Always show selected border:")
            }
            
            CITPincodeLabeledView(label: "Keyboard type:") {
                Picker("Select keyboard type", selection: $config.keyboardType) {
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
                    config.resendButton = .none
                }
            }
            
            if showResendButton {
                VStack {
                    CITPincodeLabeledTextField(
                        label: "Text:",
                        placeholder: "Enter text here..",
                        value: $resendText
                    )
                    
                    CITPincodeLabeledSlider(
                        label: "Cooldown:",
                        range: 0...100,
                        value: $resendCooldown
                    )
                    
                    CITPincodeLabeledView(label: "Alignment:") {
                        Picker("Resend button alignment:", selection: $resendButtonAlignment) {
                            Text("Leading")
                                .tag(CITPincodeResendButtonAlignment.leading)
                            
                            Text("Trailing")
                                .tag(CITPincodeResendButtonAlignment.trailing)
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
                .onChange(of: resendButtonAlignment) { _ in
                    updateResendButton()
                }
            }
        }
    }
    
    private func updateResendButton() {
        let cooldown: CITPincodeResendCodeCooldown = resendCooldown > 0 ? .duration(value: resendCooldown) : .none
        config.resendButton = .plain(text: resendText, cooldown: cooldown, alignment: resendButtonAlignment.position)
    }
}
