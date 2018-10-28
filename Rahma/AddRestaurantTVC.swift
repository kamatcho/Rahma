//
//  AddRestaurantTableViewController.swift
//  Rahma
//
//  Created by Amr Mohamed on 1/28/17.
//  Copyright © 2017 Amr Mohamed. All rights reserved.
//

import UIKit

class AddRestaurantTableViewController: UITableViewController {
    
    @IBOutlet weak var nameTextField: AMTextField!
    @IBOutlet weak var mobileTextField: AMTextField!
    
    @IBOutlet weak var cityTextField: AMTextField!
    @IBOutlet weak var addressTextField: AMTextField!
    
    @IBOutlet weak var countryButton: UIButton!
    @IBOutlet weak var RestaurantTypeButton: UIButton!
    @IBOutlet weak var RestaurantOptionsButton: UIButton!
    @IBOutlet weak var serviceTypeButton: UIButton!
    
    @IBOutlet weak var CountryKey: AMTextField!
    var selectedCountry: APICountry?
    var selectedRestaurantType: APIRestaurantType?
    var selectedRestaurantOption: APIRestaurantOptions?
    var selectedRestaurantServiceType: APIRestaurantServiceType?
    
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
    
    @IBAction func RestaurantType(_ sender: UIButton) {
        APIRestaurantType.showAlertIn(vc: self) { item in
            self.selectedRestaurantType = item
            self.RestaurantTypeButton.setTitle(item.title, for: .normal)
        }
    }
    
    @IBAction func RestaurantOptions(_ sender: UIButton) {
        APIRestaurantOptions.showAlertIn(vc: self) { item in
            self.selectedRestaurantOption = item
            self.RestaurantOptionsButton.setTitle(item.title, for: .normal)
        }
    }
    
    @IBAction func serviceType(_ sender: UIButton) {
        APIRestaurantServiceType.showAlertIn(vc: self) { item in
            self.selectedRestaurantServiceType = item
            self.serviceTypeButton.setTitle(item.title, for: .normal)
        }
    }
    
    @IBAction func addHospital(_ sender: UIButton) {
        guard self.selectedCountry != nil, self.selectedRestaurantType != nil, self.selectedRestaurantOption != nil , self.selectedRestaurantServiceType != nil else {
            return
        }
        
        sender.showActivityIndicator()
        APIHelper.addRestaurant(name: self.nameTextField.text!, mobile: self.mobileTextField.text!, address: self.addressTextField.text!, city: self.cityTextField.text!, country: self.selectedCountry!.en, restaurantType: self.selectedRestaurantType!.title, restaurantOptions: self.selectedRestaurantOption!.title, serviceType: self.selectedRestaurantServiceType!.title,email: "",phonecode:self.CountryKey.text!, password: "") { (status) in
            if status.isSuccess {
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
