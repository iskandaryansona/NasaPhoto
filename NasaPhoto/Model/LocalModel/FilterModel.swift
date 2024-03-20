//
//  FilterModel.swift
//  NasaPhoto
//
//  Created by Sona on 20.03.24.
//

import Foundation

struct FilterModel: Equatable {
    var camera: String
    var rover: String
    var date: String
    var id: UUID
    
    static func ==(lhs: FilterModel, rhs: FilterModel) -> Bool {
        return lhs.camera == rhs.camera &&
               lhs.rover == rhs.rover &&
               lhs.date == rhs.date
    }
    
}
