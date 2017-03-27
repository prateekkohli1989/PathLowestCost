//
//  MinCost.swift
//  Matrix
//
//  Created by Prateek Kohli on 24/03/17.
//  Copyright © 2017 VGgroup. All rights reserved.
//

import Foundation

let MAX_VALUE = 9999
var MAX_COST = 9999 //50


public class Node{
    
    var val : Int;
    
    var levelCovered = 0;
    
    var indexes = [Int]();
    
    var isProcesed = false;
    
    init (_ n : Int){
        val = n;
    }
    
    func reset () -> Void {
        levelCovered = 0
        isProcesed = false
        answer = Answer();
        indexes = [];
    }
    
    var answer =  Answer();
    
}

struct Matrix{
    
    let rows: Int, columns: Int
    var grid: [Node]
    
    init(rows: Int, columns: Int) {
        
        self.rows = rows

        self.columns = columns
        self.grid = []
        
        for _ in 0..<rows*columns  {
            let node = Node(0)
            self.grid.append(node);
        }
        
//        grid = Array(repeating: node, count: rows * columns)
    }
    
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Node {
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

 class Answer{
    
    var  ansSofar = MAX_VALUE ;
    
    var levelCovered = 0;
    
    var maxCostReached = false;
    
    init(){

    }
    
    init(df : Int,lev : Int){
      ansSofar = df
      levelCovered = lev
    }
    
  
    
    func isLessThan(_ ob : Answer) -> Bool{
    
        if(self.levelCovered>ob.levelCovered){
            return true;
        }
    
        if(self.levelCovered<ob.levelCovered){
            return false;
        }
    
        return self.ansSofar <= ob.ansSofar;
    }
}




public class MinCost {
    
    var cost : Matrix?
    
    func getShortestPath() -> (sucess: Bool, totalCost : Int, sequence : Array<Int> ) {
        
        var bestSofar = Answer();
        
        var isPathComplete = false
        
        var bestSofarIndexes : [Int] = [Int]();
        
        let rows : Int = (cost?.rows)!
        let cols : Int = (cost?.columns)!
        
        for loop1 in 0..<rows {
            
            for row in 0..<rows  {
                for col in 0..<cols  {
                    let node = cost?[row,col]
                    node?.reset()
                }
            }
            
            let node = cost?[loop1,0]
            
            let currentAnser = node?.val;
            
            if(currentAnser!<50){
                let current_best = getAnswer(cost: cost!, rows: rows,rowno: loop1,cols: cols, colno: 0,currsum: currentAnser!)
                
                if(current_best.isLessThan(bestSofar)){
                    bestSofar=current_best;
                    bestSofarIndexes=(node?.indexes)!;
                }
            }
        }
        
        print(bestSofar.ansSofar);
    
        return (isPathComplete,bestSofar.ansSofar,bestSofarIndexes)
    }

    public func initaliseMatrix(arr : [Int], m : Int, n : Int) -> Void {
        cost = Matrix(rows: m, columns: n);
        cost?.grid = [Node]()
        if(!arr.isEmpty) {
            for index in 0..<m*n  {
                let node = Node(arr[index])
                cost?.grid.append(node)
            }
        }
        else{
            for _ in 0..<m*n  {
                let node = Node(0)
                cost?.grid.append(node)
            }
        }
    }

    
    func addElements(current :  Node, currentIndex : Int, prev :  Node) -> Void{
        
        current.indexes.append(currentIndex+1)

        for index in prev.indexes {
            current.indexes.append(index)
        }
    }
    
    func getAnswer( cost : Matrix,  rows : Int, rowno : Int, cols : Int, colno : Int, currsum: Int) -> Answer{
        
        if(colno>=cols){
            let n : Node = cost[rowno,colno]
            return n.answer;
        }
        
        if(colno == cols-1){
            
            let n : Node = cost[rowno,colno]
            
            n.answer.ansSofar = n.val;
            n.levelCovered = colno;
            n.isProcesed = true;
            
            n.indexes.append(rowno+1);
            
            return n.answer;
        }
        
        var ans1 =  Answer(df: MAX_VALUE,lev: colno);
        var ans2 =  Answer(df: MAX_VALUE,lev: colno);
        var ans3 =  Answer(df: MAX_VALUE,lev: colno);
        
        var prevRow : Int = rowno-1;
        if(prevRow == -1){
            prevRow=rows-1;
        }
        
        var nextRow : Int = rowno+1;
        if(nextRow >= rows){
            nextRow=0;
        }
        
        if(currsum + cost[prevRow,colno+1].val<MAX_COST){
            if(cost[prevRow,colno+1].isProcesed==true){
                ans1 = cost[prevRow,colno+1].answer;
            }
            else{
                ans1 = getAnswer(cost: cost, rows: rows, rowno: prevRow, cols: cols, colno: colno+1, currsum: currsum+cost[prevRow,colno+1].val);
            }
        }
        
        if(currsum+cost[rowno,colno+1].val<MAX_COST){
            if(cost[rowno,colno+1].isProcesed==true){
                ans2=cost[rowno,colno+1].answer;
            }
            else{
                ans2=getAnswer(cost: cost,  rows: rows, rowno: rowno, cols: cols, colno: colno+1, currsum: currsum+cost[rowno,colno+1].val);
            }
        }
        
        if(currsum+cost[nextRow,colno+1].val<MAX_COST){
            if(cost[nextRow,colno+1].isProcesed==true){
                ans3=cost[nextRow,colno+1].answer;
            }
            else{
                ans3 = getAnswer(cost: cost,  rows: rows, rowno: nextRow, cols: cols, colno: colno+1, currsum: currsum+cost[nextRow,colno+1].val);
            }
        }
        
        if(ans1.ansSofar == ans2.ansSofar && ans1.ansSofar == ans3.ansSofar && ans1.ansSofar == MAX_VALUE){
            
            cost[rowno,colno].answer = Answer(df: cost[rowno,colno].val,lev: colno);
            cost[rowno,colno].isProcesed = true;
            cost[rowno,colno].indexes.append(rowno+1);
            return cost[rowno,colno].answer;
        }
       
        if(ans1.isLessThan(ans2)){
            if(ans1.isLessThan( ans3)){
                cost[rowno,colno].answer =  Answer(df: cost[rowno,colno].val+ans1.ansSofar,lev: ans1.levelCovered);
                addElements(current: cost[rowno,colno], currentIndex: rowno,prev: cost[prevRow,colno+1]);
                cost[rowno,colno].isProcesed=true;
            }
            else{
                cost[rowno,colno].answer =  Answer(df: cost[rowno,colno].val+ans3.ansSofar,lev: ans3.levelCovered);
                addElements(current: cost[rowno,colno], currentIndex: rowno,prev: cost[nextRow,colno+1]);
                cost[rowno,colno].isProcesed=true;
            }
        }
        else{
            if(ans2.isLessThan(ans3)){
                cost[rowno,colno].answer = Answer(df: cost[rowno,colno].val+ans2.ansSofar,lev: ans2.levelCovered);
                addElements(current: cost[rowno,colno], currentIndex: rowno,prev: cost[rowno,colno+1]);
                cost[rowno,colno].isProcesed=true;
            }
            else{
                cost[rowno,colno].answer =  Answer(df: cost[rowno,colno].val+ans3.ansSofar,lev: ans3.levelCovered);
                addElements(current: cost[rowno,colno], currentIndex: rowno,prev: cost[nextRow,colno+1]);
                cost[rowno,colno].isProcesed=true;
            }
        }
        return cost[rowno,colno].answer;
    }
}
