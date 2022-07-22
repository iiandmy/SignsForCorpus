//
// Created by IlyaCool on 22.07.22.
//

import Foundation
import Alamofire

protocol NetworkClientProtocol {
    typealias CityResponse = ([City]?, Error?) -> Void
    typealias SignResponse = ([Sign]?, Error?) -> Void
    typealias ImageResponse = (UIImage?, Error?) -> Void

    func fetchCities(completion: @escaping CityResponse)
    func fetchSigns(completion: @escaping SignResponse)
    func fetchImage(_ url: String, completion: @escaping ImageResponse)
}

final class NetworkClient: NetworkClientProtocol {
    static let shared = NetworkClient()
    private init() {}

    func fetchCities(completion: @escaping CityResponse) {
        let url = API.getUrl(forPath: .cities)
        AF.request(url)
            .validate()
            .responseDecodable(of: [CityDTO].self) { response in
                switch response.result {
                case .success(let city): completion(city.map { $0.toDomain() }, nil)
                case .failure(let error): completion(nil, error)
                }
            }
    }

    func fetchSigns(completion: @escaping SignResponse) {
        let url = API.getUrl(forPath: .signs)
        AF.request(url)
            .validate()
            .responseDecodable(of: [SignDTO].self) { response in
                switch response.result {
                case .success(let sign): completion(sign.map { $0.toDomain() }, nil)
                case .failure(let error): completion(nil, error)
                }
            }
    }
    
    func fetchImage(_ url: String, completion: @escaping ImageResponse) {
        guard let url = URL(string: url) else { return }
        AF.request(url)
            .validate()
            .responseData { data in
                if let error = data.error {
                    completion(nil, error)
                }
                guard let data = data.data else { return }
                
                completion(UIImage(data: data), nil)
            }
    }
}
