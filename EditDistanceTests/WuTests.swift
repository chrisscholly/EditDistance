//
//  WuTests.swift
//  EditDistance
//
//  Created by Kazuhiro Hayashi on 2/25/17.
//  Copyright © 2017 Kazuhiro Hayashi. All rights reserved.
//

import XCTest
@testable import EditDistance

class WuTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testTwoSameArray() {
        let container = Wu().calculate(from: [["a", "b", "c"]], to: [["a", "b", "c"]])
        let expected: [EditScript<String>] = [
            .common(element: "a", indexPath: IndexPath(row: 0, section: 0)),
            .common(element: "b", indexPath: IndexPath(row: 1, section: 0)),
            .common(element: "c", indexPath: IndexPath(row: 2, section: 0))
        ]
        XCTAssertEqual(container.editScripts, expected, "correct output")
    }

    func testTwoDifferentArray() {
        do {
            let container = Wu().calculate(from: [["a", "b", "c"]], to: [["a", "d", "c"]])
            let expected: [EditScript<String>] = [
                .common(element: "a", indexPath: IndexPath(row: 0, section: 0)),
                .delete(element: "b", indexPath: IndexPath(row: 1, section: 0)),
                .add(element: "d", indexPath: IndexPath(row: 1, section: 0)),
                .common(element: "c", indexPath: IndexPath(row: 2, section: 0))
            ]
            XCTAssertEqual(container.editScripts, expected, "correct output")
        }
        
        do {
            let container = Wu().calculate(from: [["a", "b", "e"]], to: [["a", "d", "f"]])
            let expected: [EditScript<String>] = [
                .common(element: "a", indexPath: IndexPath(row: 0, section: 0)),
                .delete(element: "b", indexPath: IndexPath(row: 1, section: 0)),
                .delete(element: "e", indexPath: IndexPath(row: 2, section: 0)),
                .add(element: "d", indexPath: IndexPath(row: 1, section: 0)),
                .add(element: "f", indexPath: IndexPath(row: 2, section: 0)),
            ]
            XCTAssertEqual(container.editScripts, expected, "correct output")
        }
    }
    
    func testDestinationIsLonger() {
        do {
            let container = Wu().calculate(from: [["a", "b", "c"]], to: [["a", "b", "c", "d"]])
            let expected: [EditScript<String>] = [
                .common(element: "a", indexPath: IndexPath(row: 0, section: 0)),
                .common(element: "b", indexPath: IndexPath(row: 1, section: 0)),
                .common(element: "c", indexPath: IndexPath(row: 2, section: 0)),
                .add(element: "d", indexPath: IndexPath(row: 3, section: 0)),
                ]
            XCTAssertEqual(container.editScripts, expected, "correct output")
        }
        
        do {
            let container = Wu().calculate(from: [["a", "b", "c"]], to: [["a", "b", "d", "e"]])
            let expected: [EditScript<String>] = [
                .common(element: "a", indexPath: IndexPath(row: 0, section: 0)),
                .common(element: "b", indexPath: IndexPath(row: 1, section: 0)),
                .add(element: "d", indexPath: IndexPath(row: 2, section: 0)),
                .add(element: "e", indexPath: IndexPath(row: 3, section: 0)),
                .delete(element: "c", indexPath: IndexPath(row: 2, section: 0)),
                ]
            XCTAssertEqual(container.editScripts, expected, "correct output")
        }
    }
    
    
    func testStartingIsLonger() {
        do {
            let container = Wu().calculate(from: [["a", "b", "c", "d"]], to: [["a", "b", "c"]])
            let expected: [EditScript<String>] = [
                .common(element: "a", indexPath: IndexPath(row: 0, section: 0)),
                .common(element: "b", indexPath: IndexPath(row: 1, section: 0)),
                .common(element: "c", indexPath: IndexPath(row: 2, section: 0)),
                .delete(element: "d", indexPath: IndexPath(row: 3, section: 0)),
                ]
            XCTAssertEqual(container.editScripts, expected, "correct output")
        }
        
        do {
            let container = Wu().calculate(from: [["a", "b", "d", "e"]], to: [["a", "b", "c"]])
            let expected: [EditScript<String>] = [
                .common(element: "a", indexPath: IndexPath(row: 0, section: 0)),
                .common(element: "b", indexPath: IndexPath(row: 1, section: 0)),
                .delete(element: "d", indexPath: IndexPath(row: 2, section: 0)),
                .delete(element: "e", indexPath: IndexPath(row: 3, section: 0)),
                .add(element: "c", indexPath: IndexPath(row: 2, section: 0)),
                ]
            XCTAssertEqual(container.editScripts, expected, "correct output")
        }
    }
    
    func testPerformanceOfTwentyElementAddedToBottom() {
        let from = Array(repeating: 0, count: 10000)
        let to = Array(repeating: 0, count: 10000) + Array(repeating: 1, count: 20)
        self.measure {
            let _ = Wu().calculate(from: [from], to: [to])
        }
    }
    
    func testPerformanceOfTwentyElementAddedToMiddle() {
        let from = Array(repeating: 0, count: 10000) + Array(repeating: 0, count: 10000)
        let to = Array(repeating: 0, count: 10000) + Array(repeating: 1, count: 20) + Array(repeating: 0, count: 10000)
        self.measure {
            let _ = Wu().calculate(from: [from], to: [to])
        }
    }
    
    func testPerformanceOfTwentyElementDeleteOnTop() {
        let from = Array(repeating: 0, count: 20) + Array(repeating: 1, count: 10000)
        let to = Array(repeating: 1, count: 10000)
        self.measure {
            let _ = Wu().calculate(from: [from], to: [to])
        }
    }
    
    func testPerformanceOfTwentyElementDeleteOnMiddle() {
        let from = Array(repeating: 0, count: 10000) + Array(repeating: 1, count: 20) + Array(repeating: 0, count: 10000)
        let to = Array(repeating: 0, count: 10000) + Array(repeating: 0, count: 10000)
        self.measure {
            let _ = Wu().calculate(from: [from], to: [to])
        }
    }
}
