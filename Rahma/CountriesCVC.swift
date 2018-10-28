//
//  TherapyCollectionViewController.swift
//  Rahma
//
//  Created by Amr Mohamed on 1/6/17.
//  Copyright © 2017 Amr Mohamed. All rights reserved.
//

import UIKit
import Haneke

class CountriesCollectionViewController: UICollectionViewController {
    var itemwidth : CGFloat?
    var countries = [APICountry]()
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screewidth = self.view.frame.width
        if screewidth > 400 {
             self.itemwidth = screewidth / 3
        }else {
             self.itemwidth = screewidth / 2
        }
        
        (self.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = CGSize(width: itemwidth!, height: itemwidth!)
        self.setupRefreshCcntrol()
        self.getCountries()
    }
    
    func setupRefreshCcntrol() {
        self.refreshControl = UIRefreshControl()
        self.collectionView?.addSubview(self.refreshControl)
        self.refreshControl.addTarget(self, action: #selector(self.getCountries), for: .valueChanged)
    }
    
    func getCountries() {
        if self.refreshControl.isRefreshing {
            self.refreshControl.endRefreshing()
        }
        
        self.countries.removeAll(keepingCapacity: true)
        
        self.addText(" ")
        self.view.showActivityIndicator()
        APIHelper.getCountries { (status, countries) in
            if status.isSuccess {
                self.countries = countries!
            } else {
                self.addText(status.message)
            }
            self.collectionView?.reloadData()
            self.view.hideActivityIndicator()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.countries.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        let textLabel = cell.viewWithTag(444) as! UILabel
        let imageView = cell.viewWithTag(555) as! UIImageView
        
        let country = self.countries[indexPath.row]
        textLabel.text = country.name
        
        if let url = URL.init(string: country.image) {
            imageView.image = nil
            imageView.showActivityIndicator(shouldAdjustYAxis: false)
            imageView.hnk_setImageFromURL(url, failure: { error in
                imageView.hideActivityIndicator()
            }, success: { image in
                imageView.image = image
                imageView.hideActivityIndicator()
            })
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? HospitalsViewController {
            dest.country = self.countries[self.collectionView!.indexPathsForSelectedItems!.first!.row]
        }
    }
    
}
