//
//  MatrixGrid.swift
//  Matrix
//
//  Created by Prateek Kohli on 12/03/17.
//  Copyright © 2017 VGgroup. All rights reserved.
//

import Foundation

let MAX_VALUE = 9999

public class matrixGrid  {
    
    var cost : Matrix?
    
    struct Matrix {
        let rows: Int, columns: Int
        var grid: [String]
        init(rows: Int, columns: Int) {
            self.rows = rows
            self.columns = columns
            grid = Array(repeating: "0", count: rows * columns)
        }
        func indexIsValid(row: Int, column: Int) -> Bool {
            return row >= 0 && row < rows && column >= 0 && column < columns
        }
        subscript(row: Int, column: Int) -> String {
            get {
                assert(indexIsValid(row: row, column: column), "Index out of range")
                return grid[(row * columns) + column]
            }
            set {
                assert(indexIsValid(row: row, column: column), "Index out of range")
                grid[(row * columns) + column] = newValue
            }
        }
    }
    
    
    public func initaliseMatrix(arr : Array<String>, m : Int, n : Int) -> Void {
        self.cost = Matrix(rows: m, columns: n);
        
        if(!arr.isEmpty) {
            self.cost?.grid = arr;
        }
    }
    
    func getShortestPath() -> (sucess: Bool, errorMessage: String,pathGirdWay: Bool, totalCost : Int, sequence : Array<Any> ) {
        
        if(validateData(array: (cost?.grid)!)){
            let cost = findShortestCostPath()
            return (true,"",false,cost,[Int]())
        }
        else{
            return (false,"Invalid matrix",false,0,[Int]())
        }
    }
    
    func validateData(array:Array<String>) -> Bool {
        
        var flag = true
        
        for string in array
        {
            if let _:Int = Int(string)
            {
                
            }else
            {
                flag = false
                break
            }
        }
        return flag
    }
    
    func initMatrxix (){
        
        cost = Matrix.init(rows: 5, columns: 6);
        
        cost?.grid = ["3","4","1","2","8","6",
                      "6","1","8","2","7","4",
                      "5","9","3","9","9","5",
                      "8","4","1","3","2","6",
                      "3","7","2","8","6","4"
        ];
    }
    
    func minCost(cost : Matrix,i : Int, j: Int, tc1 : Matrix) -> String
    {
        let R:Int = (self.cost?.rows)!
        let C:Int = (self.cost?.columns)!
        var tc = tc1
        
        if(tc[i,j] != "-1"){
            return tc[i,j];
        }
        
        if(j == C-1){
            tc[i,j] = cost[i,j];
            return tc[i,j];
        }
        
        var prev_i : Int = 0
        var next_i : Int = 0
        
        if(i == 0){
            prev_i=R-1;
        }
        else{
            prev_i=i-1;
        }
        
        if(i == R-1){
            next_i = 0;
        }
        else{
            next_i = i+1;
        }
        
        var cost1 : String
        var cost2 : String
        var cost3 : String
        var finalcost : String
        
        cost1 = minCost(cost: cost,i: prev_i,j: j+1,tc1: tc);
        
        tc[prev_i,j+1] = cost1;
        
        cost2 = minCost(cost: cost,i: i,j: j+1,tc1: tc);
        tc[i,j+1] = cost2;
        
        cost3=minCost(cost: cost,i: next_i,j: j+1,tc1: tc);
        tc[next_i,j+1] = cost3;
        
        if(Int(cost1)!<Int(cost2)!){
            if(Int(cost1)!<Int(cost3)!) {
                finalcost=cost1;
            }
            else {
                finalcost=cost3;
            }
        }
        else{
            if(Int(cost2)!<Int(cost3)!) {
                finalcost=cost2;
            }
            else {
                finalcost=cost3;
            }
        }
        
        let a = Int(finalcost)!
        let b = Int(cost[i,j])!
        
        tc[i,j] =  "\(a+b)";
        
        return tc[i,j];
    }
    
    
    func findShortestCostPath() -> Int
    {
        
        let r:Int = (self.cost?.rows)!
        let c:Int = (self.cost?.columns)!
        
        var tc = Matrix.init(rows: r, columns: c);
        
        for i in 0...r-1    {
            for j in 0...c-1 {
                tc[i,j] = "-1"
            }
        }
        
        var minSofar = MAX_VALUE;
        
        for _ in 0...r-1 {
            let cur = minCost(cost:self.cost!,i: 0,j: 0,tc1: tc);
            if(Int(cur)! < minSofar){
                minSofar = Int(cur)!;
            }
        }
        print("findShortestCostPath : \(minSofar) ")
        
        return minSofar
        
    }
    
}
