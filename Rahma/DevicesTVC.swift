//
//  DonationDevicesTableViewController.swift
//  Rahma
//
//  Created by Amr Mohamed on 1/8/17.
//  Copyright © 2017 Amr Mohamed. All rights reserved.
//

import UIKit

class DevicesTableViewController: UITableViewController {
    
    var deviceType: APIDeviceType!
    var devices = [APIDevice]()
    var images = [UIImage]()
    
    init(style: UITableViewStyle, deviceType: APIDeviceType) {
        super.init(style: style)
        self.deviceType = deviceType
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        self.registerDeviceTVCell()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(self.getHospitals), for: .valueChanged)
        
        self.getHospitals()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getHospitals() {
        if self.refreshControl!.isRefreshing {
            self.refreshControl?.endRefreshing()
        }
        self.devices.removeAll(keepingCapacity: true)
        self.tableView.reloadData()
        self.addText(" ")
        self.view.showActivityIndicator()
        APIHelper.getDevices(type: self.deviceType, country: "") { (status, devices) in
            if status.isSuccess {
                self.devices = devices!
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
        return self.devices.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DeviceTVCell.identifier, for: indexPath) as! DeviceTVCell
        cell.setupCell(self.devices[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
