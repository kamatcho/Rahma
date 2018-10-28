//
//  RequestDriverVC.swift
//  Rahma
//
//  Created by MOHAMED on 3/10/17.
//  Copyright © 2017 Amr Mohamed. All rights reserved.
//

import UIKit

class RequestDriverVC: UITableViewController {
    var selectCountry :APICountry?
    @IBOutlet weak var NumberOfPationt: UIButton!
    @IBOutlet weak var Date: UIButton!

    @IBOutlet weak var DriverStatus: UIButton!
    @IBOutlet weak var PationtLocation: AMTextField!
    @IBOutlet weak var Time: UIButton!
    @IBOutlet weak var CityText: AMTextField!
    @IBOutlet weak var Country: UIButton!
    @IBOutlet weak var IsCarReady: UIButton!
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

    @IBAction func NumberOfPationtBu(_ sender: UIButton) {
        APINumberOfPationt.showAlertIn(vc: self) { number in
            sender.setTitle(number.title, for: .normal)
            
        }
    }
    
    @IBAction func UWantAcar(_ sender: UIButton) {
        APICar.showAlertIn(vc: self) { car in
            sender.setTitle(car.title, for: .normal)
            
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
    @IBAction func ProviderStatusBu(_ sender: UIButton) {
        APIProviderType.showAlertIn(vc: self) { providertype in
            sender.setTitle(providertype.title, for: .normal)
            
        }
    }
    

    @IBAction func DriverSearchBu(_ sender: UIButton) {
        APIHelper.ProviderSearch(serviceKind: "سائق", country: (self.Country.titleLabel?.text)!, city: self.CityText.text!, time: (self.Time.titleLabel?.text)!, date: "", address: self.PationtLocation.text!, status_kind: (self.DriverStatus.titleLabel?.text)!) { (error) in
            
        }    }

}
