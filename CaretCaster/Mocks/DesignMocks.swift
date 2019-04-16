//
//  DesignMocks.swift
//  CaretCaster
//
//  Created by Daymein Gregorio on 2019/04/13.
//  Copyright © 2019 Daymein Gregorio. All rights reserved.
//

import Foundation

struct DesignMocks {
  
  
  static var podcast: Podcast? = {
    return parse(jsonFile: "Podcast", modelType: Podcast.self)
  }()
  
}
