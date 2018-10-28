//
//  StartTableViewController.swift
//  Rahma
//
//  Created by Amr Mohamed on 1/10/17.
//  Copyright © 2017 Amr Mohamed. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if APIUser.isUserAvailabelOnDefaults {
            self.segueToMainTabBar()
        } else {
            self.segueToLoginTVC()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
