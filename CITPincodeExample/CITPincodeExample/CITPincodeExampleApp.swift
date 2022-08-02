//
//  CITPincodeExampleApp.swift
//  CITPincodeExample
//
//  Created by Lex Brouwers on 29/07/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import SwiftUI

@main
struct CITPincodeExampleApp: App {
    var body: some Scene {
        WindowGroup {
            CITPincodeExampleView()
                .onAppear {
                    setPreferredControlColors()
                }
        }
    }
    
    private func setPreferredControlColors() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .coffeeItColor
        UISegmentedControl.appearance().backgroundColor = .systemBackground
        UISegmentedControl.appearance().setTitleTextAttributes([
            .foregroundColor: UIColor.coffeeItColor
        ], for: .normal)
        
        UISegmentedControl.appearance().setTitleTextAttributes([
            .foregroundColor: UIColor.white
        ], for: .selected)
    }
}
