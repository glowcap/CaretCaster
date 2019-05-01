//
//  OnboardSubscribeViewController.swift
//  CaretCaster
//
//  Created by Daymein Gregorio on 4/28/19.
//  Copyright © 2019 Daymein Gregorio. All rights reserved.
//

import UIKit

class OnboardSubscribeViewController: UIViewController {
  
  var networking: Networking?
  var selectedGenres = [Genre]()
  var bestOfPodcasts = [[Podcast]]()
  
  let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 16
    layout.scrollDirection = .vertical
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.backgroundColor = .groupTableViewBackground
    return cv
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    configureCollectionView()
    layoutCollectionView()
    fetchBestOfPodcasts(genres: selectedGenres)
  }
  
  private func fetchBestOfPodcasts(genres: [Genre]) {
    for genre in genres {
      guard let url = networking?.generateBestOfURL(genreId: genre.id, isSafeMode: false) else { return }
      networking?.fire(request: url) { [weak self] data, error in
        guard let d = data, let bestOf: BestOfGenre = self?.networking?.parse(data: d, modelType: .bestOf) else { return }
        DispatchQueue.main.async {
          let top10 = Array(bestOf.podcasts.prefix(9))
          print("top10 count: ", top10.count)
          self?.bestOfPodcasts.append(top10)
          self?.collectionView.reloadData()
        }
      }
    }
  }
  
  private func configureCollectionView() {
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(HomeHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeHeaderView.id)
    collectionView.register(OnboardingPodcastCell.self, forCellWithReuseIdentifier: OnboardingPodcastCell.id)
  }
  
  private func layoutCollectionView() {
    view.addSubview(collectionView)
    collectionView.setAnchors(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
  }
  
}

extension OnboardSubscribeViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return bestOfPodcasts.count
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return bestOfPodcasts[section].count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingPodcastCell.id, for: indexPath) as? OnboardingPodcastCell
      else { return UICollectionViewCell() }
    cell.configureFor(podcast: bestOfPodcasts[indexPath.section][indexPath.row])
    return cell
  }
  
}

extension OnboardSubscribeViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let fullWidth = UIScreen.main.bounds.width
    let cellWidth = fullWidth / 3 - 24
    return CGSize(width: cellWidth, height: cellWidth)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: UIScreen.main.bounds.width, height: 24)
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    if kind == UICollectionView.elementKindSectionHeader {
      if let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                            withReuseIdentifier: HomeHeaderView.id, for: indexPath) as? HomeHeaderView {
        reusableView.headerTitle = selectedGenres[indexPath.section].name
        reusableView.backgroundColor = .gray
        return reusableView
      }
    }
    fatalError("Unknown Type")
  }
  
  
}
