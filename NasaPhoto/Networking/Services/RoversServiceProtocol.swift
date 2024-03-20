//
//  RoversServiceProtocol.swift
//  NasaPhoto
//
//  Created by Sona on 20.03.24.
//

import Foundation
import Combine

protocol RoverServiceProtocol: AnyObject {
    func getRovers(page: Int) ->  AnyPublisher<RoverData, Error>
    func getFiltersRovers(type: RequestType) -> AnyPublisher<RoverData, Error>
}

final class RoverRequest: RoverServiceProtocol, ObservableObject {
    
    func getRovers(page: Int) -> AnyPublisher<RoverData, Error> {
        return NasaAPI.shared.fetchData(type: .getRoversData(page), response: RoverData.self).compactMap { $0 }.eraseToAnyPublisher()
    }
    
    func getFiltersRovers(type: RequestType) -> AnyPublisher<RoverData, Error> {
        return NasaAPI.shared.fetchData(type: type, response: RoverData.self).compactMap { $0 }.eraseToAnyPublisher()
    }
}
