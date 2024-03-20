//
//  FilterModel + CoreDataProperties.swift
//  NasaPhoto
//
//  Created by Sona on 19.03.24.
//

import Foundation
import CoreData

@objc(FilterInfo)
public class FilterInfo: NSManagedObject { }

extension FilterInfo {

    @NSManaged public var id: UUID
    @NSManaged public var camera: String
    @NSManaged public var rover: String
    @NSManaged public var date: String

}

extension FilterInfo : Identifiable {}
