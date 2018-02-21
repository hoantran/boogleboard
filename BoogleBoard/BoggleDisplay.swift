//
//  BoggleDisplay.swift
//  BoogleBoard
//
//  Created by Hoan Tran on 2/13/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

import UIKit

protocol BoogleBoardClient: class {
  func pathDidDisplay()
}
protocol BoogleBoardDisplay: class {
  func setDimension(_ size: BoardSize)
  func setPath(_ path: [Square])
  func setReceiver(_ client: BoogleBoardClient)
}

//let possiblePaths:[[PathDirection]] =
//  [ [ PathDirection(from: .lowerRight, to: .upperLeft), PathDirection(from: .down, to: .up), PathDirection(from: .lowerLeft, to: .upperRight) ],
//    [ PathDirection(from: .right, to: .left), PathDirection(from: .none, to: .none), PathDirection(from: .left, to: .right) ],
//    [ PathDirection(from: .lowerRight, to: .upperLeft), PathDirection(from: .down, to: .up), PathDirection(from: .lowerLeft, to: .upperRight) ],
//]

let toDirections: [[CanvasDirection]] = [[ .upperLeft, .up, .upperRight],
                                    [ .left, .none, .right],
                                    [ .lowerLeft, .down, .lowerRight],
  ]
let oppositeDirections: [CanvasDirection:CanvasDirection] = [ .down: .up, .lowerRight: .upperLeft, .lowerLeft: .upperRight, .left: .right,
                                                              .up: .down, .upperLeft: .lowerRight, .upperRight: .lowerLeft, .right: .left
  ]

extension MainViewController: BoogleBoardDisplay {

  fileprivate func item(_ position: Square) -> Int? {
    guard let boardSize = self.boardSize else { return nil }
    if position.col < 0 || position.col >= boardSize.colCount { return nil }
    if position.row < 0 || position.row >= boardSize.rowCount { return nil }
    return position.col + (position.row * boardSize.colCount)
  }
  
  fileprivate func getMotionVector(from: Square, to: Square) -> PathVector? {
    let rowVector = to.row - from.row
    let colVector = to.col - from.col
    
    if abs(rowVector) > 1 || abs(colVector) > 1 {
      print("ERR: the adjacent cell must be within 1 cell away.")
      return nil
    }
    
    let to = toDirections[rowVector + 1][colVector + 1]
    if let from = oppositeDirections[to] {
      return PathVector(from: from, to: to)
    }
    
    return nil
  }
  
  func setDimension(_ size: BoardSize) {
    boardSize = size
  }
  
  func setPath(_ path: [Square]) {
    resetCells()
    
    var from:CanvasDirection = .start
    
    for i in 0..<path.count {
      if let currentItemIndex = item(path[i]) {
        if i == path.count - 1 {
          self.cellVectors?[currentItemIndex] = PathVector(from: from, to: .end)
        } else {
          if let vector = getMotionVector(from: path[i], to: path[i+1]) {
            self.cellVectors?[currentItemIndex] = PathVector(from: from, to: vector.to)
            from = vector.from
          } else {
            print("ERR: can not find getMotionVector.")
          }
        }
      } else {
        print("ERR: path[i] is out of range")
      }
    }
    
    DispatchQueue.main.async {
      self.mainView.reloadData()
    }
    usleep(100000)

    displayClient?.pathDidDisplay()
  }
  
  func setReceiver(_ client: BoogleBoardClient) {
    displayClient = client
  }
  
}
