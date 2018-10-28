//
//  ViewController.swift
//  Etoggar
//
//  Created by Amr Mohamed on 12/22/16.
//  Copyright © 2016 Amr Mohamed. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginTableViewController: UITableViewController {
    
    @IBOutlet weak var mailTextField: AMTextField!
    @IBOutlet weak var passwordTextField: AMTextField!
    
    @IBOutlet weak var registerButton: UIButton! {
        didSet {
            self.registerButton.titleLabel?.textAlignment = .natural
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mailTextField.text = "iAmrMohamed@gmail.com"
        self.passwordTextField.text = "123456"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func login(_ sender: UIButton) {
        sender.showActivityIndicator()
        APIHelper.loginUser(mail: self.mailTextField.text!, password: self.passwordTextField.text!) { (status, user) in
            if status.isSuccess {
                self.segueToMainTabBar()
            } else {
                self.showAlert(title: "خطأ", message: status.message)
            }
            sender.hideActivityIndicator()
        }
    }
    
    @IBAction func skipLogin(_ sender: UIButton) {
        self.segueToMainTabBar()
    }
    
}
