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
    private let flowCycle = MockCycle()

    func test_startPomodoro_startsTimer() {
        let sut = makeSUT()
        
        sut.startTimer()
        
        XCTAssertEqual(timer.startCalledCounter, 1)
    }
    
    func test_startFlow_returnsStateDuration() {
        let sut = makeSUT()
        
        sut.startTimer()
        
        XCTAssertTrue(flowCycle.getStateDurationCalled)
    }
    
    func test_flow_entersNextState_whenTimerIsFinished() {
        let sut = makeSUT()
        
        sut.startTimer()
        timer.timerFinishedCallback()
        
        XCTAssertTrue(flowCycle.nextStateCalled)
    }
    
    func test_pausePomodoro_pausesTimer() {
        let sut = makeSUT()
        
        sut.pauseTimer()
        
        XCTAssertTrue(timer.isPaused)
    }
    
    func test_flow_doesNotStartAgain_ifItIsRunning() {
        let sut = makeSUT()
        
        sut.startTimer()
        sut.startTimer()
        
        XCTAssertEqual(timer.startCalledCounter, 1)
    }
    
    func test_continuePomodoro_continuesTimer() {
        let sut = makeSUT()
        
        sut.continueTimer()
        
        XCTAssertEqual(timer.continueCalledCounter, 1)
    }
    
    // MARK: - Helper
    
    private func makeSUT() -> PomodoroFlow {
        return PomodoroFlow(timer: timer, flowCycle: flowCycle)
    }
    
    private class MockCycle: FlowCycleProtocol {
        var getStateDurationCalled = false
        var nextStateCalled = false

        func getStateDurationInMinutes() -> Int {
            getStateDurationCalled = true
            
            return 5
        }
        
        func nextState() {
            nextStateCalled = true
        }
    }

    private class MockTimer: TimerProtocol {
        var startCalledCounter = 0
        var continueCalledCounter = 0
        var isPaused = false
        var timerFinishedCallback: () -> Void = { }
        
        func start(duration: Int, timerFinishedCallback: @escaping () -> Void) {
            startCalledCounter += 1
            self.timerFinishedCallback = timerFinishedCallback
        }
        
        func pause() {
            isPaused = true
        }
        
        func `continue`() {
            continueCalledCounter += 1
        }
    }
}
