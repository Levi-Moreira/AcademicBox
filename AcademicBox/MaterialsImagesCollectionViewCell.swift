//
//  MaterialsImagesCollectionViewCell.swift
//  AcademicBox
//
//  Created by Alan Jeferson on 15/07/17.
//  Copyright © 2017 IFCE. All rights reserved.
//

import UIKit

class MaterialsImagesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    
    func fill(image: Material) {
        self.image.image = image.image
    }
    
}
