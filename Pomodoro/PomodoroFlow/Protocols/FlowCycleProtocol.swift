//
//  FlowCycleProtocol.swift
//  Pomodoro
//
//  Created by Bilal Baş on 28.08.23.
//

protocol FlowCycleProtocol {
    func getStateDurationInMinutes() -> Int
    func nextState()
}
