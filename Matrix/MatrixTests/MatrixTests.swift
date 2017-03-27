//
//  MatrixTests.swift
//  MatrixTests
//
//  Created by Prateek Kohli on 12/03/17.
//  Copyright © 2017 VGgroup. All rights reserved.
//

import XCTest

class MatrixTests: XCTestCase {
    
    var matrix: MinCost!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
         matrix = MinCost();

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
         matrix = nil;

    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testMatrix() {
        
        // This is an example of a performance test case.
        
        let arr : [Int] =   [3,4,1,2,8,6,
                             6,1,8,2,7,4,
                             5,9,3,9,9,5,
                             8,4,1,3,2,6,
                             3,7,2,8,6,4];
        
        matrix.initaliseMatrix(arr: arr,m: 5, n: 6)
        
        let output =  matrix.getShortestPath()
        XCTAssert(output.totalCost == 16)
        XCTAssert(output.sequence == [1,2,3,4,4,5])

    }
    
    func testMatrix2() {
        
        // This is an example of a performance test case.
        let arr : [Int] =   [3,4,1,2,8,6,
                             6,1,8,2,7,4,
                             5,9,3,9,9,5,
                             8,4,1,3,2,6,
                             3,7,2,1,2,3];
        
        matrix.initaliseMatrix(arr: arr,m: 5, n: 6)
        let output =  matrix.getShortestPath()
        XCTAssert(output.totalCost == 11)
        XCTAssert(output.sequence == [1,2,1,5,4,5])

    }

    func testMatrix4() {
        // This is an example of a performance test case.
        
        let arr : [Int] =   [5,8,5,3,5];
        matrix.initaliseMatrix(arr: arr,m: 1, n: 5)
        let output =  matrix.getShortestPath()
        XCTAssert(output.totalCost == 26)
        XCTAssert(output.sequence == [1,1,1,1,1])
    }
    
    func testMatrix5() {
        
        // This is an example of a performance test case.
        let arr : [Int] =   [19,10,19,10,19,
                             21,23,20,19,12,
                             20,12,20,11,10];
        
        matrix.initaliseMatrix(arr: arr,m: 3, n: 5)
        let output =  matrix.getShortestPath()
        XCTAssert(output.totalCost == 48)
        
    }

    func testMatrix6() {
        // This is an example of a performance test case.
        
        let arr : [Int] =   [5,8,5,3,5];
        
        matrix.initaliseMatrix(arr: arr,m: 5, n: 1)
        let output =  matrix.getShortestPath()
        XCTAssert(output.totalCost == 3)
        XCTAssert(output.sequence == [4])
        
    }
    
    func testMatrix7() {
        // This is an example of a performance test case.
        
        let arr : [Int] =   [60,3,3,6,
                              6,3,7,9,
                              5,6,8,3];
        
        matrix.initaliseMatrix(arr: arr,m: 3, n: 4)
        let output =  matrix.getShortestPath()
        XCTAssert(output.totalCost == 14)
        XCTAssert(output.sequence == [3,2,1,3])
        
    }
    
    func testMatrix8() {
        // This is an example of a performance test case.
        
        let arr : [Int] =   [6,3,-5,9,
                             -5,2,4,10,
                             3,-2,6,10,
                             6,-1,-2,10];
        
        matrix.initaliseMatrix(arr: arr,m: 4, n: 4)
        let output =  matrix.getShortestPath()
        XCTAssert(output.totalCost == 0)
        XCTAssert(output.sequence == [2,3,4,1])
    }
}
