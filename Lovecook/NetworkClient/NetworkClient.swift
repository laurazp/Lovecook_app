//
//  NetworkClient.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 21/11/23.
//

import Foundation

protocol NetworkClient {
    
    func call<T: Decodable>(urlRequest: URLRequest) async throws -> T
    func getCall<T: Decodable>(url: String, queryParams: [String : String]?) async throws -> T
    
}
