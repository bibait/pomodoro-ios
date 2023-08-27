//
//  PomodoroSessionTest.swift
//  PomodoroTests
//
//  Created by Bilal Baş on 24.08.23.
//

import XCTest
@testable import Pomodoro

class PomodoroSessionTest: XCTestCase {
    private let timer = MockTimer()

    func test_startSession_startsTimer() {
        let sut = PomodoroSession(timer: timer)
        
        sut.start()
        
        XCTAssertTrue(timer.isRunning)
    }
    
    func test_timer_callsCompletionHandler_whenFinished() {
        let sut = PomodoroSession(timer: timer)
        
        sut.start()
        
        XCTAssertTrue(timer.isFinished)
    }
    
    func test_firstSession_has25MinuteDuration() {
        let sut = PomodoroSession(timer: timer)
        
        sut.start()
        
        XCTAssertEqual(timer.numOfSessions, 1)
        XCTAssertEqual(timer.duration, 25)
    }
    
    func test_secondSession_has5MinuteDuration() {
        let sut = PomodoroSession(timer: timer)
        
        sut.start()
        sut.start()
        
        XCTAssertEqual(timer.numOfSessions, 2)
        XCTAssertEqual(timer.duration, 5)
    }
    
    func test_thirdSession_has25MinuteDuration() {
        let sut = PomodoroSession(timer: timer)
        
        sut.start()
        sut.start()
        sut.start()
        
        XCTAssertEqual(timer.numOfSessions, 3)
        XCTAssertEqual(timer.duration, 25)
    }
    
    func test_afterThreeFocusSessions_comesLongBreakWith30Minutes() {
        let sut = PomodoroSession(timer: timer)
        
        sut.start() // focus
        sut.start() // short break
        sut.start() // focus
        sut.start() // short break
        sut.start() // focus
        sut.start() // long break
        
        XCTAssertEqual(timer.numOfSessions, 6)
        XCTAssertEqual(timer.duration, 30)
    }
    
    // MARK: - Helper

    class MockTimer: TimerProtocol {
        var isRunning = false
        var duration: Int = 0
        var numOfSessions: Int = 0
        var timerFinishedCallback: () -> Void = { }
        
        func start(duration: Int, timerFinishedCallback: @escaping () -> Void) {
            isRunning = true
            self.duration = duration
            numOfSessions += 1
            
            self.timerFinishedCallback = timerFinishedCallback
        }
    }
}
