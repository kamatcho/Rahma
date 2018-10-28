//
//  UpdateStatusTableViewController.swift
//
//
//  Created by Amr Mohamed on 1/26/17.
//
//

import UIKit

class UpdateStatusTableViewController: UITableViewController {
    
    
    @IBOutlet weak var WorkingStatus: UIButton!
    @IBOutlet weak var StatusButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.StatusButton.titleLabel?.text
            = APIUser.main.status
        self.WorkingStatus.titleLabel?.text = APIUser.main.available_status
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    @IBAction func updateStatus(_ sender: UIButton) {
        sender.showActivityIndicator()
        APIHelper.updateStatus(id: APIUser.main.id, kind: APIUser.main.kind, working: (self.WorkingStatus.titleLabel?.text)! , availble : (self.StatusButton.titleLabel?.text)!) { (status, user) in
            if status.isSuccess {
                self.dismiss(animated: true, completion: nil)
            } else {
                self.showAlert(title: "خطأ", message: status.message)
            }
            sender.hideActivityIndicator()
        }
    }
    
    @IBAction func ConnectStatusBu(_ sender: UIButton) {
        APIConnectionStatus.showAlertIn(vc: self) { connection in
            sender.setTitle(connection.title, for: .normal)
            
        }
    }
    
    @IBAction func WorkStatus(_ sender: UIButton) {
        APIWorkStatus.showAlertIn(vc: self) { work in
            sender.setTitle(work.title, for: .normal)
            
        }
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
