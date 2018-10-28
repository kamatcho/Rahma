//
//  AddExperienceTableViewController.swift
//  Rahma
//
//  Created by Amr Mohamed on 1/13/17.
//  Copyright © 2017 Amr Mohamed. All rights reserved.
//

import UIKit

class AddExperienceTableViewController: UITableViewController {
    
    @IBOutlet weak var countryButton: UIButton!
    @IBOutlet weak var doctorTextField: AMTextField!
    @IBOutlet weak var hospitalTextField: AMTextField!
    
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var bodyTextViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.bodyTextView.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    var selectedCountry: APICountry?
    @IBAction func country(_ sender: UIButton) {
        self.tableView.endEditing(true)
        let presenter = APICountryPresenter()
        presenter.showCountriesIn(vc: self, sender: sender) { (country) in
            self.selectedCountry = country
            sender.setTitle(country.name, for: .normal)
        }
    }
    
    @IBAction func done(_ sender: UIButton) {
        guard self.selectedCountry != nil else {
            return
        }
        
        sender.showActivityIndicator()
        APIHelper.addExperience(id: APIUser.main.id, kind: APIUser.main.kind, country: self.selectedCountry!.en, doctor: self.doctorTextField.text!, hospital: self.hospitalTextField.text!, body: self.bodyTextView.text!) { status in
            if status.isSuccess {
                self.showStatusBarNotification("Your Experience added Successfully")
                self.dismiss(animated: true, completion: nil)
            } else {
                self.showAlert(title: "خطأ", message: status.message)
            }
            sender.hideActivityIndicator()
        }
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension AddExperienceTableViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.tableView.beginUpdates()
        self.changeTextViewHeight()
        self.tableView.endUpdates()
    }
    
    func changeTextViewHeight() {
        let height = self.bodyTextView.contentSize.height + 10
        if height > 85 {
            self.bodyTextViewHeight.constant = height
        }
        self.bodyTextView.setContentOffset(CGPoint.zero, animated: true)
    }
}

