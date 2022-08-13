//
//  Country+CoreDataProperties.swift
//  BasicCoreData
//
//  Created by David Molina on 12/08/22.
//
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var name: String?

}

extension Country : Identifiable {

}
