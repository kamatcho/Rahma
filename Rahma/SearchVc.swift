//
//  SearchVc.swift
//  Rahma
//
//  Created by MOHAMED on 3/15/17.
//  Copyright © 2017 Amr Mohamed. All rights reserved.
//

import UIKit
import SwiftyJSON

class SearchVc: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var Persons = [SearchModel]()
    var serviceKind :String!
    var country :String!
    var city : String!
    var time : String!
    var date : String!
    var address : String!
    var status_kind : String!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        tableView.register(UINib.init(nibName: "SearchCell", bundle: nil), forCellReuseIdentifier: "SearchCell")
        print(country)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return Persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchCell else {return UITableViewCell()}
        let person = Persons[indexPath.row]
        cell.ConfigureCell(SearchData: person)
        return cell
    }
    
    
    func loadData(){
        APIHelper.PationtSerach(serviceKind: serviceKind, country: country, city: city, time: time, date: date, address: address, status_kind: status_kind) { (error) in
        }
    }
 
}
