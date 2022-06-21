////
////  InputCodeCellComponent.swift
////  SocialBlox
////
////  Created by Mark Meesters on 22/10/2021.
////
//
//import SwiftUI
//
//struct InputCodeCellComponent: View {
//    let character: String
//    let isSelected: Bool
//    let isError: Bool
//    
//    var body: some View {
//        Text(character)
//            .textStyle(.onboardingTextBig)
//            .foregroundColor(isError ? .inputHintColorError : .textColor)
//            .frame(width: 40, height: 56)
//            .background(isSelected ? Color.inputBackgroundActive : Color.inputBackground)
//            .cornerRadius(CornerRadius.small)
//            .overlay(
//                RoundedRectangle(cornerRadius: CornerRadius.small)
//                    .stroke(Color.textColor44, lineWidth: isSelected ? 1 : 0)
//            )
//    }
//}
//
//struct PincodeField_Previews: PreviewProvider {
//    static var previews: some View {
//        HStack {
//            InputCodeCellComponent(character: "A", isSelected: false, isError: false)
//            InputCodeCellComponent(character: "B", isSelected: false, isError: false)
//            InputCodeCellComponent(character: "C", isSelected: false, isError: false)
//            InputCodeCellComponent(character: "", isSelected: true, isError: false)
//        }
//        .radialBackground(for: .bottom)
//    }
//}
