//
//  AppDelegate.swift
//  Rahma
//
//  Created by Amr Mohamed on 12/29/16.
//  Copyright © 2016 Amr Mohamed. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UILabel.appearance().substituteFontName = "GE SS"
        UITextView.appearance().substituteFontName = "GE SS"
        UINavigationBar.appearance().substituteFontName = ("GE SS", 20.0)
        UISegmentedControl.appearance().fontName = "GE SS"
        return true
    }
    
}

struct AppColors {
    static let mainColor = #colorLiteral(red: 0.1776479185, green: 0.6607227325, blue: 0.7170882821, alpha: 1)
    static let actionColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
    static let backgroundColor = #colorLiteral(red: 0.1843137255, green: 0.2549019608, blue: 0.3490196078, alpha: 1)
}
