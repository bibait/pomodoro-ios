//
//  PomodoroTimer.swift
//  Pomodoro
//
//  Created by Bilal Baş on 28.08.23.
//

import Foundation

enum TimerState {
    case initial
    case running
    case paused
}

class PomodoroTimer: TimerProtocol {
    var state: TimerState = .initial
    private var timer: Timer
    
    init(timer: Timer) {
        self.timer = timer
        enter(.initial)
    }
    
    private func enter(_ state: TimerState) {
        self.state = state
    }
    
    func start(duration: Int, timerFinishedCallback: @escaping () -> Void) {
        enter(.running)
    }
    
    func pause() {
        guard state == .running else { return }

        enter(.paused)
    }
    
    func `continue`() {
        
    }
    
    func reset() {
        
    }
}
