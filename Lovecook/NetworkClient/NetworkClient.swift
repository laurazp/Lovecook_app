//
//  NetworkClient.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 21/11/23.
//

import Foundation

protocol NetworkClient {
    
    func get<T: Decodable>(url: String) async throws -> T
    
}
