//
//  Extensions.swift
//  CaretCaster
//
//  Created by Daymein Gregorio on 5/4/19.
//  Copyright © 2019 Daymein Gregorio. All rights reserved.
//

import UIKit

extension UIViewController {
  
  static private let spinnerTag = 7746
  
  func topMostViewController() -> UIViewController {
    if let presented = self.presentedViewController {
      return presented.topMostViewController()
    }
    if let navigation = self as? UINavigationController {
      return navigation.visibleViewController?.topMostViewController() ?? navigation
    }
    if let tab = self as? UITabBarController {
      return tab.selectedViewController?.topMostViewController() ?? tab
    }
    return self
  }
  
  func showSpinnerView() {
    let spinnerView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
    spinnerView.tag = UIViewController.spinnerTag
    spinnerView.backgroundColor = UIColor(white: 0, alpha: 0.45)
    let spinner = UIActivityIndicatorView(style: .whiteLarge)
    spinner.startAnimating()
    spinnerView.addSubview(spinner)
    spinner.translatesAutoresizingMaskIntoConstraints = false
    spinner.setAnchorsCenterToParent()
    let currentWindow = UIApplication.shared.keyWindow
    currentWindow?.addSubview(spinnerView)
  }
  
  func hideSpinnerView() {
    let currentWindow = UIApplication.shared.keyWindow
    guard let subviews = currentWindow?.subviews else { return }
    for view in subviews where view.tag == UIViewController.spinnerTag {
      view.removeFromSuperview()
    }
  }
  
}

// MARK: - UIImageView
let imageCache = NSCache<AnyObject, AnyObject>()
extension UIImageView {
  
  func load(url: URL) {
    if let cachedImage = imageCache.object(forKey: url as AnyObject) as? UIImage {
      self.image = cachedImage
      return
    }
    
    DispatchQueue.global().async { [weak self] in
      guard let data = try? Data(contentsOf: url),
        let image = UIImage(data: data)
        else { return }
      DispatchQueue.main.async {
        imageCache.setObject(image, forKey: url as AnyObject)
        self?.image = image
      }
    }
  }
  
}

// MARK: - Decoding
extension KeyedDecodingContainer {
  
  public func wrapper<T: Decodable>(key: K) throws -> T? {
    if let value = try? decodeIfPresent(T.self, forKey: key) {
      return value
    }
    return nil
  }
  
}

