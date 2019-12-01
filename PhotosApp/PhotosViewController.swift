//
//  ViewController.swift
//  PhotosApp
//
//  Created by Imran Syed on 05/10/19.
//  Copyright © 2019 ImranSyed. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var photoHits: [Hit] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPhotos()
        tableView.register(UINib(nibName: "PhotosTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotosTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }

    func fetchPhotos() {
        PhotosService.shared.fetchPhotos { (photoModel) in
            print("photoHits array before data fetched = \(self.photoHits)")
            self.photoHits = photoModel.hits
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            print("photoHits array after data fetched = \(self.photoHits)")
        }
    }

    private func downloadImage(_ urlStr: String, completion: @escaping (String, UIImage) -> Void) {
        guard let url = URL(string: urlStr) else {
            completion(urlStr, UIImage(imageLiteralResourceName: "placeHolder"))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, let photo = UIImage(data: data) else {
                return
            }
            completion(urlStr, photo)
        }
        task.resume()
        }
    }

extension PhotosViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoHits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let photoCell = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath) as? PhotosTableViewCell else{
            return UITableViewCell()
        }
        let currentPhoto = photoHits[indexPath.row]
        let currentIndexPhotoUrl = currentPhoto.largeImageURL
        downloadImage(currentIndexPhotoUrl) { (downloadPhotoUrl, downloadedPhoto) in
            if downloadPhotoUrl == currentIndexPhotoUrl{
                DispatchQueue.main.async {
                    photoCell.photoImageView.image = downloadedPhoto
                }
            }
            }
//        customCell.photoImageView.image = currentSong.photo
//        customCell.titleLabel.text = currentSong.title
        
        return photoCell
    }
}
extension PhotosViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
