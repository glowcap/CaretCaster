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
  let episodes: [Episode]
  let genreIDs: [Int]
  let latestPublishDate: Int
  let nextPublishDate: Int
  let earliestPublishDate: Int
  
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
    case episodes
    case genreIDs = "genre_ids"
    case latestPublishDate = "lastest_pub_date_ms"
    case nextPublishDate = "next_episode_pub_date"
    case earliestPublishDate = "earliest_pub_date_ms"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    totalEpisodes = try container.wrapper(key: .totalEpisodes) ?? 0
    description = try container.wrapper(key: .description) ?? ""
    title = try container.wrapper(key: .title) ?? ""
    publisher = try container.wrapper(key: .publisher) ?? ""
    itunesID = try container.wrapper(key: .itunesID) ?? -1
    language = try container.wrapper(key: .language) ?? ""
    country = try container.wrapper(key: .country) ?? ""
    id = try container.wrapper(key: .id) ?? ""
    isExplicit = try container.wrapper(key: .isExplicit) ?? true
    episodes = try container.wrapper(key: .episodes) ?? [Episode]()
    genreIDs = try container.wrapper(key: .genreIDs) ?? [Int]()
    latestPublishDate = try container.wrapper(key: .latestPublishDate) ?? 0
    nextPublishDate = try container.wrapper(key: .nextPublishDate) ?? 0
    earliestPublishDate = try container.wrapper(key: .earliestPublishDate) ?? 0
    
    // get url strings
    let imgStr = try container.wrapper(key: .image) ?? ""
    let thbStr = try container.wrapper(key: .thumbnail) ?? ""
    let webStr = try container.wrapper(key: .website) ?? ""
    let noteStr = try container.wrapper(key: .notesURL) ?? ""
    let rssStr = try container.wrapper(key: .rss) ?? ""
    
    imageURL = URL(string: imgStr)
    thumbnailURL = URL(string: thbStr)
    website = URL(string: webStr)
    notesURL = URL(string: noteStr)
    rss = URL(string: rssStr)
  }
  
}

struct Episode: Decodable {
  var title: String
  var id: String
  var description: String
  var thumbnailURL: URL?
  var imageURL: URL?
  var audioURL: URL?
  var pubishDate: Int // milliseconds since 1/1/70
  var length: Int
  var isExplicit: Bool
  var maybeInvalidAudio: Bool
  
  enum CodingKeys: String, CodingKey {
    case title
    case id
    case description
    case thumbnailURL = "thumbnail"
    case imageURL = "image"
    case audioURL = "audio"
    case pubishDate = "pub_date_ms"
    case length = "audio_length"
    case isExplicit = "explicit_content"
    case maybeInvalidAudio = "maybe_audio_invalid"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
     title = try container.wrapper(key: .title) ?? ""
     id = try container.wrapper(key: .id) ?? ""
     description = try container.wrapper(key: .description) ?? ""
     pubishDate = try container.wrapper(key: .pubishDate) ?? 0
     length = try container.wrapper(key: .length) ?? 0
     isExplicit = try container.wrapper(key: .isExplicit) ?? true
     maybeInvalidAudio = try container.wrapper(key: .maybeInvalidAudio) ?? true
    
    // get url strings
    let thmbnlStr = try container.wrapper(key: .thumbnailURL) ?? ""
    let imgStr = try container.wrapper(key: .imageURL) ?? ""
    let adoStr = try container.wrapper(key: .audioURL) ?? ""
    
    thumbnailURL = URL(string: thmbnlStr)
    imageURL = URL(string: imgStr)
    audioURL = URL(string: adoStr)
  }
  
}

struct Genres: Decodable {
  var genres: [Genre]  
}

struct Genre: Decodable  {
  
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
    id = try container.wrapper(key: .id) ?? -2
    parentID = try container.wrapper(key: .parentID) ?? -2
    name = try container.wrapper(key: .name) ?? "xyz"
  }
  
  init(cdGenre: CDGenre) {
    self.id = Int(cdGenre.id)
    self.parentID = Int(cdGenre.parentID)
    self.name = cdGenre.name ?? ""
  }
  
}

extension Genre: Equatable, Comparable {
  
  static func ==(lhs: Genre, rhs: Genre) -> Bool {
    return lhs.name == rhs.name
  }
  
  static func < (lhs: Genre, rhs: Genre) -> Bool {
    return lhs.name < rhs.name
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
    name = try container.wrapper(key: .name) ?? ""
    id = try container.wrapper(key: .id) ?? -1
    parentID = try container.wrapper(key: .id) ?? -1
    hasPrevious = try container.wrapper(key: .id) ?? false
    pageNum = try container.wrapper(key: .id) ?? -1
    prevPgNum = try container.wrapper(key: .id) ?? -1
    hasNext = try container.wrapper(key: .id) ?? false
    nextPgNum = try container.wrapper(key: .id) ?? -1
    total = try container.wrapper(key: .id) ?? 0
    podcasts = try container.wrapper(key: .podcasts) ?? [Podcast]()
  }
  
}


