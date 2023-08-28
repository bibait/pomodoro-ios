//
//  PomodoroSession.swift
//  Pomodoro
//
//  Created by Bilal Baş on 24.08.23.
//

import Foundation

protocol TimerProtocol {
    func start(duration: Int, timerFinishedCallback: @escaping () -> Void)
    func pause()
    func `continue`()
    func reset()
}

protocol FlowCycleProtocol {
    func getStateDurationInMinutes() -> Int
    func nextState()
}

class PomodoroFlow {
    private let timer: TimerProtocol
    private let flowCycle: FlowCycleProtocol
    
    init(timer: TimerProtocol, flowCycle: FlowCycleProtocol) {
        self.timer = timer
        self.flowCycle = flowCycle
    }
    
    func startTimer() {
        timer.start(duration: flowCycle.getStateDurationInMinutes(), timerFinishedCallback: nextTimer)
    }
    
    private func nextTimer() {
        flowCycle.nextState()

        timer.start(duration: flowCycle.getStateDurationInMinutes(), timerFinishedCallback: nextTimer)
    }
    
    func pauseTimer() {
        timer.pause()
    }
    
    func continueTimer() {
        timer.continue()
    }
    
    func reset() {
        timer.reset()
    }
}
