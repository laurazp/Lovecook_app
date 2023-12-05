//
//  APIResponse.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 14/11/23.
//

import Foundation

struct APIResponse<T: Decodable>: Decodable {
    let results: [T]?
}
