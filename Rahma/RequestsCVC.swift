//
//  RequestsCollectionViewController.swift
//  Rahma
//
//  Created by Amr Mohamed on 1/6/17.
//  Copyright © 2017 Amr Mohamed. All rights reserved.
//

import UIKit


class RequestsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (self.view.frame.height / 3) - 5
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
}


class RequestsCollectionViewController: UICollectionViewController {
    
    var data: [APIRequestType] = [.therapists, .partners, .drivers , .events , .resturants , .entertainments]
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        let itemWidth = self.view.frame.width / 2
        let itemHeight = (self.collectionView!.frame.width / 2)
        (self.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = CGSize(width: itemWidth, height: itemHeight)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let textLabel = cell.viewWithTag(444) as! UILabel
        let imageView = cell.viewWithTag(555) as! UIImageView
        
        textLabel.text = self.data[indexPath.row].title
        imageView.image = self.data[indexPath.row].image
        imageView.backgroundColor = self.data[indexPath.row].color
        imageView.tintColor = UIColor.white
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionView?.deselectItem(at: indexPath, animated: true)
        if indexPath.row <= 2 {
            self.segueToRequestsUsers(indexPath: indexPath)
        } else {
            self.segueToRequestsPlaces(indexPath: indexPath)
        }
    }
    
    func segueToRequestsUsers(indexPath: IndexPath) {
        let destination = RequestsUsersTableViewController(style: .grouped)
        destination.requestType = self.data[indexPath.row]
        self.show(destination, sender: nil)
    }
    
    func segueToRequestsPlaces(indexPath: IndexPath) {
        let destination = RequestsPlacesTableViewController(style: .grouped)
        destination.requestType = self.data[indexPath.row]
        self.show(destination, sender: nil)
    }
}
