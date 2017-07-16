//
//  MaterialsViewController.swift
//  AcademicBox
//
//  Created by Alan Jeferson on 15/07/17.
//  Copyright © 2017 IFCE. All rights reserved.
//

import UIKit

class MaterialsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let kCollectionViewCellImagesIdentifier = "CollectionViewCellMaterialsImages"
    
    var material: Materials!
    
    let imagesPerRow: CGFloat = 3
    var imageSpacing: CGFloat = 4.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    func setupView() {
        self.navigationItem.title = self.material.discipline.name
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.reloadData()
        self.downloadImages()
    }
    
    func downloadImages() {
        for i in 0..<self.material.images.count {
            self.downloadImage(atIndex: i)
        }
    }
    
    func downloadImage(atIndex index: Int) {
        let image = self.material.images[index]
        image.download { [weak self] error in
            self?.collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
        }
    }
    
    
    // MARK:- CollectionView DataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.material.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.kCollectionViewCellImagesIdentifier, for: indexPath) as? MaterialsImagesCollectionViewCell {
            cell.fill(image: self.material.images[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
        
    }
    
    
    // MARK:- CollectionView Layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: self.imageSpacing, left: self.imageSpacing, bottom: self.imageSpacing, right: self.imageSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.imageSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.imageSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let i = imagesPerRow - 1
        let width: CGFloat = (UIScreen.main.bounds.width - ((2 + i) * imageSpacing)) / imagesPerRow
        return CGSize(width: width, height: width)
    }

}
