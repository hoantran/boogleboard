//
//  MainViewDelegate.swift
//  BoogleBoard
//
//  Created by Hoan Tran on 2/12/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

import UIKit

extension MainViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("[\(indexPath.item)]")
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}
