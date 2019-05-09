//
//  OnboardLaunchViewController.swift
//  CaretCaster
//
//  Created by Daymein Gregorio on 4/26/19.
//  Copyright © 2019 Daymein Gregorio. All rights reserved.
//

import UIKit

class OnboardLaunchViewController: UIViewController {
  
  let headerText = "Welcome to\n\nCaret Caster\n\nThe best way to enjoy your favorite podcasts on the go!"
  
  var headerLabel: UILabel = {
    let lbl = UILabel()
    lbl.numberOfLines = 0
    lbl.lineBreakMode = .byWordWrapping
    lbl.text = "Sample text here"
    return lbl
  }()
  
  var splashImage: UIImageView = {
    let iV = UIImageView()
    iV.backgroundColor = .darkGray
    iV.contentMode = .scaleAspectFill
    return iV
  }()
  
  var getStartedBtn: UIButton = {
    let btn = UIButton()
    btn.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    btn.setTitle("Let's get started", for: .normal)
    btn.setTitleColor(.white, for: .normal)
    btn.backgroundColor = ThemeColor.mainText
    btn.layer.cornerRadius = 8
    btn.clipsToBounds = true
    return btn
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    headerLabel.attributedText = configuredHeaderLabelText(headerText)
    layoutHeaderLabel()
    layoutSplashImage()
    layoutGetStartedBtn()
    getStartedBtn.addTarget(self, action: #selector(getStartedTapped), for: .touchUpInside)
  }
  
  private func configuredHeaderLabelText(_ text: String) -> NSMutableAttributedString {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .center
    let rText = NSString(string: text)
    let range = rText.range(of: "Caret Caster")
    let attributedString = NSMutableAttributedString(string: text,
                                                     attributes: [.paragraphStyle: paragraphStyle,
                                                                  .font: UIFont.systemFont(ofSize: 16),
                                                                  .foregroundColor: ThemeColor.mainText])
    attributedString.addAttributes([.foregroundColor: ThemeColor.caret, .font: UIFont.systemFont(ofSize: 32, weight: .semibold)],
                                   range: range)
    return attributedString
  }
  
  @objc func getStartedTapped() {
    let genreVC = OnboardGenreViewController()
    let navCon = UINavigationController(rootViewController: genreVC)
    show(navCon, sender: self)
  }
  
}

// MARK: - Layout component view functions

extension OnboardLaunchViewController {
  
  private func layoutHeaderLabel() {
    view.addSubview(headerLabel)
    headerLabel.setAnchors(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor,
                           paddingTop: 60, paddingLeft: 40, paddingRight: 40)
  }
  
  private func layoutSplashImage() {
    view.addSubview(splashImage)
    splashImage.setAnchors(width: screenWidth - 80, height: screenWidth - 80)
    splashImage.setAnchorsCenterToParent()
  }
  
  private func layoutGetStartedBtn() {
    view.addSubview(getStartedBtn)
    getStartedBtn.setAnchors(bottom: view.bottomAnchor, paddingBottom: -70, width: 200, height: 60)
    getStartedBtn.setAnchorCenterXToParent()
  }
  
}
