//
//  DateOfMedicine+CoreDataProperties.swift
//  SD-var.-1
//
//  Created by Алёша Виноградов on 20.06.2022.
//
//

import Foundation
import CoreData


extension DateOfMedicine {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DateOfMedicine> {
        return NSFetchRequest<DateOfMedicine>(entityName: "DateOfMedicine")
    }
    
    @NSManaged public var insulin: String?
    @NSManaged public var date: Date?
    @NSManaged public var sugar: String?
    @NSManaged public var id: UUID?
    
    
    

}

extension DateOfMedicine : Identifiable {

}
