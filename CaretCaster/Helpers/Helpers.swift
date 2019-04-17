//
//  Helpers.swift
//  CaretCaster
//
//  Created by Daymein Gregorio on 2019/04/03.
//  Copyright © 2019 Daymein Gregorio. All rights reserved.
//

import UIKit

struct ThemeColors {
  static let mainText = #colorLiteral(red: 0.1764705882, green: 0.1764705882, blue: 0.1764705882, alpha: 1)  // #2D2D2D
  static let subText =  #colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1)  // #727272
  static let caret = #colorLiteral(red: 1, green: 0.5058823529, blue: 0, alpha: 1)  // #FF8100
}

func parse<T: Decodable>(jsonFile: String, modelType: T.Type) -> T? {
  guard let url = Bundle.main.url(forResource: jsonFile, withExtension: "json") else { return nil }
  let data = try? Data(contentsOf: url)
  let object = try? JSONDecoder().decode(T.self, from: data ?? Data())
  return object
}

struct WrapperType {
  static let wtInt = -1
  static let wtString = ""
  static let wtBool = false
}

extension KeyedDecodingContainer {
    
  public func wrapper<T: Decodable>(key: K, ofType: T? = nil) throws -> T? {
    if let value = try? decodeIfPresent(T.self, forKey: key) {
      return value
    }
    return nil
  }
  
}

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


