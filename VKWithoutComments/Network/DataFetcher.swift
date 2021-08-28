//
//  DataFetcher.swift
//  VKWithoutComments
//
//  Created by Ruslan Gallyamov on 24.08.2021.
//

import Foundation

protocol DataFetcher {
    func fetchFeed(completion: @escaping (FeedResponse?) -> Void)
    func fetchUser(completion: @escaping (UserResponse?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {
    
    private let networkManager: NetworkManager = NetworkManagerImpl()
    
    func fetchFeed(completion: @escaping (FeedResponse?) -> Void) {
        let params = ["filters": "post, photo"]
        networkManager.request(for: .feedGet, params: params) { data, error in
            guard let data = data, let decodedData = decodeData(type: GetFeedResponse.self, from: data) else { completion(nil); return }
            completion(decodedData.response)
        }
    }
    
    func fetchUser(completion: @escaping (UserResponse?) -> Void) {
        guard let userId = AuthService.shared.userId else { return }
        let params = ["user_ids": userId, "fields": "photo_100"]
        networkManager.request(for: .usersGet, params: params) { data, error in
            guard let data = data, let decodedData = decodeData(type: GetUsersResponse.self, from: data) else {
                print("Can't fetch user")
                return
            }
            completion(decodedData.response.first)
        }
    }
    
    private func decodeData<T: Decodable>(type: T.Type, from data: Data) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try? decoder.decode(type.self, from: data)
    }
    
    
}
