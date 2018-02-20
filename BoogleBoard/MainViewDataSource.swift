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
    cell.canvas.vector = self.cellVectors?[indexPath.item]
    cell.canvas.setNeedsDisplay()
    cell.myID = indexPath.item
    return cell
  }
  
  
  public func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
}
