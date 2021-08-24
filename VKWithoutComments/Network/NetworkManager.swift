//
//  NetworkManager.swift
//  VKWithoutComments
//
//  Created by Ruslan Gallyamov on 24.08.2021.
//

import Foundation

protocol NetworkManager {
    func request(for method: APIConfiguration.Methods, params: [String: String], completion: @escaping (Data?, Error?) -> Void)
}

class NetworkManagerImpl: NetworkManager {
    
    func request(for method: APIConfiguration.Methods, params: [String: String], completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URLBuilder().buildUrl(for: method, withParams: params) else { return }
        let task = createDataTask(url: url, completion: completion)
        task.resume()
    }
    
    private func createDataTask(url: URL, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }

}
