//
//  ViewController.swift
//  AcademicBox
//
//  Created by IFCE on 05/06/17.
//  Copyright © 2017 IFCE. All rights reserved.
//

import UIKit
import Firebase
import FacebookLogin

class ViewController: UIViewController {

    
    let kFillEmailAlertText = "Preencha seu Email"
    
    let kFillPasswordAlertText = "Preencha sua Senha"
    
    let KFillAuthenticationAlertText = "Email não exite!"
    
    var handle: AuthStateDidChangeListenerHandle?
    
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    @IBOutlet weak var tvEmail: UITextField!
    
    @IBOutlet weak var tvPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        indicator.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.bringSubview(toFront: view)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    @IBAction func didTapSignIn(_ sender: UIButton) {
    
        indicator.startAnimating()
        guard let email = tvEmail.text else {
            return
        }
        
        if email.isEmpty{
            showDialog(with: kFillEmailAlertText)
            return
        }
        
        guard let password = tvPassword.text else {
            return
        }
        
        if password.isEmpty{
            showDialog(with: kFillPasswordAlertText)
            return
        }
        
        signInToFirebase(email: email,password: password)
        
        
        
    }
    
    
    func signInToFirebase(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil {
                
                self.indicator.stopAnimating()
                
                let storyboard = UIStoryboard(name: "Menu", bundle: nil)
                
                let VC1 = storyboard.instantiateViewController(withIdentifier: "MainMenuNavigation") as! UINavigationController
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = VC1
            } else {
                
                self.indicator.stopAnimating()
                self.showDialog(with: self.KFillAuthenticationAlertText)
            }
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

