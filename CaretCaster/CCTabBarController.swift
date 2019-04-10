//
//  CCTabBarController.swift
//  CaretCaster
//
//  Created by Daymein Gregorio on 2019/04/09.
//  Copyright © 2019 Daymein Gregorio. All rights reserved.
//

import UIKit

final class CCTabBarController: UITabBarController {

  let mainButton = UIButton()
  let mainBtnSize = CGFloat(UIScreen.main.bounds.width * 0.18)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureMainButton()
    layoutMainButton()
  }
  
  private func configureMainButton() {
    mainButton.backgroundColor = .purple
    mainButton.layer.cornerRadius = mainBtnSize / 2
    mainButton.clipsToBounds = true
  }
  
  private func layoutMainButton() {
    tabBar.addSubview(mainButton)
    mainButton.translatesAutoresizingMaskIntoConstraints = false
    mainButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor).isActive = true
    mainButton.centerYAnchor.constraint(equalTo: tabBar.centerYAnchor, constant: -20).isActive = true
    mainButton.widthAnchor.constraint(equalToConstant: mainBtnSize).isActive = true
    mainButton.heightAnchor.constraint(equalToConstant: mainBtnSize).isActive = true
  }
  
  
}
