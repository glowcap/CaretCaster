//
//  HomeViewController.swift
//  CaretCaster
//
//  Created by Daymein Gregorio on 2019/04/02.
//  Copyright © 2019 Daymein Gregorio. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  
  var recentlyPlayedPodcast: Podcast?
  var recentlyAddedPodcasts = [Podcast]()
  var myPodcasts = [Podcast]()
  
  let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 16
    layout.scrollDirection = .vertical
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.backgroundColor = .white
    return cv
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "Caret Caster"
    configureSettingsBarButton()
    configureCollectionView()
    
    let local = Locale.current
    print(local)
    
    if let pdcst = DesignMocks.podcast {
      recentlyAddedPodcasts = [pdcst, pdcst, pdcst, pdcst, pdcst, pdcst, pdcst, pdcst, pdcst, pdcst]
      myPodcasts = [pdcst, pdcst, pdcst, pdcst, pdcst, pdcst, pdcst, pdcst, pdcst, pdcst]
    }
    
//    let networking = Networking()
    
//    if let request = networking.generateBestOfURL(genreId: 138, region: "us", isSafeMode: false) {
//      networking.fire(request: request) { data, error in
//        guard error == nil else { return }
//        guard let data = data,
//              let bestOf: BestOfGenre = networking.parse(data: data, modelType: ParsingType.bestOf)
//         else { return }
//        print(bestOf.name)
//        print(bestOf.total)
//        guard bestOf.podcasts.count > 0 else { return }
//        print(bestOf.podcasts[0].title)
//      }
//    }
    
  }
  
  private func configureSettingsBarButton() {
    let settingsButton = UIBarButtonItem(title: "•••", style: .plain, target: self, action: #selector(settingsTapped))
    self.navigationItem.rightBarButtonItem = settingsButton
  }
  
  @objc func settingsTapped() {
    print("settings")
  }
  
  func configureCollectionView() {
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(HomeHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeHeaderView.id)
    collectionView.register(ContinueListeningCell.self, forCellWithReuseIdentifier: ContinueListeningCell.id)
    collectionView.register(RecentlyAddedCollectionCell.self, forCellWithReuseIdentifier: RecentlyAddedCollectionCell.id)
    collectionView.register(MyCastCell.self, forCellWithReuseIdentifier: MyCastCell.id)
    
    layoutCollectionView()
  }

  private func layoutCollectionView() {
    view.addSubview(collectionView)
    collectionView.setAnchors(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
  }
  
}

extension HomeViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 3
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return section == 2 ? myPodcasts.count : 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let section = indexPath.section
    switch section {
    case 0:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContinueListeningCell.id, for: indexPath) as? ContinueListeningCell
        else { return UICollectionViewCell() }
      if let pdcst = DesignMocks.podcast {
        cell.configure(podcast: pdcst)
      }
      return cell
    case 1:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentlyAddedCollectionCell.id, for: indexPath) as? RecentlyAddedCollectionCell
        else { return UICollectionViewCell() }
      if let pdcst = DesignMocks.podcast {
        let podcasts = [pdcst, pdcst, pdcst, pdcst, pdcst, pdcst, pdcst, pdcst, pdcst, pdcst]
          cell.configure(podcasts: podcasts)
      }
      return cell
    default:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCastCell.id, for: indexPath) as? MyCastCell
        else { return UICollectionViewCell() }
      cell.configure(podcast: myPodcasts[indexPath.row])
      return cell
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if indexPath.section == 0 {
      
    }
    guard indexPath.section != 1 else { return }
    print("selection index: section: \(indexPath.section), row: \(indexPath.row)")
  }
  
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let fullWidth = UIScreen.main.bounds.width
    switch indexPath.section {
    case 0:
      if let pdcst = DesignMocks.podcast {
        let imageAndPadding = CGFloat(60 + 20)
        let estDescFrame = estimatedFrameFor(text: pdcst.description, width: fullWidth - 32, fontSize: 12, fontWeight: .regular)
        return CGSize(width: fullWidth - 32, height: estDescFrame.height + imageAndPadding)
      }
      return CGSize(width: fullWidth - 32, height: 00)
    case 1:
      return CGSize(width: fullWidth, height: 80)
    case 2:
      let cellWidth = fullWidth / 2 - 24
      return CGSize(width: cellWidth, height: cellWidth + 20)
    default:
      return CGSize.zero
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    switch section {
    case 0:
      return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    case 1:
      return UIEdgeInsets.zero
    default:
      return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: UIScreen.main.bounds.width, height: 24)
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    if kind == UICollectionView.elementKindSectionHeader {
      if let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                         withReuseIdentifier: HomeHeaderView.id, for: indexPath) as? HomeHeaderView {
        let headerTitle: String
        switch indexPath.section {
        case 0:
          headerTitle = "Continue Listening"
        case 1:
          headerTitle = "Recently Added"
        default:
          headerTitle = "My Podcasts"
        }
        reusableView.headerTitle = headerTitle
        return reusableView
      }
    }
    fatalError("Unknown Type")
  }
  
}
