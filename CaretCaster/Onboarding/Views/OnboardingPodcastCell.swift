//
//  OnboardingPodcastCell.swift
//  CaretCaster
//
//  Created by Daymein Gregorio on 5/1/19.
//  Copyright © 2019 Daymein Gregorio. All rights reserved.
//

import UIKit

class OnboardingPodcastCell: UICollectionViewCell {
  
  private var imageView: UIImageView = {
    let iV = UIImageView()
    iV.backgroundColor = .gray
    iV.contentMode = .scaleAspectFill
    iV.layer.cornerRadius = 4
    iV.clipsToBounds = true
    return iV
  }()
  
  override var isSelected: Bool {
    willSet {
      layer.borderColor = newValue ? ThemeColors.caret.cgColor: UIColor.clear.cgColor
      layer.borderWidth = newValue ? 3 : 0
    }
  }
  
  static let id = "OnboardingPodcastCell"
  
  func configureFor(podcast: Podcast) {
    addSubview(imageView)
    imageView.setAnchors(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    guard let imageURL = podcast.imageURL else { return }
    imageView.load(url: imageURL)
  }
  
}
