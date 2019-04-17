//
//  PodView.swift
//  CaretCaster
//
//  Created by Daymein Gregorio on 2019/04/13.
//  Copyright © 2019 Daymein Gregorio. All rights reserved.
//

import UIKit

final class PodView: UIView {
  
  let fullSize = CGSize(width: UIScreen.main.bounds.width, height: 175)
  
  // UI elements
  var imageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.backgroundColor = .purple
    iv.layer.cornerRadius = 4
    iv.clipsToBounds = true
    return iv
  }()
  
  var titleLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = ThemeColors.mainText
    lbl.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    return lbl
  }()
  
  var subtitleLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = ThemeColors.subText
    lbl.font = UIFont.systemFont(ofSize: 12, weight: .light)
    return lbl
  }()
  
  var progressView: UIProgressView = {
    let pV = UIProgressView()
    pV.progressTintColor = ThemeColors.caret
    pV.trackTintColor = ThemeColors.mainText
    pV.progress = 0.5
    return pV
  }()

  func configure(for podcast: Podcast) {
    backgroundColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)
    titleLabel.text = podcast.title
    subtitleLabel.text = "15 minutes remaining"
    layoutComponentViews()
    
    guard let url = podcast.imageURL else { return }
    imageView.load(url: url)
  }
  
  private func loadPodcastImage(urlString: String) {
    
  }
  
  private func layoutComponentViews() {
    layoutImageView()
    layoutTitleLabel()
    layoutSubtitleLabel()
    layoutProgressView()
  }
  
}


// MARK: - layout views
extension PodView {
  
  private func layoutImageView() {
    self.addSubview(imageView)
    imageView.setAnchors(top: topAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 16, width: 60, height: 60)
//    imageView.translatesAutoresizingMaskIntoConstraints = false
//    imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
//    imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
//    imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
//    imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
  }
  
  private func layoutTitleLabel() {
    self.addSubview(titleLabel)
    titleLabel.setAnchors(top: imageView.topAnchor, left: imageView.rightAnchor, right: rightAnchor,
                          paddingTop: 8, paddingLeft: 12, paddingRight: 16)
//    titleLabel.translatesAutoresizingMaskIntoConstraints = false
//    titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8).isActive = true
//    titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 12).isActive = true
//    titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
  }
  
  private func layoutSubtitleLabel() {
    self.addSubview(subtitleLabel)
    subtitleLabel.setAnchors(left: titleLabel.leftAnchor, bottom: imageView.bottomAnchor, right: titleLabel.rightAnchor)
//    subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
//    subtitleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
//    subtitleLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
//    subtitleLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
  }
  
  private func layoutProgressView() {
    self.addSubview(progressView)
    progressView.setAnchors(top: imageView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10,
                            paddingLeft: 16, paddingRight: 16)
//    progressView.translatesAutoresizingMaskIntoConstraints = false
//    progressView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
//    progressView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
//    progressView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
  }
  
}
