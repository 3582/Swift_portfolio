//
//  TimeLineViewController.swift
//  Swift_portfolio
//
//  Created by Yu Watanabe on 2020/09/19.
//  Copyright © 2020 yu_w. All rights reserved.
//

import UIKit

class TimeLineViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var timeLineTable: UITableView!
    
    var userName = String()
    var userImageDate = Data()
    var userImage = UIImage()
    var tileString = String()
    var createDate = String()
    var userImageProfileImageString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLineTable.delegate = self
        timeLineTable.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
