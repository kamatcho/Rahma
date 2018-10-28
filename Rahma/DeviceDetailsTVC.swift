//
//  DeviceDetailsTableViewController.swift
//  Rahma
//
//  Created by Amr Mohamed on 1/28/17.
//  Copyright © 2017 Amr Mohamed. All rights reserved.
//

import UIKit
import MessageUI

class DeviceDetailsTableViewController: UITableViewController {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameTextLabel: UILabel!
    @IBOutlet weak var countryTextLabel: UILabel!
    @IBOutlet weak var mobileTextLabel: UILabel!
    @IBOutlet weak var mailTextLabel: UILabel!
    
    var device: APIDevice!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameTextLabel.text = self.device.user.name
        self.countryTextLabel.text = self.device.user.country
        self.mobileTextLabel.text = self.device.user.mobile
        self.mailTextLabel.text = self.device.user.mail
        
        if let url = URL(string: self.device.image) {
            self.userImageView.image = nil
            self.userImageView.showActivityIndicator(shouldAdjustYAxis: false)
            self.userImageView.hnk_setImageFromURL(url, failure: { error in
                self.userImageView.hideActivityIndicator()
            }, success: { image in
                self.userImageView.image = image
                self.userImageView.hideActivityIndicator()
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 2: self.callMobile()
        case 3: self.openMail()
        default: break
        }
    }
    
    func callMobile() {
        if let url = URL(string: "TEL://" + self.device.user.mobile) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    func openMail() {
        self.sendEmailTo(recipients: [self.device.user.mail])
    }
    
}

extension DeviceDetailsTableViewController : MFMailComposeViewControllerDelegate , UINavigationControllerDelegate {
    
    func sendEmailTo(recipients: [String], subject: String = "") {
        guard MFMailComposeViewController.canSendMail() else {
            self.showAlert(title: "We couldn't open mail composer", message: "Maybe you didn't setup your mail app yet ?")
            return
        }
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(recipients)
        mailComposerVC.setSubject(subject)
        mailComposerVC.setMessageBody("", isHTML: false)
        
        self.present(mailComposerVC, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

