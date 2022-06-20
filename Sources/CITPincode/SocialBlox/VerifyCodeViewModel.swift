////
////  VerifyCodeViewModel.swift
////  
////
////  Created by Lex Brouwers on 03/06/2022.
////
//
//import Combine
//import Foundation
//import SwiftUI
//
//class VerifyCodeViewModel: ObservableObject {
//    private let type: VerificationType
//    private let userManager: UserManager
//    private var subscriptions: [AnyCancellable] = []
//     cx,
//    @Published var timeRemaining = 60
//    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//    @Published var codeModel = InputCodeModel(codeLength: 6)
//    @Published var asyncLoadingState: AsyncLoadingState = .initial
//
//    @Published var successfullyRegisteredEmail = false
//    @Published var isShowingVerifyCode = false
//
//    @Published var registerType: RegisterType = .email
//    @Published var email = ""
//    @Published var phone = ""
//    @Published var phoneCountryCode = ""
//    
//    init(type: VerificationType, userManager: UserManager = DependencyManager.userManager) {
//        self.type = type
//        self.userManager = userManager
//        setupPublishers()
//        restartTimer()
//    }
//
//    private var authType: AuthType {
//        type == .login ? .login : .register
//    }
//    
//    var canRequestNewCode: Bool {
//        timeRemaining > 0
//    }
//
//    func requestCode() {
//        asyncLoadingState = .loading
//
//        userManager
//            .authorize(email: email, type: authType)
//        // do something with response.statusCode
//            .sink(receiveCompletion: {
//                self.asyncLoadingState.receiveCompletion($0)
//            }, receiveValue: { _ in
//                self.isShowingVerifyCode = true
//            })
//            .store(in: &subscriptions)
//    }
//
//    func requestNewCode() {
//        timeRemaining = 60
//        restartTimer()
//        requestCode()
//    }
//
//    func login(codeToCheck: String) {
//        // TODO: This is fine for now but have to check why it's triggered twice
//        guard asyncLoadingState != .loading else { return }
//        
//        asyncLoadingState = .loading
//
//        userManager
//            .login(email: email, code: codeToCheck)
//            .sink(receiveCompletion: {
//                self.asyncLoadingState.receiveCompletion($0)
//            }, receiveValue: { [self] _ in
//                if type == .register {
//                    successfullyRegisteredEmail = true
//                } else {
//                    asyncLoadingState = .loading
//                    DependencyManager.storageManager.login()
//                }
//            })
//            .store(in: &subscriptions)
//    }
//
//    private func setupPublishers() {
//        codeModel.$codeToCheck.sink { codeToCheck in
//            if let codeToCheck = codeToCheck {
//                self.validateCode(codeToCheck: codeToCheck)
//            }
//        }
//        .store(in: &subscriptions)
//        
//        codeModel.$enteredCode.sink { enteredCode in
//            if enteredCode.isEmpty {
//                self.asyncLoadingState = .initial
//            }
//        }
//        .store(in: &subscriptions)
//    }
//    
//    private func restartTimer() {
//        cancelTimer()
//        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//        timer.sink { [self] _ in
//            if timeRemaining > 0 {
//                timeRemaining -= 1
//            } else {
//                cancelTimer()
//            }
//        }
//        .store(in: &subscriptions)
//    }
//    
//    private func cancelTimer() {
//        timer.upstream.connect().cancel()
//    }
//
//    func validateCode(codeToCheck: String) {
//        guard codeToCheck.count == codeModel.codeLength else {
//            codeModel.enteredCode.removeAll()
//            return
//        }
//
//        login(codeToCheck: codeToCheck)
//    }
//}
