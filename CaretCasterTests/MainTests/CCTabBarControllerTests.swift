//
//  CCTabBarControllerTests.swift
//  CaretCasterTests
//
//  Created by Daymein Gregorio on 5/14/19.
//  Copyright © 2019 Daymein Gregorio. All rights reserved.
//

import XCTest
@testable import CaretCaster

class CCTabBarControllerTests: XCTestCase {
  
  var sut: CCTabBarController?
  
  override func setUp() {
    sut = CCTabBarController()
    guard let podcast = getModelFromJSON(model: Podcast.self, fileName: "Podcast")
      else { return XCTFail("load podcast json failed") }
    sut?.currentlyPlayingPodcast = podcast
    _ = sut?.view
  }
  
  override func tearDown() {
    sut = nil
  }
  
  func test_ViewDidLoad() {
    sut?.viewDidLoad()
    let expected = ThemeColor.stem
    let result = sut?.mainButton.backgroundColor
    XCTAssertEqual(expected, result, "button not set up")
  }
  
  func test_tapped() {
    sut?.tapped()
    XCTAssert(sut?.isPlaying ?? false, "not playing")
    sut?.tapped()
    XCTAssert(!(sut?.isPlaying ?? true), "is playing")
  }

}
