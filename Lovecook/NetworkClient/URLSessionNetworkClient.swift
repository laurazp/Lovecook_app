//
//  URLSessionNetworkClient.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 14/11/23.
//

import Foundation

class URLSessionNetworkClient: NetworkClient {
    func get<T: Decodable>(url: String) async throws -> T {
        
        guard let url = URL(string: url) else {
            throw NetworkClientError.badUrl
        }
        
        let data = try await URLSession.shared.data(from: url).0
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
