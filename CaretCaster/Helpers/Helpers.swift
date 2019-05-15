//
//  Helpers.swift
//  CaretCaster
//
//  Created by Daymein Gregorio on 2019/04/03.
//  Copyright © 2019 Daymein Gregorio. All rights reserved.
//

import UIKit

struct ThemeColor {
  static let mainText = #colorLiteral(red: 0.1215686275, green: 0.1215686275, blue: 0.1215686275, alpha: 1)  // #1F1F1F
  static let subText =  #colorLiteral(red: 0.5960784314, green: 0.5960784314, blue: 0.5960784314, alpha: 1)  // #989898
  static let caret = #colorLiteral(red: 0.9176470588, green: 0.5294117647, blue: 0, alpha: 1)  // #EA8700
  static let stem = #colorLiteral(red: 0.5333333333, green: 0.7176470588, blue: 0.05882352941, alpha: 1)  // #88B70F
  static let baseBackground = #colorLiteral(red: 0.2117647059, green: 0.2117647059, blue: 0.2117647059, alpha: 1) // #363636
}

enum UserDefaultKey: String {
  case returningUser
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
