//
//  MaterialsDetailsCollectionReusableView.swift
//  AcademicBox
//
//  Created by Alan Jeferson on 16/07/17.
//  Copyright © 2017 IFCE. All rights reserved.
//

import UIKit

class MaterialsDetailsCollectionReusableView: UICollectionReusableView {
        
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDisciplineName: UILabel!
    @IBOutlet weak var labelDisciplineProfessor: UILabel!
    
    func fill(material: Materials) {
        self.labelName.text = material.name
        self.labelDisciplineName.text = material.discipline.name
        self.labelDisciplineProfessor.text = material.discipline.professor?.name
    }
    
}
