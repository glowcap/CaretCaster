//
//  OnboardingGenreVCTests.swift
//  CaretCasterTests
//
//  Created by Daymein Gregorio on 5/11/19.
//  Copyright © 2019 Daymein Gregorio. All rights reserved.
//

import XCTest
@testable import CaretCaster

class OnboardingGenreVCTests: XCTestCase {
  
  var sut: OnboardGenreViewController?
  
  override func setUp() {
    sut = OnboardGenreViewController()
    let _ = sut?.view
    guard let genres = getModelFromJSON(model: Genres.self, fileName: "Genres") else { return XCTFail("Couldn't parse Genres") }
    sut?.allGenres = genres.genres
    sut?.tableView.reloadData()
  }
  
  override func tearDown() {
    sut = nil
  }
  
  func test_numberOfRowsInSection0() {
    guard let selectedSlice = sut?.allGenres.prefix(upTo: 5) else { return XCTFail("couldn't slice allGenres") }
    sut?.selectedGenres = Array(selectedSlice)
    sut?.tableView.reloadData()
    let expected = sut?.selectedGenres.count
    let result = sut?.tableView.numberOfRows(inSection: 0)
    XCTAssertEqual(expected, result, "result row count doesn't match expected")
  }
  
  func test_numberOfRowsInSection1() {
    let expected = sut?.allGenres.count
    let result = sut?.tableView.numberOfRows(inSection: 1)
    XCTAssertEqual(expected, result, "result row count doesn't match expected")
  }
  
  func test_nextTapped() {
    guard let vc = sut else { return XCTFail("sut is nil") }
    let navCon = MockNavigationController(rootViewController: vc)
    UIApplication.shared.keyWindow?.rootViewController = navCon
    vc.nextTapped()
    XCTAssertTrue(navCon.shownViewController is OnboardSubscribeViewController)
  }

}
