//
//  AMCountriesTableViewController.swift
//  Rahma
//
//  Created by Amr Mohamed on 1/5/17.
//  Copyright © 2017 Amr Mohamed. All rights reserved.
//

import UIKit

class CountriesTableViewController: UITableViewController {
    
    var completion: ((_ country: APICountry) -> ())!
    
    var countries = [APICountry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(self.getCountries), for: .valueChanged)
        self.getCountries()
    }
    
    func getCountries() {
        if (self.refreshControl?.isRefreshing)! {
            self.refreshControl?.endRefreshing()
        }
        
        self.countries.removeAll(keepingCapacity: true)
        
        self.addText(" ")
        self.view.showActivityIndicator()
        APIHelper.getAllCountries { (status, countries) in
            if status.isSuccess {
                self.countries = countries!
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
        return self.countries.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.countries[indexPath.row].name
        cell.detailTextLabel?.text = self.countries[indexPath.row].code
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.completion(self.countries[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismiss(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}
