//
//  OnboardSubscribeViewController.swift
//  CaretCaster
//
//  Created by Daymein Gregorio on 4/28/19.
//  Copyright © 2019 Daymein Gregorio. All rights reserved.
//

import UIKit

class OnboardSubscribeViewController: UIViewController {
  
  var selectedGenres = [Genre]()
  var bestOfPodcasts = [[Podcast]]()
  var subscribedPodcasts = [Podcast]() {
    willSet {
      barButton?.isEnabled = newValue.count >= 3
    }
  }
  
  var barButton: UIBarButtonItem?
  
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
    configureNextButton()
    configureCollectionView()
    layoutCollectionView()
    fetchBestOfPodcasts(genres: selectedGenres)
  }
  
  private func configureNextButton() {
    barButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextTapped))
    barButton?.isEnabled = false
    navigationItem.rightBarButtonItem = barButton
  }
  
  private func fetchBestOfPodcasts(genres: [Genre]) {
    showSpinnerView()
    for genre in genres {
      guard let url = NetworkManager.shared.generateBestOfURL(genreId: genre.id, isSafeMode: false) else { return }
      NetworkManager.shared.fire(request: url) { [weak self] data, error in
        guard let d = data, let bestOf: BestOfGenre = NetworkManager.shared.parse(data: d, modelType: .bestOf) else { return }
        DispatchQueue.main.async {
          let top10 = Array(bestOf.podcasts.prefix(9))
          print("top10 count: ", top10.count)
          self?.bestOfPodcasts.append(top10)
          self?.collectionView.reloadData()
          self?.hideSpinnerView()
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
  
  @objc func nextTapped() {
    if subscribedPodcasts.count > 0 {
      for pod in subscribedPodcasts {
        PersistanceManager.shared.savePodcastToCD(pod)
      }
    }
    UserDefaults.standard.set(true, forKey: UserDefaultKey.returningUser.value())
    let tabController = AppDelegate.configuredCCTabBarController()
    self.present(tabController, animated: true)
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
    let podcast = bestOfPodcasts[indexPath.section][indexPath.row]
    cell.configureFor(podcast: podcast)
    cell.isSelected = subscribedPodcasts.contains(where: {$0.id == podcast.id})
    return cell
  }
  
}

extension OnboardSubscribeViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let podcast = bestOfPodcasts[indexPath.section][indexPath.row]
    if subscribedPodcasts.contains(where: {$0.id == podcast.id}) {
      subscribedPodcasts = subscribedPodcasts.filter { $0.id != podcast.id }
    } else {
      subscribedPodcasts.append(podcast)
    }
    collectionView.reloadItems(at: [indexPath])
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
