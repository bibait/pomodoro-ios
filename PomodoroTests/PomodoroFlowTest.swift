//
//  PomodoroSessionTest.swift
//  PomodoroTests
//
//  Created by Bilal Baş on 24.08.23.
//

import XCTest
@testable import Pomodoro

class PomodoroFlowTest: XCTestCase {
    private let timer = MockTimer()

    func test_startPomodoro_startsTimer() {
        let sut = PomodoroFlow(timer: timer)
        
        sut.start()
        
        XCTAssertTrue(timer.isRunning)
    }
    
    func test_startPomodoro_forFirstTime_startsTimerWith25MinuteDuration() {
        let sut = PomodoroFlow(timer: timer)
        
        sut.start()
        
        XCTAssertEqual(timer.duration, 25)
    }
    
    func test_timer_callsCompletionHandler_whenFinished() {
        let sut = PomodoroFlow(timer: timer)
        
        sut.start()
        
        timer.timerFinishedCallback()
        
        XCTAssertEqual(timer.duration, 5)
    }
    
    
    
    // MARK: - Helper

    class MockTimer: TimerProtocol {
        var isRunning = false
        var duration: Int = 0
        var timerFinishedCallback: () -> Void = { }
        
        func start(duration: Int, timerFinishedCallback: @escaping () -> Void) {
            isRunning = true
            self.duration = duration
            self.timerFinishedCallback = timerFinishedCallback
        }
    }
}
