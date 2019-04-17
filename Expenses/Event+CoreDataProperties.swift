//
//  Event+CoreDataProperties.swift
//  Expenses
//
//  Created by Carmel Braga on 4/16/19.
//  Copyright © 2019 Tech Innovator. All rights reserved.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var eventName: String?
    @NSManaged public var eventLocation: String?
    @NSManaged public var eventDate: NSDate?

}
