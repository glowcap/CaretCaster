//
//  PodViewTests.swift
//  CaretCasterTests
//
//  Created by Daymein Gregorio on 5/11/19.
//  Copyright © 2019 Daymein Gregorio. All rights reserved.
//

import XCTest
@testable import CaretCaster

class PodViewTests: XCTestCase {
  
  var sut: PodView?
  
  override func setUp() {
    sut = PodView(frame: CGRect(x: 0, y: 0, width: sut?.fullSize.width ?? 0, height: sut?.fullSize.height ?? 0))
  }
  
  override func tearDown() {
    sut = nil
  }
  
  func test_configure() {
    guard let podcast = getModelFromJSON(model: Podcast.self, fileName: "Podcast") else { return XCTFail("Couldn't parse Podcast") }
    let expected = podcast.title
    sut?.configure(for: podcast)
    let result = sut?.titleLabel.text
    return XCTAssertEqual(expected, result, "Expected doesn't match result")
  }

  
}
