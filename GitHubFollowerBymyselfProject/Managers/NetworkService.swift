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
