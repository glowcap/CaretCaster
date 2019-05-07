//
//  PersistanceManager.swift
//  CaretCaster
//
//  Created by Daymein Gregorio on 5/1/19.
//  Copyright © 2019 Daymein Gregorio. All rights reserved.
//

import Foundation
import CoreData

enum CoreDataError: Error {
  case fetchFailed
}

final class PersistanceManager {
  
  static let shared = PersistanceManager()
  
  private init() {}
  
  lazy var context = persistentContainer.viewContext

  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "CaretCaster")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  func save() {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
        print("saved successfully")
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
  
  func fetchAll<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
    let entityName = String(describing: objectType)
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    do {
      let fetchedObjects = try context.fetch(fetchRequest) as? [T]
      return fetchedObjects ?? [T]()
    } catch {
      print(CoreDataError.fetchFailed)
      return [T]()
    }
  }
  
  func saveGenreToCD(_ genre: Genre) {
    let g = CDGenre(context: PersistanceManager.shared.context)
    g.id = Int16(genre.id)
    g.parentID = Int32(genre.parentID)
    g.name = genre.name
    PersistanceManager.shared.save()
  }
  
  func savePodcastToCD(_ podcast: Podcast) {
    let p = CDPodcast(context: PersistanceManager.shared.context)
    p.totalEpisodes = Int32(podcast.totalEpisodes)
    p.desc = podcast.description
    p.title = podcast.title
    p.publisher = podcast.publisher
    p.iTunesID = Int32(podcast.iTunesID)
    p.language = podcast.language
    p.country = podcast.country
    p.id = podcast.id
    p.isExplicit = podcast.isExplicit
    p.genreIDs = podcast.genreIDs
    p.latestPublishDate = Int64(podcast.latestPublishDate)
    p.nextPublishDate = Int64(podcast.nextPublishDate)
    p.earliestPublishDate = Int64(podcast.earliestPublishDate)
  
    if let website = podcast.website {
      p.websiteURLString = String(describing: website)
    }
    
    if let notes = podcast.notesURL {
      p.notesURLString = String(describing: notes)
    }
    
    if let rss = podcast.rss {
       p.rssURLString = String(describing: rss)
    }
    
    if let imgURL = podcast.imageURL {
      p.imageURL = String(describing: imgURL)
    }
    
    if let thumbURL = podcast.thumbnailURL {
      p.thumbnailURL = String(describing: thumbURL)
    }
    
    if let image = podcast.image, let imgData = image.jpegData(compressionQuality: 0.8) as NSData? {
      p.image = imgData
    }
    
    if let thumb = podcast.thumbnail, let thumbData = thumb.jpegData(compressionQuality: 0.9) as NSData? {
      p.thumbnail = thumbData
    }
    
    let episodes = NSSet(array: [CDEpisode]())
    
    for ep in podcast.episodes {
      let e = populateCDEpisode(ep)
      episodes.adding(e)
    }
    p.cdEpisodes = episodes
    PersistanceManager.shared.save()
  }
  
  func saveEpisodeToCD(_ episode: Episode) {
    _ = populateCDEpisode(episode)
    
//    e.audio = episode.audio
    PersistanceManager.shared.save()
  }
  
  private func populateCDEpisode(_ episode: Episode) -> CDEpisode {
    let e = CDEpisode(context: PersistanceManager.shared.context)
    e.title = episode.title
    e.id = episode.id
    e.desc = episode.description
    
    e.publishDate = Int64(episode.publishDate)
    e.length = Int32(episode.length)
    e.isExplicit = episode.isExplicit
    e.maybeInvalidAudio = episode.maybeInvalidAudio
    e.playedTime = Int32(episode.playedTime ?? 0)
    
    if let audioURL = episode.audioURL {
      e.audioURL = String(describing: audioURL)
    }
    
    if let imageURL = episode.imageURL {
      e.imageURL = String(describing: imageURL)
    }
    
    if let thumbURL = episode.thumbnailURL {
      e.thumbnailURL = String(describing: thumbURL)
    }
    
    if let thumbnail = episode.thumbnail, let thumbData = thumbnail.jpegData(compressionQuality: 0.9) as NSData? {
      e.thumbnail = thumbData
    }
    
    if let img = episode.image, let imgData = img.jpegData(compressionQuality: 0.8) as NSData? {
      e.image = imgData
    }
    
    return e
  }
  
}
