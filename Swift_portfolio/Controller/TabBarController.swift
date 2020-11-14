//
//  TabBarController.swift
//  Swift_portfolio
//
//  Created by Yu Watanabe on 2020/11/14.
//  Copyright © 2020 yu_w. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController is TabBarDelegate {
            let v = viewController as! TabBarDelegate
            v.didSelectTab(tabBarController: self)
        }
    }
}
