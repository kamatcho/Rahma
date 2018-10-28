//
//  RequestEscortsVC.swift
//  Rahma
//
//  Created by MOHAMED on 3/7/17.
//  Copyright © 2017 Amr Mohamed. All rights reserved.
//

import UIKit

class RequestProviderVC: UITableViewController {
    var selectCountry :APICountry?

    @IBOutlet weak var ProviderTypeButton: UIButton!
    @IBOutlet weak var CountryButton: UIButton!
    @IBOutlet weak var DateButton: UIButton!
    @IBOutlet weak var CityText: AMTextField!
    @IBOutlet weak var TimeText: UIButton!
    @IBOutlet weak var AddressText: AMTextField!
    @IBOutlet weak var ProviderStatusButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func ProviderTypeBu(_ sender: UIButton) {
        APIProvider.showAlertIn(vc: self) { provider in
            sender.setTitle(provider.title, for: .normal)
            
        }
    }
    
    @IBAction func CountryBu(_ sender: UIButton) {
        self.tableView.endEditing(true)
        let presenter = APICountryPresenter()
        presenter.showCountriesIn(vc: self, sender: sender) { (country) in
            self.selectCountry = country
            sender.setTitle(country.name, for: .normal)
        }
    }
    
    
    @IBAction func ProviderStatusBu(_ sender: UIButton) {
        APIProviderType.showAlertIn(vc: self) { providertype in
            sender.setTitle(providertype.title, for: .normal)
            
        }
    }
    var birthdate: Date?
    
    @IBAction func birthdate(_ sender: UIButton) {
        self.showDatesPickerViewController { date in
            self.birthdate = date
            sender.setTitle(date.readableDate, for: .normal)
        }
    }
    
    @IBAction func SearchProviderBu(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "ProviderSearch", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dist = segue.destination as? SearchVc {
            dist.serviceKind = self.ProviderTypeButton.titleLabel?.text
            dist.country = self.CountryButton.titleLabel?.text
            dist.city = self.CityText.text
            dist.date = self.DateButton.titleLabel?.text
            dist.time = self.TimeText.titleLabel?.text
            dist.address = self.AddressText.text
            dist.status_kind = self.ProviderStatusButton.titleLabel?.text
        }
    }

}

