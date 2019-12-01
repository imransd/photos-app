//
//  File.swift
//  PhotosApp
//
//  Created by Imran Syed on 05/10/19.
//  Copyright © 2019 ImranSyed. All rights reserved.
//

import Foundation

class PhotosService {
    static let shared = PhotosService()
    private let urlStr = "https://pixabay.com/api/?key=8630898-e092bf16cb1dd9ff6a483dabf&order=latest&page=1&per_page=50"
    
    func fetchPhotos(_ completion: @escaping (PhotoModel) -> Void) {
        guard let url = URL(string: urlStr) else {
            assertionFailure("Invalid URL")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            guard error == nil else {
                assertionFailure("\(error?.localizedDescription) returned")
                return
            }
            guard let data = data else {
                assertionFailure("data returned nil")
                return
            }
            guard let photoModel = try? JSONDecoder().decode(PhotoModel.self, from: data) else {
                assertionFailure("data JSON parsing failed")
                return
            }
            completion(photoModel)
        }
        task.resume()
        print("this is just to demonstrate how completion handler works")
    }
}
