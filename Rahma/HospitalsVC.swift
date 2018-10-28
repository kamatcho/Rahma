//
//  AdsViewController.swift
//  Etoggar
//
//  Created by Amr Mohamed on 12/26/16.
//  Copyright © 2016 Amr Mohamed. All rights reserved.
//

import UIKit

class HospitalsViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    lazy var therapyPageVC : HospitalsPageViewController = {
        return self.childViewControllers.first as! HospitalsPageViewController
    }()
    
    var country: APICountry!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.country.name
         
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? HospitalsPageViewController {
            dest.segmentedControl = self.segmentedControl
            dest.country = self.country
        }
    }
}
