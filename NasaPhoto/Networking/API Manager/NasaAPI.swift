//
//  NasaAPI.swift
//  NasaPhoto
//
//  Created by Sona on 14.03.24.
//

import Foundation
import Combine


class NasaAPI {
    
    static let baseApi = "https://api.nasa.gov/mars-photos/api/v1/rovers"
    static let apiKey = "&api_key=uRn6aj1YCAndi9BiCSY0cVsDHPrbBgAWySv6nKwA"
    
    
    static let shared = NasaAPI()
    
    private init() {}
    
    
    func fetchData<ResponseType: Decodable>(type: RequestType, response: ResponseType.Type) -> AnyPublisher<ResponseType, Error> {
        
        return URLSession.shared.dataTaskPublisher(for: type.url)
               .tryMap { data, response -> ResponseType in
                   let decoder = JSONDecoder()
                   do {
                       return try decoder.decode(ResponseType.self, from: data)
                   } catch {
                       throw error
                   }
               }
               .receive(on: DispatchQueue.main)
               .eraseToAnyPublisher()
    }
}


enum RequestType {
    case getRoversData(Int)
    case filterByDate(Int, Date)
    case filterByCamera(Int, Date, String)
    
    private var stringValue: String {
        switch self {
        case .getRoversData(let page):
            return NasaAPI.baseApi + "/curiosity/photos?sol=1000&page=\(page)" + NasaAPI.apiKey
        case .filterByDate(let page, let date):
            return NasaAPI.baseApi + "/curiosity/photos?earth_date=\(date)&page=\(page)" + NasaAPI.apiKey
        case .filterByCamera(let page, let date, let camera):
            return NasaAPI.baseApi + "/curiosity/photos?earth_date=\(date)&camera=\(camera)&page=\(page)" + NasaAPI.apiKey
        }
    }
    
    var url: URL {
        if let url = URL(string: stringValue) {
            return url
        }
        return URL(fileURLWithPath: "")
    }
}
