//
//  Networking.swift
//  CaretCaster
//
//  Created by Daymein Gregorio on 2019/04/03.
//  Copyright © 2019 Daymein Gregorio. All rights reserved.
//

import Foundation

enum ParsingType: Int {
  case genre
  case genres
  case bestOf
}

struct Networking {
  
  enum CCError: Error {
    case dataFailure
  }
  
  struct Path {
    static let genres = "/genres"
    static let bestOf = "/best_podcasts"
  }
  
  struct QueryKey {
    static let genreID = "genre_id"
    static let page = "page"
    static let region = "region"
    static let safeMode = "safe_mode"
  }
  
  private var urlComponents = URLComponents()
  
  init() {
    urlComponents.scheme = "https"
    urlComponents.host = "listen-api.listennotes.com"
    urlComponents.path = "/api/v2"
  }
  
  func generateGenresURL() -> URL? {
    var base = urlComponents
    base.path += Path.genres
    return base.url
  }
  
  func generateBestOfURL(genreId: Int, page: Int = 0, region: String, isSafeMode: Bool) -> URL? {
    var base = urlComponents
    base.path += Path.bestOf
    let genID = URLQueryItem(name: QueryKey.genreID, value: String(genreId))
    let pg = URLQueryItem(name: QueryKey.page, value: String(page))
    let rgn = URLQueryItem(name: QueryKey.region, value: region.lowercased())
    let sfmd = URLQueryItem(name: QueryKey.safeMode, value: String(isSafeMode ? 1 : 0))
    base.queryItems = [genID, pg, rgn, sfmd]
    return base.url
  }
  
  func parse<T>(data: Data, modelType: ParsingType) -> T? {
    let decoder = JSONDecoder()
    var model: T?
    switch modelType {
    case .genre:
      if let m = try? decoder.decode(Genre.self, from: data) {
              model = m as? T
      }
    case .genres:
      if let m = try? decoder.decode(Genres.self, from: data) {
        model = m as? T
      }
    case .bestOf:
      if let m = try? decoder.decode(BestOfGenre.self, from: data) {
        model = m as? T
      }
    }
    return model
  }
  
  func fire(request: URL, completion: @escaping (Data?, Error?)->()) {
    let session = URLSession.shared
    var request = URLRequest(url: request)
    request.setValue(Keys.listenAPI.value, forHTTPHeaderField: Keys.listenAPI.key)
    
    session.dataTask(with: request) { data, response, error in
      guard error == nil else {
        print(error.debugDescription)
        return
      }
      if let data = data {
        completion(data, nil)
      } else {
        completion(nil, CCError.dataFailure)
      }
      
    }.resume()
  }
  
}

