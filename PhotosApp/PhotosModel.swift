//
//  PhotosModel.swift
//  PhotosApp
//
//  Created by Imran Syed on 05/10/19.
//  Copyright © 2019 ImranSyed. All rights reserved.
//



import Foundation

// MARK: - PhotoModel
struct PhotoModel: Codable {
    let totalHits: Int
    let hits: [Hit]
    let total: Int
}

// MARK: - Hit
struct Hit: Codable {
    let largeImageURL: String
    let likes: Int
    let user: String
    let userId: Int
    
    enum CodingKeys: String, CodingKey {
        case largeImageURL
        case likes
        case user
        case userId = "user_id"
    }
}

