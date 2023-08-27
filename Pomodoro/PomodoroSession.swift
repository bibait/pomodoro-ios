//
//  PomodoroSession.swift
//  Pomodoro
//
//  Created by Bilal Baş on 24.08.23.
//

import Foundation

protocol TimerProtocol {
    func start(duration: Int)
}

class PomodoroSession {
    private let FOCUS_DURATION_IN_MIN = 25
    private let timer: TimerProtocol
    private var numOfSessions = 0
    
    init(timer: TimerProtocol) {
        self.timer = timer
    }
    
    func start() {
        if numOfSessions == 5 {
            timer.start(duration: 30)
        } else if numOfSessions == 0 || numOfSessions % 2 == 0 {
            timer.start(duration: FOCUS_DURATION_IN_MIN)
        } else {
            timer.start(duration: 5)
        }

        numOfSessions += 1
    }
}
