//
//  PhotosTableViewCell.swift
//  PhotosApp
//
//  Created by Imran Syed on 06/10/19.
//  Copyright © 2019 ImranSyed. All rights reserved.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
