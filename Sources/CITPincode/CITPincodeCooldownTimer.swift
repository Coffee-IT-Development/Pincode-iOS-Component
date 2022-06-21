//
//  CITPincodeCooldownTimer.swift
//  
//
//  Created by Lex Brouwers on 20/06/2022.
//

import Combine
import SwiftUI

public class CITPincodeCooldownTimer: ObservableObject {
    @Published var current: CGFloat = 0
    @Published var timer: Publishers.Autoconnect<Timer.TimerPublisher>?
    private var subscriptions: [AnyCancellable] = []
    
    public init() {}
    
    public func restartTimer() {
        cancelTimer()
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        timer?.sink { [self] _ in
            if current > 0 {
                current -= 1
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
