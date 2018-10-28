//
//  RegisterPlaceTableViewController.swift
//  Rahma
//
//  Created by Amr Mohamed on 2/21/17.
//  Copyright © 2017 Amr Mohamed. All rights reserved.
//

import UIKit

class RegisterPlaceTableViewController: UITableViewController {
    
    @IBOutlet weak var nameTextField: AMTextField!
    @IBOutlet weak var mobileTextField: AMTextField!
    
    @IBOutlet weak var CountryKey: AMTextField!
    @IBOutlet weak var emailTextField: AMTextField!
    @IBOutlet weak var cityTextField: AMTextField!
    @IBOutlet weak var addressTextField: AMTextField!
    
    @IBOutlet weak var passwordTextField: AMTextField!
    
    @IBOutlet weak var countryButton: UIButton!
    @IBOutlet weak var placeTypeButton: UIButton!
    @IBOutlet weak var serviceTypeButton: UIButton!
    
    var selectedCountry: APICountry?
    var selectedPlaceType: APIPlaceType?
    var selectedServiceType: APIPlaceServiceType?
    
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
            self.CountryKey.text = country.Key
        }
    }
    
    @IBAction func placeType(_ sender: UIButton) {
        APIPlaceType.showAlertIn(vc: self) { item in
            self.selectedPlaceType = item
            sender.setTitle(item.title, for: .normal)
        }
    }
    
    @IBAction func serviceType(_ sender: UIButton) {
        APIPlaceServiceType.showAlertIn(vc: self) { item in
            self.selectedServiceType = item
            sender.setTitle(item.title, for: .normal)
        }
    }
    
    var didAccept = false
    @IBAction func acceptTerms(_ sender: UIButton) {
        sender.setImage(self.didAccept ? #imageLiteral(resourceName: "Check") : #imageLiteral(resourceName: "UnCheck"), for: .normal)
        self.didAccept = !self.didAccept
    }
    
    @IBAction func addHospital(_ sender: UIButton) {
        guard self.selectedCountry != nil, self.selectedPlaceType != nil, self.selectedServiceType != nil else {
            return
        }
        
        guard !self.didAccept else {
            self.showAlert(title: "يجب عليك الموافقة علي شروط التطبيق أولا", message: "")
            return
        }
        
        sender.showActivityIndicator()
        APIHelper.addPlace(name: self.nameTextField.text!, mobile: self.mobileTextField.text!, address: self.addressTextField.text!, city: self.cityTextField.text!, country: self.selectedCountry!.en, placeType: self.selectedPlaceType!.title, serviceType: self.selectedServiceType!.title, email: self.emailTextField.text!,phonecode : self.CountryKey.text! , password: self.passwordTextField.text!) { (status) in
            if status.isSuccess {
                self.dismiss(animated: true, completion: nil)
            } else {
                self.showAlert(title: "خطأ", message: status.message)
            }
        }
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
