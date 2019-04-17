//
//  Event+CoreDataClass.swift
//  Expenses
//
//  Created by Carmel Braga on 4/16/19.
//  Copyright © 2019 Tech Innovator. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Event)
public class Event: NSManagedObject {
    var date: Date?{
        get{
            return eventDate as Date?
        }
        set{
            eventDate = newValue as NSDate?
        }
        
    }
    
    convenience init?(eventName: String?, eventLocation: String?, date: Date?){
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{
            return nil
        }
        
        self.init(entity: Event.entity(), insertInto: managedContext)
        
        self.eventName = eventName
        self.eventLocation = eventLocation
        self.date = date
        
    }
    
}

