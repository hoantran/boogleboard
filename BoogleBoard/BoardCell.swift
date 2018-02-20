//
//  BoardCell.swift
//  BoogleBoard
//
//  Created by Hoan Tran on 2/13/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

import UIKit

class BoardCell: UICollectionViewCell {
  static let cellID = "BoardCell"
  
  var myID = 999 {
    didSet {
      textLabel.text = "[\(self.myID)]"
    }
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    canvas.vector = nil
  }
  
  var canvas: CellCanvas = {
    let v = CellCanvas()
    v.translatesAutoresizingMaskIntoConstraints = false
    v.layer.masksToBounds = true
    return v
  }()
  
  lazy var textLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "998"
    label.font = UIFont.boldSystemFont(ofSize: 17)
    label.textColor = UIColor.red
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor.gray
    addSubview(canvas)
    NSLayoutConstraint.activate([
      canvas.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      canvas.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
      canvas.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, constant: -2),
      canvas.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, constant: -2),
      ])
    
//    addSubview(textLabel)
//    NSLayoutConstraint.activate([
//      textLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
//      textLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
//      textLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
//      textLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor),
//      ])
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("BoardCell: init(coder:) has not been implemented")
  }
}
