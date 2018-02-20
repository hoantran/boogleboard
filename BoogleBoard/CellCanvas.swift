//
//  CellCanvas.swift
//  BoogleBoard
//
//  Created by Hoan Tran on 2/13/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

import UIKit

struct PathVector {
  let from: CanvasDirection
  let to: CanvasDirection
}

enum CanvasDirection:String {
  case none = "none"
  case start = "start"
  case end = "end"
  case up = "up"
  case down = "down"
  case left = "left"
  case right = "right"
  case upperLeft = "upperLeft"
  case upperRight = "upperRight"
  case lowerLeft = "lowerLeft"
  case lowerRight = "lowerRight"
}

class CellCanvas: UIView {
  var vector: PathVector?
  
  var lineWidth: CGFloat {
    let smaller = min(frame.width, frame.height)
    return max(smaller*0.1, 1)
  }
  
  func eraseAll(frame: CGRect){
    let context = UIGraphicsGetCurrentContext()
    context?.clear(frame)
  }
  

  fileprivate func drawStart(_ rect: CGRect, _ path: UIBezierPath){
    path.append(UIBezierPath(ovalIn: frame.insetBy(dx: 0.3*frame.width, dy: 0.3*frame.height)))
  }
  
  fileprivate func drawEnd(_ rect: CGRect, _ path: UIBezierPath){
    path.append(UIBezierPath(rect: frame.insetBy(dx: 0.40*frame.width, dy: 0.40*frame.height)))
    path.fill()
  }
  
  fileprivate func drawUp(_ rect: CGRect, _ path: UIBezierPath){
    path.move(to: CGPoint(x: frame.width/2, y: 0))
    path.addLine(to: CGPoint(x: frame.width/2, y: frame.height/2))
  }
  
  fileprivate func drawDown(_ rect: CGRect, _ path: UIBezierPath){
    path.move(to: CGPoint(x: frame.width/2, y: frame.height/2))
    path.addLine(to: CGPoint(x: frame.width/2, y: frame.height))
  }
  
  fileprivate func drawLeft(_ rect: CGRect, _ path: UIBezierPath) {
    path.move(to: CGPoint(x: 0, y: frame.height/2))
    path.addLine(to: CGPoint(x: frame.width/2, y: frame.height/2))
  }
  
  fileprivate func drawUpperLeft(_ rect: CGRect, _ path: UIBezierPath) {
    path.move(to: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x: frame.width/2, y: frame.height/2))
  }
  
  fileprivate func drawLowerLeft(_ rect: CGRect, _ path: UIBezierPath) {
    path.move(to: CGPoint(x: 0, y: frame.height))
    path.addLine(to: CGPoint(x: frame.width/2, y: frame.height/2))
  }
  
  fileprivate func drawRight(_ rect: CGRect, _ path: UIBezierPath) {
    path.move(to: CGPoint(x: frame.width, y: frame.height/2))
    path.addLine(to: CGPoint(x: frame.width/2, y: frame.height/2))
  }
  
  fileprivate func drawUpperRight(_ rect: CGRect, _ path: UIBezierPath) {
    path.move(to: CGPoint(x: frame.width, y: 0))
    path.addLine(to: CGPoint(x: frame.width/2, y: frame.height/2))
  }
  
  fileprivate func drawLowerRight(_ rect: CGRect, _ path: UIBezierPath) {
    path.move(to: CGPoint(x: frame.width, y: frame.height))
    path.addLine(to: CGPoint(x: frame.width/2, y: frame.height/2))
  }
  
  fileprivate func getPen()->UIBezierPath {
    let path = UIBezierPath()
    path.lineWidth = lineWidth
    return path
  }
  
  fileprivate func draw(_ direction: CanvasDirection, _ rect: CGRect) {
    if direction == .none { return }
    
    UIColor.yellow.setStroke()
    let path = getPen()
    
    switch direction {
    case .start:
      UIColor.green.setStroke()
      drawStart(rect, path)
    case .end:
      UIColor.red.setStroke()
      UIColor.red.setFill()
      drawEnd(rect, path)
    case .up:
      drawUp(rect, path)
    case .down:
      drawDown(rect, path)
    case .left:
      drawLeft(rect, path)
    case .right:
      drawRight(rect, path)
    case .upperRight:
      drawUpperRight(rect, path)
    case .lowerRight:
      drawLowerRight(rect, path)
    case .upperLeft:
      drawUpperLeft(rect, path)
    case .lowerLeft:
      drawLowerLeft(rect, path)
    default:
      print("ERR: direction [\(direction.rawValue)] is not valid.")
    }
    
    path.stroke()
  }
  
  override func draw(_ rect: CGRect) {
    eraseAll(frame: frame)
    
    if let vector = vector {
      if vector.from == .end {
        print("ERR: FROM can not be the end.")
      } else if vector.to == .start {
        print("ERR: TO does not have START direction.")
      } else {
        draw(vector.from, rect)
        draw(vector.to, rect)
      }
    }
    
    setNeedsDisplay()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    vector = PathVector(from: .lowerLeft, to: .upperLeft)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  
}
