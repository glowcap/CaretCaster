//
//  HomeCells.swift
//  CaretCaster
//
//  Created by Daymein Gregorio on 2019/04/16.
//  Copyright © 2019 Daymein Gregorio. All rights reserved.
//

import UIKit



class ContinueListeningCell: UICollectionViewCell {
  
  static let id = "ContinueListeningCell"
  
  func configure() {
    backgroundColor = .groupTableViewBackground
    layer.cornerRadius = 4
    clipsToBounds = true
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
    iV.contentMode = .scaleAspectFill
    iV.layer.cornerRadius = 4
    iV.clipsToBounds = true
    return iV
  }()
  
  private let titleLabel: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont.systemFont(ofSize: 12, weight: .regular)
    lbl.textColor = ThemeColors.mainText
    return lbl
  }()
  
  func configure(podcast: Podcast) {
    backgroundColor = .white
    layoutUIComponents()
    titleLabel.text = podcast.title
    guard let imgURL = podcast.imageURL else { return }
    imageView.load(url: imgURL)
  }
  
  private func layoutUIComponents() {
    layoutImageView()
    layoutTitleLabel()
  }
  
  private func layoutImageView() {
    addSubview(imageView)
    imageView.setAnchors(top: topAnchor, left: leftAnchor, right: rightAnchor, height: MyCastCell.size.width)
  }
  
  private func layoutTitleLabel() {
    addSubview(titleLabel)
    titleLabel.setAnchors(top: imageView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
  }

}

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
    lbl.textColor = ThemeColors.mainText
    return lbl
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(label)
    label.setAnchors(top: topAnchor, left: leftAnchor, bottom: bottomAnchor,
                     right: rightAnchor, paddingLeft: 16, paddingRight: 16)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
}