//
//  PagingMenuViewController.swift
//  Swift_portfolio
//
//  Created by Yu Watanabe on 2020/11/15.
//  Copyright © 2020 yu_w. All rights reserved.
//

import UIKit
import Tabman
import Pageboy

class PagingMenuViewController: TabmanViewController {
    private var viewControllers = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self

        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        bar.layout.contentMode = .fit

        addBar(bar, dataSource: self, at: .top)
        // Do any additional setup after loading the view.
    }
    private func setTabsControllers() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ViewController1 = storyboard.instantiateViewController(withIdentifier: "TimeLine")
        let ViewController2 = storyboard.instantiateViewController(withIdentifier: "Ranking")
        let ViewController3 = storyboard.instantiateViewController(withIdentifier: "TagView")
        
        viewControllers = [
            ViewController1,
            ViewController2,
            ViewController3
            ]
        }
    
}
extension PagingMenuViewController: PageboyViewControllerDataSource, TMBarDataSource{
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let titilename = ["最新","積み上げ数","タグ検索"]
        var items = [TMBarItem]()

        for i in titilename {
            let title = TMBarItem(title: i)
            items.append(title)
        }
        return items[index]
    }

    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        setTabsControllers()
        return viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }

    func barItem(for tabViewController: TabmanViewController, at index: Int) -> TMBarItemable {
        return TMBarItem(title: "Page \(index)")
    }


}
