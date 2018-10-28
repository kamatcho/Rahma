//
//  LanguageTableViewController.swift
//  Kreaz
//
//  Created by Amr Mohamed on 10/20/16.
//  Copyright © 2016 Amr Mohamed. All rights reserved.
//

import UIKit

class LanguageTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentlang = UserDefaults.standard.array(forKey: "AppleLanguages")?.first as! String
        var cell : UITableViewCell!
        if currentlang == "ar" {
            cell = super.tableView(self.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        } else if currentlang == "en" {
            cell = super.tableView(self.tableView, cellForRowAt: IndexPath(row: 1, section: 0))
        }
        
        if cell != nil {
            cell.accessoryType = .checkmark
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        let currentlang = UserDefaults.standard.array(forKey: "AppleLanguages")?.first as! String
        
        if currentlang == "ar" && indexPath.row == 0 {
            return
        }
        
        if currentlang == "en" && indexPath.row == 1 {
            return
        }
        
        
    }
}
