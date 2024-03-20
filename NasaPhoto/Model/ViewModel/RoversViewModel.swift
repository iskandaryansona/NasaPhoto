//
//  ResponseViewModel.swift
//  NasaPhoto
//
//  Created by Sona on 20.03.24.
//

import Foundation
import Combine


final class RoversViewModel : ObservableObject {
    
    private var getRovers: RoverServiceProtocol
    
    var subscriber = Set<AnyCancellable>()
    
    @Published var roversList: [Info] = []
    
    init(service: RoverServiceProtocol = RoverRequest()) {
        self.getRovers = service
    }
}

extension RoversViewModel {
    
    func getRoversList(page: Int){
        self.getRovers.getRovers(page: page)
            .receive(on: DispatchQueue.main)
            .sink { data in
            } receiveValue: { [weak self] data in
                self?.roversList = data.photos
            }
            .store(in: &subscriber)
    }
    
}
