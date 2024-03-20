//
//  PhotoInfo+CoreDataProperties.swift
//  NasaPhoto
//
//  Created by Sona on 18.03.24.
//
//

import Foundation
import CoreData

@objc(PhotoInfo)
public class PhotoInfo: NSManagedObject { }

extension PhotoInfo {

    @NSManaged public var id: Int16
    @NSManaged public var camera: NSObject?
    @NSManaged public var imgSrc: String?
    @NSManaged public var earthDate: String?
    @NSManaged public var rover: NSObject?

}

extension PhotoInfo : Identifiable {

}
