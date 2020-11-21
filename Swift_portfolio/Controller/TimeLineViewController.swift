//
//  TimeLineViewController.swift
//  Swift_portfolio
//
//  Created by Yu Watanabe on 2020/09/19.
//  Copyright © 2020 yu_w. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire
import SwiftyJSON

class TimeLineViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource, UIAdaptivePresentationControllerDelegate,TabBarDelegate{
    func didSelectTab(tabBarController: TabBarController) {
    }
    
    @IBOutlet weak var timeLineTable: UITableView!
    
    var contentsArray = [Contents]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLineTable.delegate = self
        timeLineTable.dataSource = self
        // Do any additional setup after loading the view.
        rankingAPI(apiname: "recent", limit: "5")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = timeLineTable.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let userNameLabel = cell.viewWithTag(2) as! UILabel
        userNameLabel.text = contentsArray[indexPath.row].userNameString
        
        let titleLabel = cell.viewWithTag(4) as! UILabel
        titleLabel.text = contentsArray[indexPath.row].titleString
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 600
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }    
    
    func rankingAPI(apiname:String,limit:String){
        
        Alamofire.request("http://localhost:3000/api/v1/posts/\(apiname)/\(limit)", method: .get).responseJSON { response in
            print("Response: \(String(describing: response.description))")
        }
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
