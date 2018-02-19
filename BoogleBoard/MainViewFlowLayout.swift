//
//  MainViewFlowLayout.swift
//  BoogleBoard
//
//  Created by Hoan Tran on 2/12/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

import UIKit

extension MainViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    guard let boardSize = self.boardSize else { return CGSize.zero }
    
    let hPaddingSpace = sectionInsets.left * CGFloat( boardSize.colCount + 1)
    let hAvailableSpace = view.frame.width - hPaddingSpace
    let widthPerItem = hAvailableSpace / CGFloat(boardSize.colCount)
    
    let vPaddingSpace = sectionInsets.top + sectionInsets.bottom + (sectionInsets.left * CGFloat(boardSize.rowCount - 1))
    let viewHeight = view.frame.height
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    let navBarHeight = navigationController?.navigationBar.frame.size.height ?? 0
    let vAvailableSpace = viewHeight - vPaddingSpace - navBarHeight - statusBarHeight
    let heightPerItem = vAvailableSpace / CGFloat(boardSize.rowCount)
    
    return CGSize(width: widthPerItem, height: heightPerItem)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return sectionInsets.left
  }
}
