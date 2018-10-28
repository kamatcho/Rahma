//
//  DevicesViewController.swift
//  Rahma
//
//  Created by Amr Mohamed on 1/8/17.
//  Copyright © 2017 Amr Mohamed. All rights reserved.
//

import UIKit

class DevicesViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    lazy var devicesPageVC : DevicesPageViewController = {
        return self.childViewControllers.first as! DevicesPageViewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DevicesPageViewController {
            destination.segmentedControl = self.segmentedControl
        }
    }
    
}
