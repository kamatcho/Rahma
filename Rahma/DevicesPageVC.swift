//
//  DevicesPageViewController.swift
//  Rahma
//
//  Created by Amr Mohamed on 1/8/17.
//  Copyright © 2017 Amr Mohamed. All rights reserved.
//

import UIKit

class DevicesPageViewController: UIPageViewController {
    
    weak var segmentedControl: UISegmentedControl! {
        didSet {
            self.segmentedControl.addTarget(self, action: #selector(self.segmentedControlValueChanged), for: .valueChanged)
        }
    }
    
    var pages = [UITableViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        
        let page1 = DevicesTableViewController(style: .grouped, deviceType: .donation)
        let page2 = DevicesTableViewController(style: .grouped, deviceType: .sale)
        let page3 = DevicesTableViewController(style: .grouped, deviceType: .rent)
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        self.setViewControllers([page1], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func segmentedControlValueChanged() {
        let prevIndex = self.indexOfViewController(self.viewControllers!.first! as! UITableViewController)
        let newIndex = self.segmentedControl.selectedSegmentIndex
        
        let isForward = newIndex > prevIndex
        
        let page = self.pages[self.segmentedControl.selectedSegmentIndex]
        self.setViewControllers([page], direction: isForward ? .forward : .reverse, animated: true, completion: nil)
    }
    
}

extension DevicesPageViewController : UIPageViewControllerDataSource , UIPageViewControllerDelegate {
    
    func viewControllerAtIndex(_ index: Int) -> UIViewController? {
        if (self.pages.count == 0) || (index >= self.pages.count) {
            return nil
        }
        
        return self.pages[index]
    }
    
    func indexOfViewController(_ viewController: UITableViewController) -> Int {
        if let index = self.pages.index(of: viewController) {
            return index
        }
        return NSNotFound
    }
    
    // MARK: - Page View Controller Data Source
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! UITableViewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index -= 1
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! UITableViewController)
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        if index == self.pages.count {
            return nil
        }
        
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let index = self.indexOfViewController(self.viewControllers!.first! as! UITableViewController)
        self.segmentedControl.selectedSegmentIndex = index
    }
    
}

