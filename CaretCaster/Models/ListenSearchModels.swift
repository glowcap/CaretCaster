//
//  ListenSearchModels.swift
//  CaretCaster
//
//  Created by Daymein Gregorio on 2019/04/07.
//  Copyright © 2019 Daymein Gregorio. All rights reserved.
//

import Foundation

struct SearchPodcastModel: Decodable {
  let titleOriginal: String
  let isExplicit: Bool
  let id: String
  let publisherOriginal: String
  
  // these need formatting to set
  let titleHighlighted: NSAttributedString
  let publisherHighlighted: NSAttributedString
  let thumbnailURL: URL?
  let imageURL: URL?
  
  enum CodingKeys: String, CodingKey {
    case titleOriginal = "title_original"
    case isExplicit = "explicit_content"
    case id
    case titleHighlighted = "title_highlighted"
    case publisherOriginal = "publisher_original"
    case publisherHighlighted = "publisher_highlighted"
    case thumbnailURL = "thumbnail"
    case imageURL = "image"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    titleOriginal = try container.wrapper(key: .titleOriginal, ofType: WrapperType.wtString) ?? ""
    isExplicit = try container.wrapper(key: .isExplicit, ofType: WrapperType.wtBool) ?? true
    id = try container.wrapper(key: .id, ofType: WrapperType.wtString) ?? ""
    publisherOriginal = try container.wrapper(key: .publisherOriginal, ofType: WrapperType.wtString) ?? ""
    
    guard let titleHighlightedStr = try container.wrapper(key: .titleHighlighted, ofType: WrapperType.wtString),
          let publisherHighlightedStr = try container.wrapper(key: .publisherHighlighted, ofType: WrapperType.wtString),
          let thumbnailStr = try container.wrapper(key: .thumbnailURL, ofType: WrapperType.wtString),
          let imageStr = try container.wrapper(key: .imageURL, ofType: WrapperType.wtString)
      else {
        titleHighlighted = NSAttributedString(string: "")
        publisherHighlighted = NSAttributedString(string: "")
        thumbnailURL = URL(string: "")
        imageURL = URL(string: "")
        return
    }
    titleHighlighted = NSAttributedString(string: titleHighlightedStr)
    publisherHighlighted = NSAttributedString(string: publisherHighlightedStr)
    thumbnailURL = URL(string: thumbnailStr)
    imageURL = URL(string: imageStr)
  }
  
}

struct TypeHeadSearch: Decodable {
  var terms = [String]()
  var podcasts = [SearchPodcastModel]()
  var genres = [Genres]()
  
  enum CodingKeys: String, CodingKey {
    case terms
    case podcasts
    case genres
  }
  
}
