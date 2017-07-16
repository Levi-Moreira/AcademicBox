//
//  DisciplineSelectionViewController.swift
//  AcademicBox
//
//  Created by Alan Jeferson on 04/07/17.
//  Copyright © 2017 IFCE. All rights reserved.
//

import UIKit

class DisciplineSelectionViewController: UITableViewController {

    let kTableViewCellIdentifier = "DisciplineSelectionTableViewCell"
    let user = AppUser.loggedUser
    
    var selectedIndex = 0
    var disciplines = [Discipline]()
    var selectionBlock: ((Int, Discipline) -> Void)?
    
    
    // MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.loadDisciplines()
    }
    
    func setupView() {
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    func loadDisciplines() {
        self.user.loadDisciplines { [weak self] disciplines in
            self?.disciplines.append(contentsOf: disciplines)
            self?.tableView.reloadData()
        }
    }
    
    
    // MARK:- Table View Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.disciplines.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kTableViewCellIdentifier, for: indexPath)
        cell.textLabel?.text = self.disciplines[indexPath.row].name
        cell.accessoryType = self.selectedIndex == indexPath.row ? .checkmark : .none
        return cell
    }
    
    
    // MARK:- Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row != self.selectedIndex {
            self.tableView.cellForRow(at: IndexPath(item: self.selectedIndex, section: 0))?.accessoryType = .none
            self.tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            self.selectedIndex = indexPath.row
        }
    }
    
    
    // MARK:- Actions
    
    @IBAction func didTouchButtonSelect(_ sender: UIBarButtonItem) {
        self.selectionBlock?(self.selectedIndex, self.disciplines[self.selectedIndex].clone())
        self.navigationController?.popViewController(animated: true)
    }

}
