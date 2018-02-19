//
//  MainViewDataSource.swift
//  BoogleBoard
//
//  Created by Hoan Tran on 2/12/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

import UIKit

extension MainViewController: UICollectionViewDataSource {

  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return cellVectors?.count ?? 0
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoardCell.cellID, for: indexPath) as! BoardCell
    if self.cellVectors == nil {
      print("NIL [\(indexPath.item)]")
      cell.canvas.vector = nil
    } else {
      print("DATA [\(indexPath.item)]")
      if let from = self.cellVectors?[indexPath.item].from, let to = self.cellVectors?[indexPath.item].to {
        if from == .none && to == .none {
          print("TELLING TO CLEAR [\(indexPath.item)]")
          cell.canvas.vector = nil
        } else {
          cell.canvas.vector = self.cellVectors?[indexPath.item]
        }
      }
    }
//    switch indexPath.item {
//    case 0:
//      cell.canvas.vector = PathVector(from: .start, to: .right)
//    case 1:
//      cell.canvas.vector = PathVector(from: .left, to: .lowerLeft)
//    case 2:
//      cell.canvas.vector = PathVector(from: .upperRight, to: .right)
//    case 3:
//      cell.canvas.vector = PathVector(from: .left, to: .end)
//    default:
//      print("Not there yet.")
//    }
//    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextCell.cellID, for: indexPath) as! TextCell
//    cell.textLabel.text = "[\(indexPath.item)]"
    cell.myID = indexPath.item
    return cell
  }
  
  
  public func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
}
