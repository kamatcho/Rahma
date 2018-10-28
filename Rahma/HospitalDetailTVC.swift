//
//  HospitalDetailTableViewController.swift
//  Rahma
//
//  Created by Amr Mohamed on 1/11/17.
//  Copyright © 2017 Amr Mohamed. All rights reserved.
//

import UIKit
import MessageUI

class HospitalDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var hospitalImageView: UIImageView!
    @IBOutlet weak var nameTextLabel: UILabel!
    @IBOutlet weak var cityTextLabel: UILabel!
    @IBOutlet weak var countryTextLabel: UILabel!
    @IBOutlet weak var addressTextLabel: UILabel!
    @IBOutlet weak var mobileTextLabel: UILabel!
    @IBOutlet weak var mailTextLabel: UILabel!
    @IBOutlet weak var websiteTextLabel: UILabel!
    
    var hospital: APIHospital!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.hospital.name
        self.nameTextLabel.text = self.hospital.name
        self.cityTextLabel.text = self.hospital.city
        self.countryTextLabel.text = self.hospital.country
        self.addressTextLabel.text = self.hospital.address
        self.mobileTextLabel.text = self.hospital.mobile
        self.mailTextLabel.text = self.hospital.mail
        self.websiteTextLabel.text = self.hospital.website
        
        if let url = URL(string: self.hospital.image) {
            self.hospitalImageView.image = nil
            self.hospitalImageView.showActivityIndicator(shouldAdjustYAxis: false)
            self.hospitalImageView.hnk_setImageFromURL(url, failure: { error in
                self.hospitalImageView.hideActivityIndicator()
            }, success: { image in
                self.hospitalImageView.image = image
                self.hospitalImageView.hideActivityIndicator()
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 2: self.callMobile()
        case 3: self.openMail()
        case 4: self.openWebsite()
        default: break
        }
    }
    
    func callMobile() {
        let url = URL.init(string: "tel:\(self.hospital.mobile)")
        guard url != nil else {
            return
        }
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
    }
    
    func openMail() {
        self.sendEmailTo(recipients: [self.hospital.mail])
    }
    
    func openWebsite() {
        let url = URL.init(string: self.hospital.website)
        guard url != nil else {
            return
        }
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
    }
    
}

extension HospitalDetailTableViewController : MFMailComposeViewControllerDelegate , UINavigationControllerDelegate {
    
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

