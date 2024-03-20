//
//  FilterModel.swift
//  NasaPhoto
//
//  Created by Sona on 16.03.24.
//

import Foundation

class FilterManager{
    
    static var shared: FilterManager = FilterManager()
    
    private init(){}
        
    var currentFilter: FilterModel = FilterModel(camera: "All", rover: "All", date: "2015-05-30", id: UUID())
    
    
    var requestType: RequestType = .filterByDate(0, Date())
    
    var isFilterOn: Bool = false
    
    var roversList: [Info] = []
}

enum FilterEn {
    case camera
    case rover
}
