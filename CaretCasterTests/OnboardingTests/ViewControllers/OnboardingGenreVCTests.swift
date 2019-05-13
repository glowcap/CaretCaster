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
    _ = sut?.view
    guard let genres = getModelFromJSON(model: Genres.self, fileName: "Genres") else { return XCTFail("Couldn't parse Genres") }
    sut?.allGenres = genres.genres
    sut?.tableView.reloadData()
  }
  
  override func tearDown() {
    sut = nil
  }
  
  func test_nextTapped() {
    guard let vc = sut else { return XCTFail("sut is nil") }
    let navCon = MockNavigationController(rootViewController: vc)
    UIApplication.shared.keyWindow?.rootViewController = navCon
    vc.nextTapped()
    XCTAssertTrue(navCon.shownViewController is OnboardSubscribeViewController)
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
  
  func test_cellForRowInSection0() {
    guard let selectedSlice = sut?.allGenres.prefix(upTo: 5) else { return XCTFail("couldn't slice allGenres") }
    sut?.selectedGenres = Array(selectedSlice)
    sut?.tableView.reloadData()
    guard let expected = sut?.selectedGenres.first?.name,
          let tv = sut?.tableView
      else { return XCTFail("couldn't prep test") }
    let cell = sut?.tableView(tv, cellForRowAt: IndexPath(row: 0, section: 0))
    let result = cell?.textLabel?.text
    XCTAssertEqual(expected, result, "genre name didn't match")
  }
  
  func test_cellForRowInSection1() {
    guard let expected = sut?.allGenres.first?.name,
          let tv = sut?.tableView
      else { return XCTFail("couldn't prep test") }
    let cell = sut?.tableView(tv, cellForRowAt: IndexPath(row: 0, section: 1))
    let result = cell?.textLabel?.text
    XCTAssertEqual(expected, result, "genre name didn't match")
  }
  
  func test_didTapRowInSection1() {
    guard let expectedGenre = sut?.allGenres.first?.name,
      let tv = sut?.tableView
      else { return XCTFail("couldn't prep test") }
    let indexPath = IndexPath(row: 0, section: 1)
    sut?.tableView(tv, didSelectRowAt: indexPath)
    guard let resultGenre = sut?.selectedGenres.first?.name else { return XCTFail("didn't selected cell") }
    XCTAssertEqual(expectedGenre, resultGenre, "genre didn't match")
    let cell = sut?.tableView(tv, cellForRowAt: indexPath)
    XCTAssertTrue(cell?.accessoryType == .checkmark, "checkmark missing from selected")
  }
  
  func test_didTapRowInSection0() {
    guard let tv = sut?.tableView
      else { return XCTFail("couldn't prep test") }
    sut?.tableView(tv, didSelectRowAt: IndexPath(row: 0, section: 1))
    sut?.tableView(tv, didSelectRowAt: IndexPath(row: 0, section: 0))
    XCTAssertTrue(sut?.selectedGenres.isEmpty ?? false, "didn't remove selectedGenre item")
    let numberOfRowsInSec0 = sut?.tableView(tv, numberOfRowsInSection: 0)
    XCTAssertTrue(numberOfRowsInSec0 == 0, "didn't remove row")
  }
  
}
