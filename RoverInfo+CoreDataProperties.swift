//
//  RoverInfo+CoreDataProperties.swift
//  NasaPhoto
//
//  Created by Sona on 18.03.24.
//
//

import Foundation
import CoreData


@objc(RoverInfo)
public class RoverInfo: NSManagedObject {}

extension RoverInfo {

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var landingDate: String?
    @NSManaged public var launchDate: String?
    @NSManaged public var status: String?

}

extension RoverInfo : Identifiable {

}
