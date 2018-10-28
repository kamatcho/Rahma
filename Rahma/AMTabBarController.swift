//
//  AMTabBarController.swift
//  Ekeif
//
//  Created by Amr Mohamed on 9/14/16.
//  Copyright © 2016 Amr Mohamed. All rights reserved.
//

import UIKit

class AMTabBarController: UITabBarController , UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        // get the size of each tabBarItem
        let itemSize = CGSize(width: tabBar.frame.width / 5, height: tabBar.frame.height)
        
        // set the positioning to fill the whole width of the tabBar
        self.tabBar.itemPositioning = .fill
        
        // generate and set selectionIndicatorImage
        let renderer = UIGraphicsImageRenderer(size: itemSize)
        self.tabBar.selectionIndicatorImage = renderer.image { ctx in
            ctx.cgContext.setFillColor(UIColor.white.cgColor)
            ctx.fill(CGRect(origin: CGPoint.zero, size: itemSize))
        }
        
        self.tabBar.tintColor = #colorLiteral(red: 0.1776479185, green: 0.6607227325, blue: 0.7170882821, alpha: 1)
        self.tabBar.unselectedItemTintColor = UIColor.white.withAlphaComponent(0.8)
        
        // set the tabBar title font
        for item in self.tabBar.items! {
            item.setTitleTextAttributes([NSFontAttributeName : UIFont.init(name: "GE SS", size: 11)!], for: .normal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var didClickOnce = false
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if didClickOnce {
            if let nav = viewController as? UINavigationController {
                if let tvc = nav.viewControllers.first! as? UITableViewController {
                    tvc.tableView.setContentOffset(CGPoint.zero, animated: true)
                }
                if let tvc = nav.viewControllers.first! as? UICollectionViewController {
                    tvc.collectionView?.setContentOffset(CGPoint.zero, animated: true)
                }
            }
        }
        
        self.didClickOnce = true
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { _ in
            self.didClickOnce = false
        })
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if APIUser.isUserAvailabelOnDefaults {
            return true
        }
        let index = self.viewControllers!.index(of: viewController)!
        if index == 4 {
            let alert = UIAlertController(title: "يجب عليك تسجيل الدخول أولاً", message: nil, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction.init(title: "تسجيل الدخول", style: .destructive, handler: { (action) in
                self.segueToLoginTVC()
            }))
            
            alert.addAction(UIAlertAction.init(title: "إلغاء", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            return false
        }
        return true
    }
    
}
