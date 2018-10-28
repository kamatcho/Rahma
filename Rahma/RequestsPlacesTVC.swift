//
//  RequestsPlacesTableViewController.swift
//  Rahma
//
//  Created by Amr Mohamed on 1/14/17.
//  Copyright © 2017 Amr Mohamed. All rights reserved.
//

import UIKit

class RequestsPlacesTableViewController: UITableViewController {
    
    var requestType: APIRequestType!
    
    var users = [APIRequest]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        self.registerHospitalTVCell()
        self.title = self.requestType.title
        self.getHospitals()
    }
    
    func getHospitals() {
        self.addText(" ")
        self.view.showActivityIndicator()
        APIHelper.getRequests(type: self.requestType) { (status, users) in
            if status.isSuccess {
                self.users = users!
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
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTVCell.identifier, for: indexPath) as! UserTVCell
        _ = self.users[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
