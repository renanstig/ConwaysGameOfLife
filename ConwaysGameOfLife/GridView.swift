//
//  GridView.swift
//  ConwaysGameOfLife
//
//  Created by Renan on 27/04/17.
//  Copyright © 2017 docutoolschallenge. All rights reserved.
//

import UIKit

class GridView: UIView {
    
    var length = 0
    var cells = Array<Array<GridCell>>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect, length: Int) {
        super.init(frame: frame)
        self.length = length
        var cell = Array<Any>(repeating: Array<Any>(), count: length)
        for i in 0..<length {
            cell.insert(Array<GridCell>(repeating: GridCell(), count: length), at: i)
        }
        
        cells = cell as! Array<Array<GridCell>>
        
        let cellLength = Int(min(frame.size.width, frame.size.height)) / length
        for r in stride(from: 0, to: length, by: 1) {
            for c in stride(from: 0, to: length, by: 1) {
                let cell = GridCell(length: cellLength)
                let origin = CGPoint(x: c * cellLength, y: r * cellLength)
                cell.frame = CGRect(x: origin.x, y: origin.y, width: cell.frame.size.width, height: cell.frame.size.height)
                self.addSubview(cell)
                cells[r][c] = cell
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func findCellAt(point: CGPoint) -> GridCell? {
        let row = Int(point.x)
        let col = Int(point.y)
        
        guard row <= length || col <= length else {
            return nil
        }
        
        return self.cells[col][row]
        
    }
    
    //  Converted with Swiftify v1.0.6326 - https://objectivec2swift.com/
    func currentState() -> [[NSNumber]] {
        var cell = Array<Any>(repeating: Array<Any>(), count: length)
        for i in 0..<length {
            cell.insert(Array<NSNumber>(repeating: NSNumber(), count: length), at: i)
        }
        var ret = cell as! Array<Array<NSNumber>>
        //look at every cell and record whether it's filled or not
        for row in 0..<length {
            for col in 0..<length {
                let cell = self.findCellAt(point: CGPoint(x: CGFloat(row), y: CGFloat(col)))
                ret[row][col] = cell!.selected! ? 1 : 0
            }
        }
        return ret
    }

    
    func changeGameState(state: [[NSNumber]]) {
        for row in 0..<length {
            for col in 0..<length {
                let cell = self.findCellAt(point: CGPoint(x: CGFloat(row), y: CGFloat(col)))
                cell?.selected = state[row][col].boolValue
            }
        }
    }
    
    
    func numberOfNeihbors(loc: CGPoint, state: [[NSNumber]]) -> Int {
        let row = Int(loc.x)
        let col = Int(loc.y)
        var neighbors = 0
        
        if (row > 0) {
            if (state[row - 1][col].boolValue) {
                neighbors += 1
            }
            if (col > 0) {
                if (state[row - 1][col - 1].boolValue)  {
                    neighbors += 1
                }
            }
            if (col < length - 1) {
                if (state[row - 1][col + 1].boolValue) {
                    neighbors += 1
                }
            }
        }
        if (row < length - 1) {
            if (state[row + 1][col].boolValue) {
                neighbors += 1
            }
            
            if (col > 0) {
                if (state[row + 1][col - 1].boolValue) {
                    neighbors += 1
                }
            }
            if (col < length - 1) {
                if (state[row + 1][col + 1].boolValue) {
                    neighbors += 1
                }
            }
        }
        if (col > 0) {
            if (state[row][col - 1].boolValue) {
                neighbors += 1
            }
        }
        if (col < length - 1) {
            if (state[row][col + 1].boolValue) {
                neighbors += 1
            }
        }
        
        return neighbors;
    }
    
    
    func nextGeneration() {
        let gameState = self.currentState()
        var newState = self.currentState()
        for row in 0..<length {
            for col in 0..<length {
                let point = CGPoint(x: row, y: col)
                let n = self.numberOfNeihbors(loc: point, state: gameState)
                if (n < 2)  {
                    newState[row][col] = 0
                }
                if (n >= 2 && n <= 3 && newState[row][col].boolValue) {
                    newState[row][col] = 1
                }
                if (n == 3) {
                    newState[row][col] = 1
                }
                if (n > 3) {
                    newState[row][col] = 0;
                }

            }
        }
        changeGameState(state: newState)
    }


}
