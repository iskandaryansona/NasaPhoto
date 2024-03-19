//
//  LocalData.swift
//  NasaPhoto
//
//  Created by Sona on 18.03.24.
//

import Foundation

class LocalData {
    
    static var cameraName: [String : String] = [
        "All" : "All",
        "fhaz" : "Front Hazard Avoidance Camera",
        "rhaz" : "Rear Hazard Avoidance Camera",
        "mast" : "Mast Camera",
        "chemcam" : "Chemistry and Camera Complex",
        "mahli" : "Mars Hand Lens Imager",
        "mardi" : "Mars Descent Imager",
        "navcam" : "Navigation Camera",
        "pancam" : "Panoramic Camera",
        "minites" : "Miniature Thermal Emission Spectrometer (Mini-TES)"
    ]
    
    static var roverName: [String] = ["All",
                                      "Curiosity",
                                      "Opportunity",
                                      "Spirit"]
}

extension Dictionary where  Key: Equatable {
    func keys(forValue value: Key) -> [Value] {
        return self.compactMap { (key, val) -> Value? in
            if key == value{
                return val
            }
            return nil
        }
    }
}
