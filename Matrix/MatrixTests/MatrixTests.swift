//
//  MatrixTests.swift
//  MatrixTests
//
//  Created by Prateek Kohli on 12/03/17.
//  Copyright © 2017 VGgroup. All rights reserved.
//

import XCTest

class MatrixTests: XCTestCase {
    
    var grid: matrixGrid!

    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
         grid = matrixGrid();

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
         grid = nil;

    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testMatrix() {
        
        // This is an example of a performance test case.
        
        let arr =   ["3","4","1","2","8","6",
                     "6","1","8","2","7","4",
                     "5","9","3","9","9","5",
                     "8","4","1","3","2","6",
                     "3","7","2","8","6","4"];
        
        grid.initaliseMatrix(arr: arr,m: 5, n: 6)
        let output =  grid.getShortestPath()
        XCTAssert(output.totalCost == 16)
        
    }
    
    func testMatrix2() {
        
        // This is an example of a performance test case.
        
        let arr =   ["3","4","1","2","8","6",
                     "6","1","8","2","7","4",
                     "5","9","3","9","9","5",
                     "8","4","1","3","2","6",
                     "3","7","2","1","2","3"];

        
        grid.initaliseMatrix(arr: arr,m: 5, n: 6)
        let output =  grid.getShortestPath()
        XCTAssert(output.totalCost == 11)
        
    }
    
    
    
    func testMatrix4() {
        // This is an example of a performance test case.
        
        let arr =   ["5","8","5","3","5"];
        
        grid.initaliseMatrix(arr: arr,m: 1, n: 5)
        let output =  grid.getShortestPath()
        XCTAssert(output.totalCost == 26)
    }

    func testMatrix5() {
        // This is an example of a performance test case.
        
        let arr =   ["5","8","5","3","5"];
        
        grid.initaliseMatrix(arr: arr,m: 1, n: 5)
        let output =  grid.getShortestPath()
        XCTAssert(output.totalCost == 26)
    }
    

    
    func testInvalidMatrix() {
        
        // This is an example of a performance test case.
        
        let arr =   ["3","4","1","2","8","6",
                     "6","1","8","2","7","4",
                     "5","9","M","9","9","5",
                     "8","4","1","3","2","6",
                     "3","7","2","8","6","4"];
        
        grid.initaliseMatrix(arr: arr,m: 5, n: 6)
        let output =  grid.getShortestPath()
        XCTAssertFalse(output.sucess)

    }

    
}
