//
//  CDEpisode+CoreDataProperties.swift
//  CaretCaster
//
//  Created by Daymein Gregorio on 5/5/19.
//  Copyright © 2019 Daymein Gregorio. All rights reserved.
//
//

import Foundation
import CoreData


extension CDEpisode {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDEpisode> {
        return NSFetchRequest<CDEpisode>(entityName: "CDEpisode")
    }

    @NSManaged public var title: String?
    @NSManaged public var id: String?
    @NSManaged public var desc: String?
    @NSManaged public var image: NSData?
    @NSManaged public var audio: NSData?
    @NSManaged public var publishDate: Int64
    @NSManaged public var length: Int32
    @NSManaged public var isExplicit: Bool
    @NSManaged public var maybeInvalidAudio: Bool
    @NSManaged public var playedTime: Int32
    @NSManaged public var audioURL: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var thumbnailURL: String?
    @NSManaged public var thumbnail: NSData?
    @NSManaged public var cdPodcast: CDPodcast?

}
