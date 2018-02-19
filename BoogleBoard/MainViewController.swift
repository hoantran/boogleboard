//
//  MainViewController.swift
//  BoogleBoard
//
//  Created by Hoan Tran on 2/12/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

import UIKit

typealias BoardSize = (rowCount: Int, colCount: Int)

class MainViewController: UIViewController {
  var cellVectors: [PathVector]?
  
  let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
  weak var displayClient: BoogleBoardClient?
  private var boogleBoard: BoogleBoard?
  
  var boardSize: BoardSize? {
    didSet {
      resetCells()
    }
  }
  
  func resetCells(){
    print("RESETING CELLS")
    var size = 0
    if let boardSize = self.boardSize {
      size = boardSize.colCount * boardSize.rowCount
    }

    cellVectors = Array<PathVector>(repeating: PathVector(from: .none, to: .none), count: size)
    DispatchQueue.main.async {
      self.mainView.reloadData()
    }
  }
  
  lazy var mainView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let v = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    v.register(BoardCell.self, forCellWithReuseIdentifier: BoardCell.cellID)
    v.register(TextCell.self, forCellWithReuseIdentifier: TextCell.cellID)
    v.translatesAutoresizingMaskIntoConstraints = false
    v.backgroundColor = UIColor.black
    v.dataSource = self
    v.delegate = self
    return v
  }()
  
  fileprivate func layoutMainView() {
    view.addSubview(mainView)
    NSLayoutConstraint.activate([
      mainView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
      mainView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
      mainView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
      mainView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor),
      ])
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.barTintColor = UIColor.cyan
    layoutMainView()
    boogleBoard = BoogleBoard()
    boogleBoard?.display = self
    
    
    DispatchQueue.global(qos: .background).async {
      print("This is run on the background queue")
      self.boogleBoard?.start()
    }

    
  }
}
