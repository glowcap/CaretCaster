//
//  Helpers.swift
//  CaretCaster
//
//  Created by Daymein Gregorio on 2019/04/03.
//  Copyright © 2019 Daymein Gregorio. All rights reserved.
//

import Foundation

struct WrapperType {
  static let wtInt = -1
  static let wtString = ""
  static let wtBool = false
}

extension KeyedDecodingContainer {
  
  func wrapper<T>(key: K, ofType: T? = nil) throws -> T? where T: Decodable {
    if let value = try? decodeIfPresent(T.self, forKey: key) {
      return value
    }
    return nil
  }
  
}
