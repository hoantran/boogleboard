//
//  TextCell.swift
//  BoogleBoard
//
//  Created by Hoan Tran on 2/17/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

import UIKit

class TextCell: UICollectionViewCell {
  static let cellID = "TextCell"
  
  var textLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "?"
    label.font = UIFont.boldSystemFont(ofSize: 17)
    label.textColor = UIColor.white
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(textLabel)
    NSLayoutConstraint.activate([
      textLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      textLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
      textLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
      textLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor),
      ])
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
