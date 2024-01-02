//
//  Photo.swift
//  Lovecook
//
//  Created by Laura Zafra on 30/12/23.
//

import Foundation

struct Photo: Identifiable {
    let id: UUID = UUID()
    let url: URL
    let name: String
}
