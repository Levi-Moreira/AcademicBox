//
//  FeedViewController.swift
//  AcademicBox
//
//  Created by Alan Jeferson on 09/06/17.
//  Copyright © 2017 IFCE. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SwiftyJSON

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let kSegueToUpload = "SegueFromFeedToUpload"
    let reference = Database.database().reference(withPath: "materials")
    var materials = [Material]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.observeChanges()
    }
    
    func setupView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    
    // MARK:- UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.materials.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellFeed", for: indexPath)
        cell.textLabel?.text = self.materials[indexPath.row].name
        return cell
    }
    
    private func observeChanges() {
        
        
        self.reference.observe(.value, with: { [weak self] (snapshot) in
            
            if !snapshot.exists() {
                return
            }
            
            self?.materials.removeAll()
            for item in snapshot.children {
                if let item = item as? DataSnapshot,
                    let value = item.value as? [String: Any] {
                    self?.materials.append(Material(json: JSON(value)))
                }
            }
            
            self?.tableView.reloadData()
            
            
        })
    
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kSegueToUpload,
            let nav = segue.destination as? UINavigationController,
            let controller = nav.viewControllers.first as? UploadFilesViewController {
            controller.didUploadMaterial = { [weak self] material in
                self?.didUploadMaterial(material: material)
            }
            
        }
    }

    
    private func didUploadMaterial(material: Material) {
        print("Material uploaded")
    }
    
    // MARK:- Actions

    @IBAction func didTouchAddButton(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: kSegueToUpload, sender: nil)

    }
    
}
