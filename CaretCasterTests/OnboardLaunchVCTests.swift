//
//  OnboardLaunchVCTests.swift
//  CaretCasterTests
//
//  Created by Daymein Gregorio on 2019/04/02.
//  Copyright © 2019 Daymein Gregorio. All rights reserved.
//

import XCTest
@testable import CaretCaster

class OnboardLaunchVCTests: XCTestCase {
  
  var sut: OnboardLaunchViewController?
  
  override func setUp() {
    sut = OnboardLaunchViewController()
    _ = sut?.view
  }
  
  override func tearDown() {
    sut = nil
  }
  
  func test_configuredHeaderLabelText() {
    XCTAssertNotNil(sut?.headerLabel.attributedText)
  }
  
}
