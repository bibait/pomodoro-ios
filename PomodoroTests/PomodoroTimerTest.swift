//
//  PomodoroTimerTest.swift
//  PomodoroTests
//
//  Created by Bilal Baş on 28.08.23.
//

import XCTest
@testable import Pomodoro

class PomodoroTimerTest: XCTestCase {
    private let timer = TimerSpy()

    func test_pomodoroTimer_startsWithInitialState() {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.state, .initial)
    }
    
    func test_startTimer_entersRunningState() {
        let sut = makeSUT()
        
        sut.start(duration: 0) { }
        
        XCTAssertEqual(sut.state, .running)
    }
    
    func test_timer_pausesInRunningState() {
        let sut = makeSUT()
        
        sut.state = .running
        sut.pause()
        
        XCTAssertEqual(sut.state, .paused)
    }
    
    func test_timer_doesNotPauseInInitialState() {
        let sut = makeSUT()
        
        sut.state = .initial
        sut.pause()
        
        XCTAssertEqual(sut.state, .initial)
    }
    
    // MARK: - Helper
    
    private func makeSUT() -> PomodoroTimer {
        return PomodoroTimer(timer: timer)
    }
    
    private class TimerSpy: Timer {
        var isInvalidated = false
    
    }
}
