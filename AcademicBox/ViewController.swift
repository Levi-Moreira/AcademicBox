//
//  ViewController.swift
//  AcademicBox
//
//  Created by IFCE on 05/06/17.
//  Copyright © 2017 IFCE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var tvEmail: UITextField!
    
    @IBOutlet weak var tvPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didTapSignIn(_ sender: UIButton) {
    
        guard let email = tvEmail.text else {
            
            return
        }
        
        if email.isEmpty{
            showDialog(with: "Preencha seu Email")
        }
        
        guard let password = tvPassword.text else {
            
            return
        }
        
        if password.isEmpty{
            showDialog(with: "Preencha sua senha")
        }
        
    }
    
    
    func showDialog(with : String){
        let alert = UIAlertController(title: "Atenção", message: with, preferredStyle: UIAlertControllerStyle.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)

    }

}

