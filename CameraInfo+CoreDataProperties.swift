//
//  CameraInfo+CoreDataProperties.swift
//  NasaPhoto
//
//  Created by Sona on 18.03.24.
//
//

import Foundation
import CoreData

@objc(CameraInfo)
public class CameraInfo: NSManagedObject {}

extension CameraInfo {

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var roverID: Int16
    @NSManaged public var fullName: String?

}

extension CameraInfo : Identifiable {

}
