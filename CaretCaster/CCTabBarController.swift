//
//  CCTabBarController.swift
//  CaretCaster
//
//  Created by Daymein Gregorio on 2019/04/09.
//  Copyright © 2019 Daymein Gregorio. All rights reserved.
//

import UIKit

protocol CCTabButtonDelegate: AnyObject {
  func tapped(isPlaying: Bool)
}

final class CCTabBarController: UITabBarController {

  let mainButton = UIButton()
  let mainBtnSize = CGFloat(UIScreen.main.bounds.width * 0.18)
  
  var buttonDelegate: CCTabButtonDelegate?
  var isPlaying = false {
    willSet {
      mainButton.backgroundColor = newValue ? .green : .red
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureMainButton()
    layoutMainButton()
  }
  
  private func configureMainButton() {
    mainButton.backgroundColor = .red
    mainButton.layer.cornerRadius = mainBtnSize / 2
    mainButton.clipsToBounds = true
    mainButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
  }
  
  private func layoutMainButton() {
    tabBar.addSubview(mainButton)
    mainButton.translatesAutoresizingMaskIntoConstraints = false
    mainButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor).isActive = true
    mainButton.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -21).isActive = true
    mainButton.widthAnchor.constraint(equalToConstant: mainBtnSize).isActive = true
    mainButton.heightAnchor.constraint(equalToConstant: mainBtnSize).isActive = true
  }
  
  @objc func tapped() {
    isPlaying = !isPlaying
    buttonDelegate?.tapped(isPlaying: isPlaying)
    print("button tapped - isPlaying: \(isPlaying)")
  }
  
}
