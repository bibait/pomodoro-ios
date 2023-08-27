//
//  PomodoroSession.swift
//  Pomodoro
//
//  Created by Bilal Baş on 24.08.23.
//

import Foundation

protocol TimerProtocol {
    func start(duration: Int, timerFinishedCallback: @escaping () -> Void)
}

class PomodoroFlow {
    private let timer: TimerProtocol
    
    init(timer: TimerProtocol) {
        self.timer = timer
    }
    
    func start() {
        timer.start(duration: 25) { [weak self] in
            self?.timer.start(duration: 5) {
                
            }
        }
    }
}
