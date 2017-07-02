//
//  UploadImagesCollectionViewCell.swift
//  AcademicBox
//
//  Created by Alan Jeferson on 02/07/17.
//  Copyright © 2017 IFCE. All rights reserved.
//

import UIKit

class UploadImagesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func fill(material: Material) {
        self.imageView.image = material.image
    }
    
}
