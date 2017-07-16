//
//  DisciplinesViewController.swift
//  AcademicBox
//
//  Created by Alan Jeferson on 12/06/17.
//  Copyright © 2017 IFCE. All rights reserved.
//

import UIKit

class DisciplinesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let user = AppUser.loggedUser
    var disciplines = [Discipline]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.loadDisciplines()
    }

    func loadDisciplines() {
        self.showLoader()
        self.user.loadDisciplines { [weak self] disciplines in
            self?.hideLoader()
            self?.disciplines.append(contentsOf: disciplines)
            self?.tableView.reloadData()
        }
    }
    
    func setupView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    
    //MARK:- TableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.disciplines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellDisciplines", for: indexPath) as! TableViewCellDisciplinesTableViewCell
        
        cell.disciplineName?.text = self.disciplines[indexPath.row].name
        
        return cell
    }
    
    
    //MARK:- TableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
