//
//  CDGenre+CoreDataProperties.swift
//  CaretCaster
//
//  Created by Daymein Gregorio on 5/1/19.
//  Copyright © 2019 Daymein Gregorio. All rights reserved.
//
//

import Foundation
import CoreData

extension CDGenre {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDGenre> {
        return NSFetchRequest<CDGenre>(entityName: "CDGenre")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var parentID: Int32

}
