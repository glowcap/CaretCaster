//
//  CCTabBarController.swift
//  CaretCaster
//
//  Created by Daymein Gregorio on 2019/04/09.
//  Copyright © 2019 Daymein Gregorio. All rights reserved.
//

import UIKit

protocol PodViewDelegate: AnyObject {
  func activatePodView()
}

protocol CCTabButtonDelegate: AnyObject {
  func tapped(isPlaying: Bool)
}

final class CCTabBarController: UITabBarController {
  
  let mainButton = UIButton()
  let mainBtnSize = CGFloat(UIScreen.main.bounds.width * 0.18)
  
  var currentlyPlayingPodcast: Podcast?
  
  var podView = PodView()
  
  weak var buttonDelegate: CCTabButtonDelegate?
  var isPlaying = false {
    willSet {
      print("isPlaying: \(newValue)")
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let podcast = currentlyPlayingPodcast {
      configureMainButton()
      layoutComponentViews()
      podView.configure(for: podcast)
      if !isPlaying {
        animateOutPodView()
      }
    }
  }
  
  private func configureMainButton() {
    mainButton.backgroundColor = ThemeColor.stem
    mainButton.layer.cornerRadius = mainBtnSize / 2
    mainButton.clipsToBounds = true
    mainButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
  }
  
  @objc func tapped() {
    isPlaying = !isPlaying
    buttonDelegate?.tapped(isPlaying: isPlaying)
    mainButton.isEnabled = false
    
    if isPlaying {
      animateInPodView()
    } else {
      animateOutPodView()
    }
  }
  
  private func animateInPodView() {
    podView.alpha = 1
    UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: [], animations: { [weak self] in
      self?.podView.transform = .identity
      self?.podView.layer.cornerRadius = 0
      }, completion: { [weak self] _ in
        self?.mainButton.isEnabled = true
    })
  }
  
  private func animateOutPodView() {
    let transform = podView.transform
    let scaledTransform = transform.scaledBy(x: 0.1, y: 0.1)
    let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0, y: 950)
    
    UIView.animate(withDuration: 0.2, delay: 0.0, options: [], animations: { [weak self] in
      self?.podView.transform = scaledAndTranslatedTransform
      self?.podView.layer.cornerRadius = (self?.podView.fullSize.height ?? 100) / 2
      }, completion: { [weak self] _ in
        self?.mainButton.isEnabled = true
    })
    UIView.animate(withDuration: 0.1, delay: 0.22, options: [], animations: { [weak self] in
      self?.podView.alpha = 0
      }, completion: nil)
  }
  
  private func layoutComponentViews() {
    layoutPodView()
    layoutMainButton()
  }
  
}

extension CCTabBarController {
  
  private func layoutPodView() {
    view.addSubview(podView)
    podView.translatesAutoresizingMaskIntoConstraints = false
    podView.bottomAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true
    podView.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor).isActive = true
    podView.heightAnchor.constraint(equalToConstant: podView.fullSize.height).isActive = true
    podView.widthAnchor.constraint(equalToConstant: podView.fullSize.width).isActive = true
  }
  
  private func layoutMainButton() {
    view.addSubview(mainButton)
    mainButton.translatesAutoresizingMaskIntoConstraints = false
    mainButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor).isActive = true
    mainButton.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -21).isActive = true
    mainButton.widthAnchor.constraint(equalToConstant: mainBtnSize).isActive = true
    mainButton.heightAnchor.constraint(equalToConstant: mainBtnSize).isActive = true
  }
  
}
