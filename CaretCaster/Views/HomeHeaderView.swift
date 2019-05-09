//
//  HomeHeaderView.swift
//  CaretCaster
//
//  Created by Daymein Gregorio on 5/9/19.
//  Copyright © 2019 Daymein Gregorio. All rights reserved.
//

import UIKit

class HomeHeaderView: UICollectionReusableView {
  
  static let id = "HomeHeaderView"
  
  var headerTitle: String? {
    didSet {
      label.text = headerTitle ?? ""
    }
  }
  
  private var label: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont.systemFont(ofSize: 12, weight: .medium)
    lbl.textColor = .white
    return lbl
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = ThemeColor.baseBackground
    addSubview(label)
    label.setAnchors(top: topAnchor, left: leftAnchor, bottom: bottomAnchor,
                     right: rightAnchor, paddingLeft: 16, paddingRight: 16)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
}
