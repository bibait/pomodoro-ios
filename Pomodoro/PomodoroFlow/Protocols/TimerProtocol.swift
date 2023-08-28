//
//  TimerProtocol.swift
//  Pomodoro
//
//  Created by Bilal Baş on 28.08.23.
//

protocol TimerProtocol {
    func start(duration: Int, timerFinishedCallback: @escaping () -> Void)
    func pause()
    func `continue`()
    func reset()
}
