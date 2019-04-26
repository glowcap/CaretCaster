//
//  ListenModels.swift
//  CaretCaster
//
//  Created by Daymein Gregorio on 2019/04/02.
//  Copyright © 2019 Daymein Gregorio. All rights reserved.
//

import UIKit

struct Podcast: Decodable {
  let totalEpisodes: Int
  let description: String
  let title: String
  let publisher: String
  let itunesID: Int
  let language: String
  let country: String
  let id: String
  let isExplicit: Bool
  
  // these need formatting to set
  let imageURL: URL?
  let thumbnailURL: URL?
  let website: URL?
  let notesURL: URL?
  let rss: URL?
  
  enum CodingKeys: String, CodingKey {
    case totalEpisodes = "total_episodes"
    case image
    case website
    case notesURL = "listennotes_url"
    case description
    case title
    case rss
    case publisher
    case itunesID = "itunes_id"
    case language
    case country
    case id
    case thumbnail
    case isExplicit = "explicit_content"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    totalEpisodes = try container.wrapper(key: .totalEpisodes, ofType: WrapperType.wtInt) ?? 0
    description = try container.wrapper(key: .description, ofType: WrapperType.wtString) ?? ""
    title = try container.wrapper(key: .title, ofType: WrapperType.wtString) ?? ""
    publisher = try container.wrapper(key: .publisher, ofType: WrapperType.wtString) ?? ""
    itunesID = try container.wrapper(key: .itunesID, ofType: WrapperType.wtInt) ?? -1
    language = try container.wrapper(key: .language, ofType: WrapperType.wtString) ?? ""
    country = try container.wrapper(key: .country, ofType: WrapperType.wtString) ?? ""
    id = try container.wrapper(key: .id, ofType: WrapperType.wtString) ?? ""
    isExplicit = try container.wrapper(key: .isExplicit, ofType: WrapperType.wtBool) ?? true
    
    guard let imgStr = try container.wrapper(key: .image, ofType: WrapperType.wtString),
          let thbStr = try container.wrapper(key: .thumbnail, ofType: WrapperType.wtString),
          let webStr = try container.wrapper(key: .website, ofType: WrapperType.wtString),
          let noteStr = try container.wrapper(key: .notesURL, ofType: WrapperType.wtString),
          let rssStr = try container.wrapper(key: .rss, ofType: WrapperType.wtString)
      else {
        imageURL = URL(string: "")
        thumbnailURL = URL(string: "")
        website = URL(string: "")
        notesURL = URL(string: "")
        rss = URL(string: "")
        return
    }
    
    imageURL = URL(string: imgStr)
    thumbnailURL = URL(string: thbStr)
    website = URL(string: webStr)
    notesURL = URL(string: noteStr)
    rss = URL(string: rssStr)
  }
  
}

struct Genres: Decodable {
  var genres: [Genre]
  
  enum CodingKeys: String, CodingKey {
    case genres
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    genres = try container.wrapper(key: .genres) ?? [Genre]()
  }
  
}

struct Genre: Decodable {
  var id: Int
  var parentID: Int
  var name: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case parentID = "parent_id"
    case name
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.wrapper(key: .id, ofType: WrapperType.wtInt) ?? -2
    parentID = try container.wrapper(key: .parentID, ofType: WrapperType.wtInt) ?? -2
    name = try container.wrapper(key: .name, ofType: WrapperType.wtString) ?? "xyz"
  }
  
}

struct BestOfGenre: Decodable {
  var name: String
  var id: Int
  var parentID: Int
  var hasPrevious: Bool
  var pageNum: Int
  var prevPgNum: Int
  var hasNext: Bool
  var nextPgNum: Int
  var total: Int
  var podcasts: [Podcast]
  
  enum CodingKeys: String, CodingKey {
    case name
    case id
    case parentID = "parent_id"
    case hasPrevious = "has_previous"
    case pageNum = "page_number"
    case prevPgNum = "previous_page_number"
    case hasNext = "has_next"
    case nextPgNum = "next_page_number"
    case total
    case podcasts = "channels"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.wrapper(key: .name, ofType: WrapperType.wtString) ?? ""
    id = try container.wrapper(key: .id, ofType: WrapperType.wtInt) ?? -1
    parentID = try container.wrapper(key: .id, ofType: WrapperType.wtInt) ?? -1
    hasPrevious = try container.wrapper(key: .id, ofType: WrapperType.wtBool) ?? false
    pageNum = try container.wrapper(key: .id, ofType: WrapperType.wtInt) ?? -1
    prevPgNum = try container.wrapper(key: .id, ofType: WrapperType.wtInt) ?? -1
    hasNext = try container.wrapper(key: .id, ofType: WrapperType.wtBool) ?? false
    nextPgNum = try container.wrapper(key: .id, ofType: WrapperType.wtInt) ?? -1
    total = try container.wrapper(key: .id, ofType: WrapperType.wtInt) ?? 0
    podcasts = try container.wrapper(key: .podcasts) ?? [Podcast]()
  }
  
}


