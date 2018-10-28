//
//  EnquiriesTableViewController.swift
//  Rahma
//
//  Created by Amr Mohamed on 1/10/17.
//  Copyright © 2017 Amr Mohamed. All rights reserved.
//

import UIKit

class EnquiriesTableViewController: UITableViewController {
    
    var enquiries = [APIEnquiry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        self.registerEnquiriesTVCell()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(self.getEnquiries), for: .valueChanged)
        
        self.getEnquiries()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getEnquiries() {
        if self.refreshControl!.isRefreshing {
            self.refreshControl?.endRefreshing()
        }
        self.enquiries.removeAll(keepingCapacity: true)
        self.tableView.reloadData()
        self.addText(" ")
        self.view.showActivityIndicator()
        APIHelper.getEnquiries { (status, enquiries) in
            if status.isSuccess {
                self.enquiries = enquiries!
            } else {
                self.addText(status.message)
            }
            self.tableView.reloadData()
            self.view.hideActivityIndicator()
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.enquiries.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EnquiriesTVCell.identifier, for: indexPath) as! EnquiriesTVCell
        
        let enquiry = self.enquiries[indexPath.row]
        cell.titleTextLabel.text = enquiry.title
        cell.bodyTextLabel.text = enquiry.body
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
