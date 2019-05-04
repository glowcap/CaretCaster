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
let screenHeight = UIScreen.main.bounds.height

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


