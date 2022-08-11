//
//  CITPincodeCooldownTimer.swift
//  
//
//  Created by Lex Brouwers on 20/06/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import Combine
import SwiftUI

class CITPincodeCooldownTimer: ObservableObject {
    @Published var secondsRemaining: TimeInterval = 0
    @Published var timer: Publishers.Autoconnect<Timer.TimerPublisher>?
    private var subscriptions: [AnyCancellable] = []
    
    func restartTimer() {
        cancelTimer()
        timer = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
        
        timer?.sink { [self] _ in
            if secondsRemaining > 0 {
                secondsRemaining -= 1
            } else {
                cancelTimer()
            }
        }
        .store(in: &subscriptions)
    }
    
    private func cancelTimer() {
        timer?.upstream.connect().cancel()
    }
}
