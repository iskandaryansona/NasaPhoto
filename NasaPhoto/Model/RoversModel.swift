//
//  RoversModel.swift
//  NasaPhoto
//
//  Created by Sona on 14.03.24.
//

import Foundation

struct RoverData: Codable {
    let photos: [Info]
}

struct Info: Codable, Hashable {
    
    let id, sol: Int
    let camera: Camera
    let imgSrc: String
    let earthDate: String
    let rover: Rover

    enum CodingKeys: String, CodingKey {
        case id, sol, camera
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case rover
    }
    
    static func == (lhs: Info, rhs: Info) -> Bool {
        return (lhs.id == rhs.id)
    }
    
}

struct Camera: Codable, Hashable {
    let id: Int
    let name: String
    let roverID: Int
    let fullName: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case roverID = "rover_id"
        case fullName = "full_name"
    }
}

struct Rover: Codable, Hashable {
    let id: Int
    let name, landingDate, launchDate, status: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case status
    }
}
