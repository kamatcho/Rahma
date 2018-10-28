//
//  AddEventTableViewController.swift
//  Rahma
//
//  Created by Amr Mohamed on 2/24/17.
//  Copyright © 2017 Amr Mohamed. All rights reserved.
//

import UIKit

class AddEventTableViewController: UITableViewController {

    var centerType: APIEventType!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var nameTextField: AMTextField!
    @IBOutlet weak var mobileTextField: AMTextField!
    @IBOutlet weak var mailTextField: AMTextField!
    
    @IBOutlet weak var addressTextField: AMTextField!
    @IBOutlet weak var websiteTextField: AMTextField!
    
    @IBOutlet weak var cityTextField: AMTextField!
    
    @IBOutlet weak var countryButton: UIButton!
    @IBOutlet weak var centerTypeButton: UIButton!
    
    var selectedCountry: APICountry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func country(_ sender: UIButton) {
        self.tableView.endEditing(true)
        let presenter = APICountryPresenter()
        presenter.showCountriesIn(vc: self, sender: sender) { (country) in
            self.selectedCountry = country
            sender.setTitle(country.name, for: .normal)
        }
    }
    
    @IBAction func centerType(_ sender: UIButton) {
        APICenterType.showAlertIn(vc: self) { center in
            sender.setTitle(center.title, for: .normal)
        }
    }
    
    @IBAction func addHospital(_ sender: UIButton) {
        guard self.selectedCountry != nil else {
            return
        }
        sender.showActivityIndicator()
        APIHelper.registerCenter(name: self.nameTextField.text!,
                                 mobile: self.mobileTextField.text!,
                                 address: self.addressTextField.text!,
                                 city: self.cityTextField.text!,
                                 country: self.selectedCountry!.en,
                                 centerType: self.centerTypeButton.titleLabel!.text!,
                                 website: self.websiteTextField.text!,
                                 mail: self.mailTextField.text!, phonecode: "", password: "",
                                 image: self.userImageView.image) { (status, user) in
                                    if status.isSuccess {
                                        self.showStatusBarNotification("Hospital added Succesfully")
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
