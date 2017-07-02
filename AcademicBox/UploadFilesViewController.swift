//
//  UploadFilesViewController.swift
//  AcademicBox
//
//  Created by Alan Jeferson on 09/06/17.
//  Copyright © 2017 IFCE. All rights reserved.
//

import UIKit
import FirebaseDatabase

class UploadFilesViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionViewImages: UICollectionView!
    @IBOutlet weak var textFieldMaterialName: UITextField!
    
    private let kCollectionViewCellUploadImages = "UploadFilesImagesCollectionViewCell"
    
    let user = AppUser.loggedUser
    let imagePicker = UIImagePickerController()
    
    var didUploadMaterial: ((Material) -> Void)?
    
    let material = Materials()
    var imageUploadError = false
    var imageUploadCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.imagePicker.delegate = self
    }
    
    func setupView() {
        self.collectionViewImages.dataSource = self
        self.collectionViewImages.delegate = self
    }
    
    
    // MARK:- CollectionViewFlowLayout Delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90.0, height: 90.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 5.0, bottom: 10.0, right: 5.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < self.material.images.count {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewCellUploadImages, for: indexPath) as? UploadImagesCollectionViewCell {
                cell.fill(material: self.material.images[indexPath.row])
                return cell
            }
        } else {
            // Add image
            return collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewCellUploadImages, for: indexPath)
        }
        return UICollectionViewCell()
    }
    
    // MARK:- CollectionView Data Source
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViewImages {
            return self.material.images.count + 1
        }
        return 0
    }
    
    
    // MARK: CollectionView Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < self.material.images.count {
            
        } else {
            self.presentActionSheetForImageSourceSelection()
        }
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
        self.uploadMaterial()
    }
    
    func presentActionSheetForImageSourceSelection() {
        let sheet = UIAlertController(title: nil, message: "Selecione a origem da imagem", preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Biblioteca de Fotos", style: .default, handler: { [weak self] (action) in
            if let imagePicker = self?.imagePicker {
                imagePicker.sourceType = .photoLibrary
                self?.present(imagePicker, animated: true, completion: nil)
            }
        }))
        sheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { [weak self] (action) in
            if let imagePicker = self?.imagePicker {
                imagePicker.sourceType = .camera
                self?.present(imagePicker, animated: true, completion: nil)
            }
        }))
        sheet.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        self.present(sheet, animated: true, completion: nil)
    }
    
    private func uploadMaterial() {
        
        guard let materialName = self.textFieldMaterialName.text else {
            return
        }
        
        self.material.name = materialName
        
        self.material.upload { [weak self] error in
            
            if let _ = error {
                // TODO Display the error
                return
            }
            
            self?.uploadMaterialImages()
            
        }
        
    }
    
    private func uploadMaterialImages() {
        self.imageUploadCount = self.material.images.count
        var i = 0
        while(i < self.material.images.count) {
            self.uploadMaterialImage(atIndex: i)
            i += 1
        }
    }
    
    private func uploadMaterialImage(atIndex index: Int) {
        let image = self.material.images[index]
        image.upload(progressHandler: { (fraction) in
            print(fraction)
        }) { [weak self] error in
            
            if let count = self?.imageUploadCount {
                self?.imageUploadCount = count - 1
            }
            
            if let _ = error {
                self?.imageUploadError = true
            }
            
            if self?.imageUploadCount == 0 {
                self?.didFinishUploadingImages()
            }
            
            print("Image \(image.path) uploaded")
            
        }
    }
    
    private func didFinishUploadingImages() {
        if !self.imageUploadError {
            print("All images have been successfully uploaded")
            self.dismiss(animated: true, completion: nil)
        } else {
            print("Some image was not uploaded")
            // TODO Handle the error properly
        }
    }
    
    
    //MARK:- UIImagePickerController Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let materialImage = Material(kind: .image)
            materialImage.image = image
            self.material.add(image: materialImage)
            self.collectionViewImages.reloadData()
        }
        self.imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.imagePicker.dismiss(animated: true, completion: nil)
    }
    
}
