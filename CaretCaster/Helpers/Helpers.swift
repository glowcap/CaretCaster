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
  static let caret = #colorLiteral(red: 0.9725490196, green: 0.5529411765, blue: 0.2862745098, alpha: 1)  // #F88D49
  static let stem = #colorLiteral(red: 0.5333333333, green: 0.7176470588, blue: 0.05882352941, alpha: 1)  // #88B70F
}

enum UserDefaultKey: String {
  case returningUser
  
  func value() -> String {
    switch self {
    case .returningUser: return "returningUser"
    }
  }
}

let screenWidth = UIScreen.main.bounds.width

func estimatedFrameFor(text: String, width: CGFloat, fontSize: CGFloat, fontWeight: UIFont.Weight) -> CGRect {
  let height = CGFloat(1000)
  let size = CGSize(width: width, height: height)
  let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
  let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize, weight: fontWeight)]
  
  return NSString(string: text).boundingRect(with: size, options: options,
                                             attributes: attributes, context: nil)
}

func parse<T: Decodable>(jsonFile: String, modelType: T.Type) -> T? {
  guard let url = Bundle.main.url(forResource: jsonFile, withExtension: "json") else { return nil }
  let data = try? Data(contentsOf: url)
  let object = try? JSONDecoder().decode(T.self, from: data ?? Data())
  return object
}

extension KeyedDecodingContainer {
  
  public func wrapper<T: Decodable>(key: K) throws -> T? {
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

final class NewPodsAlertLabel: UILabel {
  
  let padding = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
  
  override func drawText(in rect: CGRect) {
    super.drawText(in: rect.inset(by: padding))
  }
  
  override var intrinsicContentSize: CGSize {
    let superContentSize = super.intrinsicContentSize
    let width = superContentSize.width + padding.left + padding.right
    let height = superContentSize.height + padding.top + padding.bottom
    return CGSize(width: width, height: height)
  }
}


