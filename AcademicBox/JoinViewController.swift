//
//  JoinViewController.swift
//  AcademicBox
//
//  Created by IFCE on 13/06/17.
//  Copyright © 2017 IFCE. All rights reserved.
//

import UIKit
import Firebase

class JoinViewController: UIViewController {

    let kFillEmailAlertText = "Fill in your Email"
    
    let kFillPasswordAlertText = "Fill in your Password"
    
    let kFillSignUpErrorAlertText = "Error: Please check your credentials and try again"

    
    @IBOutlet weak var emailTextEmail: UITextField!
    
    @IBOutlet weak var passwordTextView: UITextField!
    
    var handle: AuthStateDidChangeListenerHandle?
    
        var indicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            
        })

    }
    
    override func viewWillDisappear(_ animated: Bool) {
            Auth.auth().removeStateDidChangeListener(handle!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func didClickCreate(_ sender: UIBarButtonItem) {
        indicator.startAnimating()
        guard let email = emailTextEmail.text else {
            return
        }
        
        if email.isEmpty{
            showDialog(with: kFillEmailAlertText)
            return
        }
        
        guard let password = passwordTextView.text else {
            return
        }
        
        if password.isEmpty{
            showDialog(with: kFillPasswordAlertText)
            return
        }

        signUpToFirebase(with: email, password:password)
        
        
    }
    
    func showDialog(with : String){
        let alert = UIAlertController(title: "Atenção", message: with, preferredStyle: UIAlertControllerStyle.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func signUpToFirebase(with email: String, password: String){
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error == nil{
                self.dismiss(animated: true, completion: nil)
            }else{
                self.showDialog(with: self.kFillSignUpErrorAlertText)
                
            }
        }
    }

 

}
