//
//  HelperTests.swift
//  CaretCasterTests
//
//  Created by Daymein Gregorio on 5/12/19.
//  Copyright © 2019 Daymein Gregorio. All rights reserved.
//

import XCTest
@testable import CaretCaster

class HelperTests: XCTestCase {

  func test_estimatedFrame() {
    let result = estimatedFrameFor(text: "Some string here", width: screenWidth, fontSize: 16, fontWeight: .bold)
    XCTAssertEqual(result.origin.x, 0)
    XCTAssertEqual(result.origin.y, 0)
    XCTAssertTrue(Int(result.width) == 132)
    XCTAssertTrue(Int(result.height) == 19)
  }

}
