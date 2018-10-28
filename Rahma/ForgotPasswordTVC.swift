//
//  ForgotPasswordTableViewController.swift
//  Ekeif
//
//  Created by Amr Mohamed on 9/13/16.
//  Copyright © 2016 Amr Mohamed. All rights reserved.
//

import UIKit

class ResetPasswordTableViewController: UITableViewController {
    
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var mailTextField: AMTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func dismiss(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetPassword(_ sender: UIButton) {
        sender.showActivityIndicator()
        APIHelper.resetPassword(mail: self.mailTextField.text!) { (status) in
            if status.isSuccess {
                self.showAlert(title: "تم", message: "تم إرسال رسالة تأكيد إلي بريدك الإلكتروني")
            } else {
                self.showAlert(title: "خطأ", message: status.message)
            }
            sender.hideActivityIndicator()
        }
    }
    
}
