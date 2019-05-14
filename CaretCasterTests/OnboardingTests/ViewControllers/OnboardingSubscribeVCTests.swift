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
  
  func test_setCollectionViewData() {
    guard let bestOfPods = getModelFromJSON(model: BestOfGenre.self, fileName: "BestPodcasts")
      else { return XCTFail("couldn't parse bestOf") }
    sut?.bestOfPodcasts = [[Podcast]]()
    sut?.setCollectionViewData(with: bestOfPods)
    guard let bestOfCount = sut?.bestOfPodcasts.count else { return XCTFail("couldn't get bestOf count") }
    XCTAssert(bestOfCount > 0, "didn't set bestOfs")
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
  
  func test_cellForRow() {
    guard let cV = sut?.collectionView else { return XCTFail("collectionView not found") }
    let cell = sut?.collectionView(cV, cellForItemAt: IndexPath(item: 0, section: 0))
    XCTAssert(cell is OnboardingPodcastCell, "incorrect cell returned")
  }
  
  func test_didSelectedRowSubscribed() {
    guard let cV = sut?.collectionView else { return XCTFail("collectionView not found") }
    sut?.collectionView(cV, didSelectItemAt: IndexPath(item: 0, section: 0))
    let result = sut?.subscribedPodcasts.count
    XCTAssertEqual(result, 1, "didn't sub to podcast")
  }
  
  func test_didSelectedRowUnsubscribed() {
    guard let cV = sut?.collectionView else { return XCTFail("collectionView not found") }
    sut?.collectionView(cV, didSelectItemAt: IndexPath(item: 0, section: 0))
    sut?.collectionView(cV, didSelectItemAt: IndexPath(item: 0, section: 0))
    let result = sut?.subscribedPodcasts.count
    XCTAssertEqual(result, 0, "didn't unsub from podcast")
    
  }
  
}

class MockOnboardSubscribeViewController: OnboardSubscribeViewController {
  
  var viewControllerToPresented: UIViewController?
  
  override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
    viewControllerToPresented = viewControllerToPresent
    super.present(viewControllerToPresent, animated: flag, completion: completion)
  }
  
}
