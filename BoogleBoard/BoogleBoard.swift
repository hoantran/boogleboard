//
//  BoogleBoard.swift
//  BoogleBoard
//
//  Created by Hoan Tran on 2/13/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

import Foundation

typealias Square = ( row: Int, col: Int )

class BoogleBoard {
  weak var display:BoogleBoardDisplay?
  
  private var count = 0
  private var paths = [[Square]]()
  
  private func isLegal(square: Square, rowCount: Int, colCount: Int) -> Bool {
    return square.col >= 0 && square.row >= 0 && square.col < colCount && square.row < rowCount
  }

  private func startingPositions(rowCount: Int, colCount: Int) -> [Square] {
    var result = [Square]()
    let rowLimit = ( rowCount % 2 ) + rowCount/2
    for i in 0..<rowLimit {
      var j = i
      repeat {
        result.append(Square(i,j))
        j += 1
      } while j < (colCount - i - 1)
    }
    return result
  }

  private func possibleMoves(current: Square, arry: inout [[Bool]]) -> [Square]{
    var result = [Square]()

    for i in (current.row - 1)...(current.row + 1) {
      for j in (current.col - 1)...(current.col + 1) {
        if i != current.row || j != current.col {
          let square = Square(i,j)
          if isLegal(square: square, rowCount: arry.count, colCount: arry[0].count) && arry[i][j] {
            result.append(square)
          }
        }
      }
    }

    return result
  }

  private func search(path: inout [Square], arry: inout [[Bool]]) {
    let current = path[path.count-1]
    let possibles = possibleMoves(current: current, arry: &arry)
    var valids = possibles.filter() { square in
      return arry[square.row][square.col]
    }

    if valids.count == 0 {
//      print("[\(count)]")
      display?.setPath(path)
      paths.append(path)
      count += 1
    } else {
      while valids.count > 0 {
        let next = valids.removeFirst()
        arry[next.row][next.col] = false
        path.append(next)
        //    print(" [\(next.row)][\(next.col)]")
        search(path: &path, arry: &arry)
        arry[next.row][next.col] = true
        path.removeLast()
      }
    }
  }

  func fetch()->[Square]? {
    if paths.count > 0 {
      return paths.removeFirst()
    } else {
      return nil
    }
  }
  
  func start() {
    var availableSquares = Array(repeating: Array(repeating: true, count: 4), count: 2)
    
    display?.setDimension(BoardSize(rowCount: availableSquares.count, colCount: availableSquares[0].count) )
    display?.setReceiver(self)
    
    var startingPostioins = startingPositions(rowCount: availableSquares.count, colCount: availableSquares[0].count)

    while startingPostioins.count > 0 {
      let first = startingPostioins.removeFirst()
      availableSquares[first.row][first.col] = false
      print("First: [\(first.row)][\(first.col)]")
      var path: [Square] = [first]
      search(path: &path, arry: &availableSquares)
      availableSquares[first.row][first.col] = true
    }
  }
}


extension BoogleBoard: BoogleBoardClient {
  func pathDidDisplay() {
  }
}









