//
//  PomodoroSession.swift
//  Pomodoro
//
//  Created by Bilal Baş on 24.08.23.
//

import Foundation

class PomodoroFlow {
    private let timer: TimerProtocol
    private let flowCycle: FlowCycleProtocol
    
    init(timer: TimerProtocol, flowCycle: FlowCycleProtocol) {
        self.timer = timer
        self.flowCycle = flowCycle
    }
    
    func startTimer() {
        timer.start(duration: flowCycle.getStateDurationInMinutes(), timerFinishedCallback: timerFinishedHandler)
    }
    
    private func timerFinishedHandler() {
        startNextTimer()
    }
    
    private func startNextTimer() {
        flowCycle.nextState()

        timer.start(duration: flowCycle.getStateDurationInMinutes(), timerFinishedCallback: timerFinishedHandler)
    }
    
    func pauseTimer() {
        timer.pause()
    }
    
    func continueTimer() {
        timer.continue()
    }
    
    func resetTimer() {
        timer.reset()
    }
}
