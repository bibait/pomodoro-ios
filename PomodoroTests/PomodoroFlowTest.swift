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
        
        sut.start()
        
        XCTAssertTrue(timer.isRunning)
    }
    
    func test_startFlow_returnsStateDuration() {
        let sut = makeSUT()
        
        sut.start()
        
        XCTAssertTrue(flowCycle.getStateDurationCalled)
    }
    
    func test_flow_entersNextState_whenTimerIsFinished() {
        let sut = makeSUT()
        
        sut.start()
        timer.timerFinishedCallback()
        
        XCTAssertTrue(flowCycle.nextStateCalled)
    }
    
//    func test_startAndFinishFirstSession_startsTimerWith5MinuteShortBreak() {
//        let sut = makeSUT()
//        
//        sut.start()
//        timer.timerFinishedCallback()
//        
//        XCTAssertEqual(timer.duration, 5)
//    }
//    
//    func test_startAndFinishFirstShortBreak_startsTimerWith25MinuteFocusSession() {
//        let sut = makeSUT()
//        
//        sut.start()
//        timer.timerFinishedCallback()
//        timer.timerFinishedCallback()
//        
//        XCTAssertEqual(timer.duration, 25)
//    }
    
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
