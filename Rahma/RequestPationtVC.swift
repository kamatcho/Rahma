//
//  RequestProviderVC.swift
//  Rahma
//
//  Created by MOHAMED on 3/6/17.
//  Copyright © 2017 Amr Mohamed. All rights reserved.
//

import UIKit
import MobileCoreServices
import Alamofire

class RequestPationtVC: UITableViewController {
    var selectCountry :APICountry?
    var timePicker : TimePickerVC?
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


    @IBAction func ProviderTypeBu(_ sender: UIButton) {
        APITherapistType.showAlertIn(vc: self) { provider in
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
    
    var birthdate: Date?
    @IBAction func birthdate(_ sender: UIButton) {
        self.showDatesPickerViewController { date in
            self.birthdate = date
            sender.setTitle(date.readableDate, for: .normal)
        }
    }
    
    @IBAction func ProviderStatus(_ sender: UIButton) {
        APIProviderType.showAlertIn(vc: self) { providertype in
            sender.setTitle(providertype.title, for: .normal)
        
        }

    }
    
    @IBAction func TimeBu(_ sender: UIButton) {
        self.ShowTimePickerController { time in
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .medium
            
            let timeString = dateFormatter.string(from: time as Date)
            
            
            print(time)
            sender.setTitle(timeString, for: .normal)
            
        }
        
    }
    
    @IBAction func PationtSearchButton(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "PationtSearch", sender: self)
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
