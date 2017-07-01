//
//  UploadFilesViewController.swift
//  AcademicBox
//
//  Created by Alan Jeferson on 09/06/17.
//  Copyright © 2017 IFCE. All rights reserved.
//

import UIKit
import FirebaseDatabase

class UploadFilesViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var textFieldMaterialName: UITextField!
    
    let reference = Database.database().reference(withPath: "materials")
    var storageHelper: FirebaseStorageHelper
    let user = AppUser.loggedUser
    let imagePicker = UIImagePickerController()
    
    var didUploadMaterial: ((Material) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker.delegate = self
        self.storageHelper = FirebaseStorageHelper(user: self.user)
    }

    
    // MARK:- Actions
    
    
    @IBAction func didTouchPickFile(_ sender: UIButton) {
        self.imagePicker.allowsEditing = false
        self.imagePicker.sourceType = .photoLibrary
        self.present(self.imagePicker, animated: true, completion: nil)
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
    
    
    //MARK:- UIImagePickerController Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage,
            let data = UIImagePNGRepresentation(image) {
            self.storageHelper.upload(file: data, completionHandler: { error in
                
            })
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    }

}
