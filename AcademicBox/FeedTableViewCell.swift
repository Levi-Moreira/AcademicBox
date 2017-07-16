//
//  FeedTableViewCell.swift
//  AcademicBox
//
//  Created by Alan Jeferson on 16/07/17.
//  Copyright © 2017 IFCE. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var labelMaterialsName: UILabel!
    @IBOutlet weak var labelMaterialsUser: UILabel!
    @IBOutlet weak var labelImagesCount: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    func fill(material: Materials) {
        self.labelMaterialsName.text = material.name
        self.labelImagesCount.text = "\(material.images.count)"
        self.labelMaterialsUser.text = material.discipline.name
        self.labelDate.text = material.date.humanString
    }
    
}
