////
////  VerifyCodeView.swift
////  
////
////  Created by Lex Brouwers on 03/06/2022.
////
//
//import SwiftUI
//
//struct VerifyCodeView: View {
//    @ObservedObject private var viewModel: VerifyCodeViewModel
//    
//    var shouldShowInvalidCodeState: Bool {
//        if case .error = viewModel.asyncLoadingState {
//            return true
//        }
//        
//        return false
//    }
//    
//    var body: some View {
//        // Helper binding for the keyboard show / hide
//        let shouldShowKeyboardBinding = Binding<Bool>(
//            get: {
//                self.viewModel.asyncLoadingState != .loading
//                && !self.viewModel.successfullyRegisteredEmail
//            },
//            set: { _ in }
//        )
//        
//        // TODO: Lokalise
//        OnboardingBaseView(title: "Verification") {
//            VStack {
//                Text(CITLocalizable.onboardingVerifyWithEmailTitle)
//                    .textStyle(.onboardingSubtextRegular)
//                    .foregroundColor(.textColor)
//                    .multilineTextAlignment(.center)
//                
//                Text(CITLocalizable.onboardingEmailCodeBody(viewModel.email))
//                    .textStyle(.onboardingSubtextRegular)
//                    .foregroundColor(.textColor)
//                    .multilineTextAlignment(.center)
//                    .padding(.top, Padding.large)
//                
//                InputCodeComponent(
//                    inputModel: viewModel.codeModel,
//                    shouldShowKeyboard: shouldShowKeyboardBinding,
//                    shouldShowInvalidCodeState: shouldShowInvalidCodeState
//                )
//                .padding(.top, Padding.medium)
//                
//                Button(action: viewModel.requestNewCode, label: {
//                    Text(CITLocalizable.onboardingVerificationSendCodeAgain("\(viewModel.timeRemaining)"))
//                        .textStyle(.notificationButtonText)
//                        .foregroundColor(.textColor)
//                        .padding(.horizontal, Padding.medium)
//                        .padding(.vertical, Padding.small)
//                        .background(Color.buttonSecondaryBackground)
//                        .cornerRadius(CornerRadius.large)
//                        .padding(.top, Padding.medium)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    }
//                )
//                .disabled(viewModel.canRequestNewCode)
//                
//                NavigationLink(
//                    isActive: $viewModel.successfullyRegisteredEmail,
//                    destination: { RegisterDateOfBirthView() },
//                    label: { EmptyView() }
//                )
//            }
//            .padding(.top, Padding.small)
//            .padding([.horizontal, .bottom], Padding.large)
//        }
//        .asyncLoadable(color: .primary, state: $viewModel.asyncLoadingState)
//        .onAppear {
//            // TODO: Find a proper fix for making sure the counter doesn't already run before the view is opened
//            viewModel.timeRemaining = 60
//        }
//    }
//    
//    init(viewModel: VerifyCodeViewModel) {
//        self.viewModel = viewModel
//    }
//}
//
//struct VerifyCodeView_Previews: PreviewProvider {
//    static var previews: some View {
//        VerifyCodeView(viewModel: VerifyCodeViewModel(type: .login))
//    }
//}
