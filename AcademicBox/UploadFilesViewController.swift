//
//  UploadFilesViewController.swift
//  AcademicBox
//
//  Created by Alan Jeferson on 09/06/17.
//  Copyright © 2017 IFCE. All rights reserved.
//

import UIKit
import FirebaseDatabase

class UploadFilesViewController: UIViewController {
    
    @IBOutlet weak var textFieldMaterialName: UITextField!
    
    let reference = Database.database().reference(withPath: "materials")
    
    var didUploadMaterial: ((Material) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    // MARK:- Actions
    
    
    @IBAction func didTouchPickFile(_ sender: UIButton) {
        
    }
    
    
    @IBAction func didTouchButtonCancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func didTouchButtonSave(_ sender: UIBarButtonItem) {
        self.saveMaterial()
    }
    
    
    private func saveMaterial() {
        
        guard let materialName = self.textFieldMaterialName.text else {
            return
        }

        let material = Material(name: materialName)
        
        self.reference.childByAutoId().setValue(material.toJson()) { [weak self] (error, reference) in
            
            if let _ = error {
                return
            }
            
            print(reference)
            
            self?.dismiss(animated: true, completion: nil)
            
        }
        
    
    }

}
