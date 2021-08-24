//
//  URLBuilder.swift
//  VKWithoutComments
//
//  Created by Ruslan Gallyamov on 24.08.2021.
//

import Foundation

struct URLBuilder {
    
    func buildUrl(for apiMethod: APIConfiguration.Methods, withParams params: [String: String]) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = APIConfiguration.scheme
        urlComponents.host = APIConfiguration.host
        urlComponents.path = apiMethod.rawValue
        urlComponents.queryItems = buildParams(with: params).map { URLQueryItem(name: $0, value: $1) }
        return urlComponents.url
    }
    
    private func buildParams(with params: [String: String]) -> [String: String] {
        var totalParams = params
        totalParams["access_token"] = AuthService.shared.accessToken
        totalParams["v"] = APIConfiguration.version
        
        return totalParams
    }
}
