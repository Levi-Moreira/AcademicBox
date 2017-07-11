//
//  SettingsViewController.swift
//  AcademicBox
//
//  Created by IFCE on 28/06/17.
//  Copyright © 2017 IFCE. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UITableViewController {

    @IBOutlet weak var settingsItem: UINavigationItem!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            try! Auth.auth().signOut()
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            if let loginViewController = storyboard.instantiateInitialViewController() {
                self.present(loginViewController, animated:true, completion: nil)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = loginViewController
            }

            
        }
        
    }


}
