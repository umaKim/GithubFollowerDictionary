//
//  FavoriteManager.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2021/06/30.
//
//import CombineCocoa
import Combine
import Foundation

protocol LocalServiceProtocol {
    func save(followers: [Follower]) -> AnyPublisher<IGMessage, GFError>
    func read() -> [Follower]
    @discardableResult
    func update(byAdding follower: Follower) -> AnyPublisher<IGMessage, GFError>
    func delete(follower: Follower) -> AnyPublisher<IGMessage, GFError>
}

final class LocalService: LocalServiceProtocol {
    
    private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    func save(followers: [Follower]) -> AnyPublisher<IGMessage, GFError> {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(followers)
            defaults.setValue(encodedFavorites, forKey: Keys.favorites)
            return Just(.successful).setFailureType(to: GFError.self).eraseToAnyPublisher()
        } catch {
            return Fail(error: .error).eraseToAnyPublisher()
        }
    }
    
    func read() -> [Follower] {
        guard let obj = defaults.object(forKey: Keys.favorites) as? Data else { return [] }
        
        do {
            let decoder = JSONDecoder()
            let followers = try decoder.decode([Follower].self, from: obj)
            return followers
        } catch {
            return []
        }
    }
    
    @discardableResult
    func update(byAdding follower: Follower) -> AnyPublisher<IGMessage, GFError> {
        var retrievedFollowers = read()
        if retrievedFollowers.contains(follower) {
            return Fail(error: .sameDataAlreadyExist)
                .eraseToAnyPublisher()
        }
        retrievedFollowers.append(follower)
        return save(followers: retrievedFollowers)
            .eraseToAnyPublisher()
    }
    
    func delete(follower: Follower) -> AnyPublisher<IGMessage, GFError> {
        var retrievedFollowers = read()
        retrievedFollowers.removeAll {$0.login == follower.login}
        return save(followers: retrievedFollowers)
            .eraseToAnyPublisher()
    }
}
