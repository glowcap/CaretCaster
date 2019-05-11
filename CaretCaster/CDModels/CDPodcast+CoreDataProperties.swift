//
//  CDPodcast+CoreDataProperties.swift
//  CaretCaster
//
//  Created by Daymein Gregorio on 5/7/19.
//  Copyright © 2019 Daymein Gregorio. All rights reserved.
//
//

import Foundation
import CoreData

extension CDPodcast {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPodcast> {
        return NSFetchRequest<CDPodcast>(entityName: "CDPodcast")
    }

    @NSManaged public var totalEpisodes: Int32
    @NSManaged public var desc: String?
    @NSManaged public var title: String?
    @NSManaged public var publisher: String?
    @NSManaged public var iTunesID: Int32
    @NSManaged public var language: String?
    @NSManaged public var country: String?
    @NSManaged public var id: String?
    @NSManaged public var isExplicit: Bool
    @NSManaged public var genreIDs: [Int]?
    @NSManaged public var latestPublishDate: Int64
    @NSManaged public var nextPublishDate: Int64
    @NSManaged public var earliestPublishDate: Int64
    @NSManaged public var image: NSData?
    @NSManaged public var thumbnail: NSData?
    @NSManaged public var websiteURLString: String?
    @NSManaged public var notesURLString: String?
    @NSManaged public var rssURLString: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var thumbnailURL: String?
    @NSManaged public var cdEpisodes: NSSet?

}

// MARK: Generated accessors for cdEpisodes
extension CDPodcast {

    @objc(addCdEpisodesObject:)
    @NSManaged public func addToCdEpisodes(_ value: CDEpisode)

    @objc(removeCdEpisodesObject:)
    @NSManaged public func removeFromCdEpisodes(_ value: CDEpisode)

    @objc(addCdEpisodes:)
    @NSManaged public func addToCdEpisodes(_ values: NSSet)

    @objc(removeCdEpisodes:)
    @NSManaged public func removeFromCdEpisodes(_ values: NSSet)

}
