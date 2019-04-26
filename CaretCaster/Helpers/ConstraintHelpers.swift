//
//  ConstraintHelpers.swift
//  CaretCaster
//
//  Created by Daymein Gregorio on 4/26/19.
//  Copyright © 2019 Daymein Gregorio. All rights reserved.
//

import UIKit

extension UIView {
  
  func setAnchors(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil,
                  bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil,
                  paddingTop: CGFloat = 0, paddingLeft: CGFloat = 0, paddingBottom: CGFloat = 0,
                  paddingRight: CGFloat = 0, width: CGFloat = 0, height: CGFloat = 0) {
    
    self.translatesAutoresizingMaskIntoConstraints = false
    
    if let top = top {
      self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
    }
    
    if let left = left {
      self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
    }
    
    if let bottom = bottom {
      self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
    }
    
    if let right = right {
      self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
    }
    
    if width != 0 {
      self.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    if height != 0 {
      self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
  }
  
  func setAnchorsCenterToParent(xConstant: CGFloat = 0, yConstant: CGFloat = 0) {
    setAnchorCenterXToParent(xConstant: xConstant)
    setAnchorCenterYToParent(yConstant: yConstant)
  }
  
  func setAnchorCenterXToParent(xConstant: CGFloat = 0) {
    guard let xAnchor = self.superview?.centerXAnchor else { return }
    self.translatesAutoresizingMaskIntoConstraints = false
    self.centerXAnchor.constraint(equalTo: xAnchor, constant: xConstant).isActive = true
  }
  
  func setAnchorCenterYToParent(yConstant: CGFloat = 0) {
    guard let yAnchor = self.superview?.centerYAnchor else { return }
    self.translatesAutoresizingMaskIntoConstraints = false
    self.centerYAnchor.constraint(equalTo: yAnchor, constant: yConstant).isActive = true
  }
  
  var safeTopAnchor: NSLayoutYAxisAnchor {
    if #available(iOS 11.0, *) { return safeAreaLayoutGuide.topAnchor }
    return topAnchor
  }
  
  var safeLeftAnchor: NSLayoutXAxisAnchor {
    if #available(iOS 11.0, *) { return safeAreaLayoutGuide.leftAnchor }
    return leftAnchor
  }
  
  var safeBottomAnchor: NSLayoutYAxisAnchor {
    if #available(iOS 11.0, *) { return safeAreaLayoutGuide.bottomAnchor }
    return bottomAnchor
  }
  
  var safeRightAnchor: NSLayoutXAxisAnchor {
    if #available(iOS 11.0, *) { return safeAreaLayoutGuide.rightAnchor }
    return rightAnchor
  }
  
}
