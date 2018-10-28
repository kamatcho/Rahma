//
//  AllAdsTableViewController.swift
//  Etoggar
//
//  Created by Amr Mohamed on 12/26/16.
//  Copyright © 2016 Amr Mohamed. All rights reserved.
//

import UIKit

class HospitalsTableViewController: UITableViewController {
    
    var country: APICountry!
    var hospitals = [APIHospital]()
    var hospitalType = APICenterType.governmentHospital
    
    init(style: UITableViewStyle, hospitalType: APICenterType, country: APICountry) {
        super.init(style: style)
        self.hospitalType = hospitalType
        self.country = country
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        self.registerHospitalTVCell()
        self.getHospitals()
    }
    
    func getHospitals() {
        self.addText(" ")
        self.view.showActivityIndicator()
        APIHelper.getHospitals(type: self.hospitalType, country: self.country.en) { (status, hospitals) in
            if status.isSuccess {
                self.hospitals = hospitals!
            } else {
                self.addText(status.message)
            }
            self.tableView.reloadData()
            self.view.hideActivityIndicator()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.hospitals.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HospitalTVCell.identifier, for: indexPath) as! HospitalTVCell
        cell.setupCell(self.hospitals[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
