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
    let user = AppUser.loggedUser
    let imagePicker = UIImagePickerController()
    
    var didUploadMaterial: ((Material) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker.delegate = self
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
        
//        guard let materialName = self.textFieldMaterialName.text else {
//            return
//        }
//
//        let material = Material(name: materialName)
//        
//        self.reference.childByAutoId().setValue(material.toJson()) { [weak self] (error, reference) in
//            
//            if let _ = error {
//                return
//            }
//            
//            print(reference)
//            
//            self?.dismiss(animated: true, completion: nil)
//            
//        }
        
    
    }
    
    
    //MARK:- UIImagePickerController Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage,
            let data = UIImageJPEGRepresentation(image, 0.0) {
            let material = Material(kind: .image)
            material.data = data
            material.upload(progressHandler: { (fraction) in
            }, completionHandler: { (error) in
                
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                print("Material uploaded: \(material.path)")
                
            })
        }
        self.imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.imagePicker.dismiss(animated: true, completion: nil)
    }

}
