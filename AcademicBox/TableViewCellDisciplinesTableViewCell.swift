//
//  TableViewCellDisciplinesTableViewCell.swift
//  AcademicBox
//
//  Created by IFCE on 10/07/17.
//  Copyright © 2017 IFCE. All rights reserved.
//

import UIKit

class TableViewCellDisciplinesTableViewCell: UITableViewCell {

    @IBOutlet weak var disciplineIcon: UIImageView!
    
    @IBOutlet weak var disciplineName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
