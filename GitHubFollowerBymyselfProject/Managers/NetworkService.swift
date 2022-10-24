//
//  Network.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2021/06/24.
//

import Combine
import UIKit

protocol NetworkServiceProtocol {
    func fetchFollowerList(of userName: String) -> AnyPublisher<[Follower], GFError>
    func fetchFollowerDetail(of userName: String) -> AnyPublisher<FollowerDetailInformation, GFError>
}

final class ProfileImageLoader {
    static let shared = ProfileImageLoader()
    
    private let cache = NSCache<NSString, UIImage>()
    
    func loadImage(from urlString: String) -> AnyPublisher<UIImage, GFError> {
        let cacheKey = NSString(string: urlString)

        if let image = cache.object(forKey: cacheKey) {
            return Just<UIImage>(image).setFailureType(to: GFError.self).eraseToAnyPublisher()
        }

        guard let url = URL(string: urlString) else {
            return Fail(error: .error).eraseToAnyPublisher()
        }

        return URLSession.shared
            .dataTaskPublisher(for: url)
            .mapError({error -> GFError in
                    .error
            })
            .map({$0.data})
            .compactMap { UIImage(data: $0) ?? UIImage() }
            .map({ [weak self] in
                self?.cache.setObject($0, forKey: cacheKey)
                return $0
            })
            .eraseToAnyPublisher()
    }
}

final class NetworkService: NetworkServiceProtocol {
    func fetchFollowerList(of userName: String) -> AnyPublisher<[Follower], GFError> {
        return Future { promise in
            guard let url = URL(string: "http://api.github.com/users/\(userName)/followers?per_page=100") else {
                promise(.failure(.wrongUrl))
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data else {
                    if let _ = error {
                        promise(.failure(.sameDataAlreadyExist))
                    }
                    return
                }
                
                do {
                    let decode = JSONDecoder()
                    let followers = try decode.decode([Follower].self, from: data)
                    promise(.success(followers))
                } catch {
                    promise(.failure(.sameDataAlreadyExist))
                }
            }.resume()
        }
        .eraseToAnyPublisher()
    }
    
    func fetchFollowerDetail(of userName: String) -> AnyPublisher<FollowerDetailInformation, GFError> {
        return Future<FollowerDetailInformation, GFError> { promise in
            guard let url = URL(string: "http://api.github.com/users/\(userName)") else {
                promise(.failure(.wrongUrl))
                return
            }
            
            URLSession.shared.dataTask(with: url) { (data, _ , error) in
                guard let data = data else {
                    if let _ = error {
                        promise(.failure(.sameDataAlreadyExist))
                    }
                    return
                }
                do {
                    let decode = JSONDecoder()
                    decode.keyDecodingStrategy = .convertFromSnakeCase
                    let followers = try decode.decode(FollowerDetailInformation.self, from: data)
                    promise(.success(followers))
                } catch {
                    promise(.failure(.cannotDecode))
                }
            }.resume()
            
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
