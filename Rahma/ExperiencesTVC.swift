//
//  ExperiencesTableViewController.swift
//  Rahma
//
//  Created by Amr Mohamed on 1/12/17.
//  Copyright © 2017 Amr Mohamed. All rights reserved.
//

import UIKit

class ExperiencesTableViewController: UITableViewController {

    var experiences = [APIExperience]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        self.registerExperienceTVCell()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(self.getExperiences), for: .valueChanged)
        
        self.getExperiences()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getExperiences() {
        if self.refreshControl!.isRefreshing {
            self.refreshControl?.endRefreshing()
        }
        self.experiences.removeAll(keepingCapacity: true)
        self.tableView.reloadData()
        self.addText(" ")
        self.view.showActivityIndicator()
        APIHelper.getExperiences { (status, experiences) in
            if status.isSuccess {
                self.experiences = experiences!
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
        return self.experiences.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExperienceTVCell.identifier, for: indexPath) as! ExperienceTVCell
        cell.setupCell(self.experiences[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
