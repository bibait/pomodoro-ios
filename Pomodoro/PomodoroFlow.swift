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
    
    func start() {
        timer.start(duration: flowCycle.getStateDurationInMinutes(), timerFinishedCallback: nextTimer)
    }
    
    private func nextTimer() {
        flowCycle.nextState()

        timer.start(duration: flowCycle.getStateDurationInMinutes(), timerFinishedCallback: nextTimer)
    }
}
