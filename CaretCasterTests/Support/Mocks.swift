//
//  Mocks.swift
//  CaretCasterTests
//
//  Created by Daymein Gregorio on 5/11/19.
//  Copyright © 2019 Daymein Gregorio. All rights reserved.
//

import UIKit
@testable import CaretCaster

func getModelFromJSON<T: Decodable>(model: T.Type, fileName: String) -> T? {
  let bundle = Bundle(for: Mocks.self)
  
  guard let path = bundle.path(forResource: fileName, ofType: "json"),
    let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe),
    let jsonObj = try? JSONDecoder().decode(T.self, from: data)
    else { return nil }
  return jsonObj
}


class Mocks {
  
  
}

final class MockNavigationController: UINavigationController {
  
  var shownViewController: UIViewController?
  
  override func show(_ vc: UIViewController, sender: Any?) {
    shownViewController = vc
    super.show(vc, sender: sender)
  }
}
