//
//  HomeCells.swift
//  CaretCaster
//
//  Created by Daymein Gregorio on 2019/04/16.
//  Copyright © 2019 Daymein Gregorio. All rights reserved.
//

import UIKit

class ContinueListeningCell: UICollectionViewCell {
  
  let imageView: UIImageView = {
    let iV = UIImageView()
    iV.backgroundColor = .gray
    iV.contentMode = .scaleAspectFill
    iV.layer.cornerRadius = 4
    iV.clipsToBounds = true
    return iV
  }()
  
  let titleLabel: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    lbl.lineBreakMode = .byWordWrapping
    lbl.numberOfLines = 2
    lbl.textColor = ThemeColor.mainText
    return lbl
  }()
  
  let timeRemainingLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = ThemeColor.subText
    lbl.font = UIFont.systemFont(ofSize: 12, weight: .light)
    return lbl
  }()
  
  let descriptionLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = ThemeColor.mainText
    lbl.font = UIFont.systemFont(ofSize: 12)
    lbl.lineBreakMode = .byWordWrapping
    lbl.numberOfLines = 0
    return lbl
  }()
  
  static let id = "ContinueListeningCell"
  
  func configure(podcast: Podcast) {
    backgroundColor = .white
    if let thumbURL = podcast.thumbnailURL {
      imageView.load(url: thumbURL)
    }
    titleLabel.text = podcast.title
    timeRemainingLabel.text = "15 minutes remaining"
    descriptionLabel.text = podcast.description
    layoutComponentViews()
  }
  
  private func layoutComponentViews() {
    layoutImageView()
    layoutTitleLabel()
    layoutTimeRemainingLabel()
    layoutDescriptionLabel()
  }
  
  private func layoutImageView() {
    addSubview(imageView)
    imageView.setAnchors(top: topAnchor, left: leftAnchor, paddingTop: 0, paddingLeft: 0, width: 60, height: 60)
  }
  
  private func layoutTitleLabel() {
    addSubview(titleLabel)
    titleLabel.setAnchors(top: imageView.topAnchor, left: imageView.rightAnchor, right: rightAnchor,
                          paddingTop: 8, paddingLeft: 12, paddingRight: 16)
  }
  
  private func layoutTimeRemainingLabel() {
    addSubview(timeRemainingLabel)
    timeRemainingLabel.setAnchors(left: titleLabel.leftAnchor, bottom: imageView.bottomAnchor, right: titleLabel.rightAnchor)
  }
  
  private func layoutDescriptionLabel() {
    addSubview(descriptionLabel)
    descriptionLabel.setAnchors(top: imageView.bottomAnchor, left: leftAnchor,
                                right: rightAnchor, paddingTop: 12)
  }
  
}

class RecentlyAddedCollectionCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  static let id = "RecentlyAddedCollectionCell"
  
  var podThumbs = [URL]() {
    didSet { collectionView.reloadData() }
  }
  
  let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 30
    layout.scrollDirection = .horizontal
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.backgroundColor = .white
    return cv
  }()
  
  func configure(podcasts: [Podcast]) {
    backgroundColor = .darkGray
    layoutCollectionView()
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(RecentlyAddedCell.self, forCellWithReuseIdentifier: RecentlyAddedCell.id)
    collectionView.showsHorizontalScrollIndicator = false
    
    podThumbs = podcasts.compactMap { $0.thumbnailURL }
  }
  
  // MARK: dataSource functions
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return podThumbs.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentlyAddedCell.id, for: indexPath) as? RecentlyAddedCell
      else { return UICollectionViewCell() }
    cell.configure(url: podThumbs[indexPath.row])
    return cell
  }
  
  // MARK: flow delegate functions
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 60, height: 60)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
  }
  
  private func layoutCollectionView() {
    addSubview(collectionView)
    collectionView.setAnchors(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("selection index: section: \(indexPath.section), row: \(indexPath.row)")
  }
  
}

class RecentlyAddedCell: UICollectionViewCell {
  
  static let id = "RecentlyAddedCell"
  
  var imageView: UIImageView = {
    let iV = UIImageView()
    iV.contentMode = .scaleAspectFill
    return iV
  }()
  
  func configure(url: URL) {
    layoutImageView()
    imageView.load(url: url)
    backgroundColor = .darkGray
    layer.cornerRadius = 4
    clipsToBounds = true
  }
  
  private func layoutImageView() {
    addSubview(imageView)
    imageView.setAnchors(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
  }
  
}

class MyCastCell: UICollectionViewCell {
  
  static let id = "MyCastCell"
  static let size = CGSize(width: (UIScreen.main.bounds.width / 2) - 24,
                           height: (UIScreen.main.bounds.width / 2) - 4)
  
  private let imageView: UIImageView = {
    let iV = UIImageView()
    iV.backgroundColor = .gray
    iV.contentMode = .scaleAspectFill
    iV.layer.cornerRadius = 4
    iV.clipsToBounds = true
    return iV
  }()
  
  private let titleLabel: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont.systemFont(ofSize: 12, weight: .regular)
    lbl.textColor = ThemeColor.mainText
    return lbl
  }()
  
  private let alertLabel: NewPodsAlertLabel = {
    let lbl = NewPodsAlertLabel()
    lbl.font = UIFont.systemFont(ofSize: 12, weight: .medium)
    lbl.textColor = .white
    lbl.textAlignment = .right
    lbl.backgroundColor = .red
    lbl.layer.borderColor = UIColor.white.cgColor
    lbl.layer.borderWidth = 2
    lbl.layer.cornerRadius = 4
    lbl.layer.maskedCorners = [.layerMinXMaxYCorner]
    lbl.clipsToBounds = true
    return lbl
  }()
  
  func configure(podcast: Podcast) {
    backgroundColor = .white
    layer.cornerRadius = 4
    layer.maskedCorners = [.layerMaxXMinYCorner]
    clipsToBounds = true
    layoutUIComponents()
    titleLabel.text = podcast.title
    if let img = podcast.image {
      imageView.image = img
    } else if let imgURL = podcast.imageURL {
      imageView.load(url: imgURL)
    }
    alertLabel.text = String(describing: podcast.totalEpisodes) // totalEpisodes is temp
  }
  
  private func layoutUIComponents() {
    layoutImageView()
    layoutTitleLabel()
    layoutAlertLabel()
  }
  
  private func layoutImageView() {
    addSubview(imageView)
    imageView.setAnchors(top: topAnchor, left: leftAnchor, right: rightAnchor, height: MyCastCell.size.width)
  }
  
  private func layoutTitleLabel() {
    addSubview(titleLabel)
    titleLabel.setAnchors(top: imageView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
  }
  
  private func layoutAlertLabel() {
    addSubview(alertLabel)
    alertLabel.setAnchors(top: topAnchor, right: rightAnchor, paddingTop: -2, paddingRight: -2)
  }
  
}
