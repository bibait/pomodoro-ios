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
    
    func test_startFlow_getsStateDuration() {
        let sut = makeSUT()
        
        sut.startTimer()
        
        XCTAssertEqual(flowCycle.getStateDurationCalledCounter, 1)
    }
    
    func test_flow_entersNextState_whenTimerIsFinished() {
        let sut = makeSUT()
        
        sut.startTimer()
        timer.timerFinishedCallback()
        
        XCTAssertEqual(flowCycle.nextStateCalledCounter, 1)
    }
    
    func test_flow_pausePomodoro_callsPauseTimer() {
        let sut = makeSUT()
        
        sut.pauseTimer()
        
        XCTAssertEqual(timer.pauseCalledCounter, 1)
    }
    
    func test_flow_continuePomodoro_callsContinuesTimer() {
        let sut = makeSUT()
        
        sut.continueTimer()
        
        XCTAssertEqual(timer.continueCalledCounter, 1)
    }
    
    func test_flow_resetTimer_callsResetTimer() {
        let sut = makeSUT()
        
        sut.resetTimer()
        
        XCTAssertEqual(timer.resetCalledCounter, 1)
    }
    
    // MARK: - Helper
    
    private func makeSUT() -> PomodoroFlow {
        return PomodoroFlow(timer: timer, flowCycle: flowCycle)
    }
    
    private class MockCycle: FlowCycleProtocol {
        var getStateDurationCalledCounter = 0
        var nextStateCalledCounter = 0

        func getStateDurationInMinutes() -> Int {
            getStateDurationCalledCounter += 1
            
            return 0
        }
        
        func nextState() {
            nextStateCalledCounter += 1
        }
    }

    private class MockTimer: TimerProtocol {
        var startCalledCounter = 0
        var continueCalledCounter = 0
        var pauseCalledCounter = 0
        var resetCalledCounter = 0
        var timerFinishedCallback: () -> Void = { }
        
        func start(duration: Int, timerFinishedCallback: @escaping () -> Void) {
            startCalledCounter += 1
            self.timerFinishedCallback = timerFinishedCallback
        }
        
        func pause() {
            pauseCalledCounter += 1
        }
        
        func `continue`() {
            continueCalledCounter += 1
        }
        
        func reset() {
            resetCalledCounter += 1
        }
    }
}
