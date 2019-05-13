//
//  OnboardingSubscribeVCTests.swift
//  CaretCasterTests
//
//  Created by Daymein Gregorio on 5/12/19.
//  Copyright © 2019 Daymein Gregorio. All rights reserved.
//

import XCTest
@testable import CaretCaster

class OnboardingSubscribeVCTests: XCTestCase {
  
  var sut: OnboardSubscribeViewController?
  
  override func setUp() {
    sut = OnboardSubscribeViewController()
    _ = sut?.view
    guard let bestOfPodcasts = getModelFromJSON(model: BestOfGenre.self, fileName: "BestPodcasts"),
          let genre = getModelFromJSON(model: Genre.self, fileName: "Genre")
      else { return XCTFail("couldn't parse files") }
    sut?.bestOfPodcasts.append(bestOfPodcasts.podcasts)
    sut?.selectedGenres.append(genre)
    sut?.collectionView.reloadData()
  }
  
  override func tearDown() {
    sut = nil
  }
  
  func test_nextTapped() {
    guard let bestOfPodcasts = getModelFromJSON(model: BestOfGenre.self, fileName: "BestPodcasts"),
          let genre = getModelFromJSON(model: Genre.self, fileName: "Genre")
      else { return XCTFail("couldn't parse files") }
    let mockSut = MockOnboardSubscribeViewController()
    mockSut.bestOfPodcasts.append(bestOfPodcasts.podcasts)
    mockSut.subscribedPodcasts = bestOfPodcasts.podcasts
    mockSut.selectedGenres.append(genre)
    mockSut.collectionView.reloadData()
    mockSut.nextTapped()
    XCTAssert(mockSut.viewControllerToPresented is UITabBarController, "incorrect viewController shown")
  }
  
  func test_numberOfSections() {
    let expected = 1
    let result = sut?.collectionView.numberOfSections
    XCTAssertEqual(expected, result, "incorrect section count")
  }
  
}

class MockOnboardSubscribeViewController: OnboardSubscribeViewController {
  
  var viewControllerToPresented: UIViewController?
  
  override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
    viewControllerToPresented = viewControllerToPresent
    super.present(viewControllerToPresent, animated: flag, completion: completion)
  }
  
}
