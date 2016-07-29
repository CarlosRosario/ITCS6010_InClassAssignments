//
//  UserNote+CoreDataProperties.swift
//  InClass08
//
//  Created by Carlos Rosario on 7/28/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension UserNote {

    @NSManaged var notetext: String?
    @NSManaged var created: NSDate?
    @NSManaged var owningUser: User?

}
