//
//  NetworkManagerTests.swift
//  CaretCasterTests
//
//  Created by Daymein Gregorio on 5/12/19.
//  Copyright © 2019 Daymein Gregorio. All rights reserved.
//

import XCTest
@testable import CaretCaster

class NetworkManagerTests: XCTestCase {
  
  let sut = NetworkManager.shared
  
  func test_generateGenresURL() {
    let expected = URL(string: "https://listen-api.listennotes.com/api/v2/genres")
    let result = sut.generateGenresURL()
    XCTAssertEqual(expected, result, "url doesn't match")
  }
  
  func test_generateBestOfURL() {
    let expected = URL(string: "https://listen-api.listennotes.com/api/v2/best_podcasts?genre_id=123&page=0&region=jp&safe_mode=0")
    let result = sut.generateBestOfURL(genreId: 123, page: 0, region: "jp", isSafeMode: false)
    XCTAssertEqual(expected, result, "url doesn't match")
  }
  
  func test_generatePodcastsURL() {
    let expected = URL(string: "https://listen-api.listennotes.com/api/v2/podcasts?ids=9d6939745ed34e3aab0eb78a408ab40d")
    let result = sut.generatePodcastsURL(podcastIDs: ["9d6939745ed34e3aab0eb78a408ab40d"])
    XCTAssertEqual(expected, result, "url doesn't match")
  }
  
  func test_parseData() {
    guard let file = Bundle(for: NetworkManagerTests.self).url(forResource: "Podcast", withExtension: "json"),
          let data = try? Data(contentsOf: file)
      else { return XCTFail("couldn't get file") }
    guard let _: Podcast = sut.parse(data: data, modelType: ParsingType.podcast)
      else { return XCTFail("parse failed") }
    XCTAssert(true, "not parsed correctly")
  }
  
  func test_fire() {
    let mock = MockNetworkManager.shared
    guard let url = URL(string: "https://listen-api.listennotes.com/api/v2/genres") else { return XCTFail("bad URL") }
    mock.fire(request: url) { (data, _, _) in
      XCTAssertNotNil(data, "called data")
    }
  }
  
}

class MockNetworkManager: NetworkManager {
  
  override func fire(request: URL, completion: @escaping NetworkManager.Handler) {
    guard let file = Bundle(for: NetworkManagerTests.self).url(forResource: "Podcast", withExtension: "json"),
      let data = try? Data(contentsOf: file)
      else { return completion(nil, nil, nil) }
    completion(data, nil, nil)
  }
}
