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
    
    var posts: [[String: String?]] = []
    var totalcount: [[String: Int?]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLineTable.delegate = self
        timeLineTable.dataSource = self
        // Do any additional setup after loading the view.
        api()
    }
    func api(){
        Alamofire.request("http://localhost:3000/api/v1/posts/recent/5", method: .get).responseJSON { response in
            guard let object = response.result.value else {
                return
            }
            let json = JSON(object)
            json.forEach { (_, json) in
                let posts: [String: String?] = [
                    "title": json["title"].string,
                    "created_at": json["created_at"].string,
                    
                ]
                let totalcount: [String: Int?] = [
                    "total": json["total"].int,
                ]
                self.posts.append(posts)
                self.totalcount.append(totalcount)
            }
            self.timeLineTable.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = timeLineTable.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
//        let userNameLabel = cell.viewWithTag(2) as! UILabel
//        userNameLabel.text =
        
        let titleLabel = cell.viewWithTag(1) as! UILabel
        let totalLabel = cell.viewWithTag(4) as! UILabel
        let createdatLabel = cell.viewWithTag(5) as! UILabel
        
        let postsindex = posts[indexPath.row]
        let totalindex = totalcount[indexPath.row]
        
        titleLabel.text = postsindex["title"]!
        totalLabel.text = "total:" + String(totalindex["total"]!!)
        createdatLabel.text = postsindex["created_at"]!
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return view.frame.size.height/10
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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
