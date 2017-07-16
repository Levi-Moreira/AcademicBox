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
    let kSegueToMaterials = "SegueFromFeedToMaterials"
    
    let reference = Database.database().reference()//(withPath: "users")
    var materials = [Materials]()
    var user: AppUser = AppUser.loggedUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
//        self.observeChanges()
        
        self.user.saveUserToCloud()
        
        let disciplines = Discipline.disciplines
        disciplines.forEach { self.user.add(discipline: $0) }
        self.user.saveDisciplines()
        
//        Professor.saveProfessors()
//        Discipline.saveDisciplines()
        
        self.loadMaterials()
        
    }
    
    func setupView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    func loadMaterials() {
        Materials.all { [weak self] materials in
            
            
            guard let materials = materials else {
                // TODO Handle error
                return
            }
            
            self?.materials.append(contentsOf: materials)
            self?.tableView.reloadData()
            
        }
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
        
        
//        let query = self.reference.queryLimited(toFirst: 2)
        
        
//        self.reference.child("users").observe(.value, with: { [weak self] (snapshot) in
//            
//            if !snapshot.exists() {
//                return
//            }
//            
//            if let dict = snapshot.value as? [String: String] {
//                let json = JSON(dict)
//                print(json["name"].stringValue)
//            }
        
//            self?.materials.removeAll()
//            for item in snapshot.children {
//                if let item = item as? DataSnapshot,
//                    let value = item.value as? [String: String] {
//                    self?.materials.append(Material(json: JSON(value)))
//                }
//            }
//            
//            self?.tableView.reloadData()
            
            
//        })
    
    }
    
    
    // MARK:- UITableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: kSegueToMaterials, sender: self.materials[indexPath.row])
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kSegueToUpload,
            let nav = segue.destination as? UINavigationController,
            let controller = nav.viewControllers.first as? UploadFilesViewController {
            controller.didUploadMaterial = { [weak self] material in
                self?.didUploadMaterial(material: material)
            }
            
        } else if segue.identifier == kSegueToMaterials,
            let controller = segue.destination as? MaterialsViewController,
            let material = sender as? Materials {
            controller.material = material
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
