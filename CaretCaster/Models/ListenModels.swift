//
//  ListenModels.swift
//  CaretCaster
//
//  Created by Daymein Gregorio on 2019/04/02.
//  Copyright © 2019 Daymein Gregorio. All rights reserved.
//

import UIKit

struct Podcasts: Decodable {
  let podcasts: [Podcast]
}

struct Podcast: Decodable {
  let totalEpisodes: Int
  let description: String
  let title: String
  let publisher: String
  let iTunesID: Int
  let language: String
  let country: String
  let id: String
  let isExplicit: Bool
  let episodes: [Episode]
  let genreIDs: [Int]
  let latestPublishDate: Int // milliseconds since 1/1/70
  let nextPublishDate: Int // milliseconds since 1/1/70
  let earliestPublishDate: Int // milliseconds since 1/1/70
  
  // need formatting to set
  let imageURL: URL?
  let thumbnailURL: URL?
  let website: URL?
  let notesURL: URL?
  let rss: URL?
  
  // restored from CDPodcast (if available)
  var image: UIImage?
  var thumbnail: UIImage?
  
  enum CodingKeys: String, CodingKey {
    case totalEpisodes = "total_episodes"
    case image
    case website
    case notesURL = "listennotes_url"
    case description
    case title
    case rss
    case publisher
    case iTunesID = "itunes_id"
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
    iTunesID = try container.wrapper(key: .iTunesID) ?? -1
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
  
  init(cdPodcast: CDPodcast) {
    self.totalEpisodes = Int(cdPodcast.totalEpisodes)
    self.description = cdPodcast.desc ?? ""
    self.title = cdPodcast.title ?? ""
    self.publisher = cdPodcast.publisher ?? ""
    self.iTunesID = Int(cdPodcast.iTunesID)
    self.language = cdPodcast.language ?? "en_US"
    self.country = cdPodcast.country ?? "us"
    self.id = cdPodcast.id ?? ""
    self.isExplicit = cdPodcast.isExplicit
    self.genreIDs = cdPodcast.genreIDs ?? [Int]()
    self.latestPublishDate = Int(cdPodcast.latestPublishDate)
    self.nextPublishDate = Int(cdPodcast.nextPublishDate)
    self.earliestPublishDate = Int(cdPodcast.earliestPublishDate)
    self.imageURL = URL(string: cdPodcast.imageURL ?? "")
    self.thumbnailURL = URL(string: cdPodcast.thumbnailURL ?? "")
    self.website = URL(string: cdPodcast.websiteURLString ?? "")
    self.notesURL = URL(string: cdPodcast.notesURLString ?? "")
    self.rss = URL(string: cdPodcast.rssURLString ?? "")
    
    if let imgData = cdPodcast.image as Data? {
      self.image = UIImage(data: imgData)
    }
    
    if let thumbData = cdPodcast.thumbnail as Data? {
      self.thumbnail = UIImage(data: thumbData)
    }
    
    self.episodes = [Episode]()

  }
  
}

struct Episode: Decodable {
  let title: String
  let id: String
  let description: String
  let publishDate: Int // milliseconds since 1/1/70
  let length: Int
  let isExplicit: Bool
  let maybeInvalidAudio: Bool
  
  // need formatting to set
  let thumbnailURL: URL?
  let imageURL: URL?
  let audioURL: URL?
  
  // restored from CDEpisode (if available)
  var thumbnail: UIImage?
  var image: UIImage?
  var playedTime: Int?
  var savedAudioURL: Data?
  
  enum CodingKeys: String, CodingKey {
    case title
    case id
    case description
    case thumbnailURL = "thumbnail"
    case imageURL = "image"
    case audioURL = "audio"
    case publishDate = "pub_date_ms"
    case length = "audio_length"
    case isExplicit = "explicit_content"
    case maybeInvalidAudio = "maybe_audio_invalid"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
     title = try container.wrapper(key: .title) ?? ""
     id = try container.wrapper(key: .id) ?? ""
     description = try container.wrapper(key: .description) ?? ""
     publishDate = try container.wrapper(key: .publishDate) ?? 0
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
  
  static func == (lhs: Genre, rhs: Genre) -> Bool {
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
