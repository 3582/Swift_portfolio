//
//  RankingViewController.swift
//  Swift_portfolio
//
//  Created by Yu Watanabe on 2020/11/15.
//  Copyright © 2020 yu_w. All rights reserved.
//

import UIKit

import UIKit
import SDWebImage
import Alamofire
import SwiftyJSON

class RankingViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource, UIAdaptivePresentationControllerDelegate,TabBarDelegate{
    func didSelectTab(tabBarController: TabBarController) {
    }
    
    @IBOutlet weak var rankingTable: UITableView!
    
    var posts: [[String: String?]] = []
    var totalcount: [[String: Int?]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rankingTable.delegate = self
        rankingTable.dataSource = self
        // Do any additional setup after loading the view.
        postsapi(apiname:"total",limit:10)
    }
    func postsapi(apiname:String,limit:Int){
        Alamofire.request("http://localhost:3000/api/v1/posts/ranking/\(apiname)/\(limit)", method: .get).responseJSON { response in
            guard let object = response.result.value else {
                return
            }
            let json = JSON(object)
            json.forEach { (_, json) in
                let posts: [String: String?] = [
                    "title": json["title"].string,
                    "tag_name": json["tag_name"].string,
                    "name": json["name"].string,
                    "created_at": json["created_at"].string,
                    
                ]
                let totalcount: [String: Int?] = [
                    "total": json["total"].int,
                ]
                self.posts.append(posts)
                self.totalcount.append(totalcount)
            }
            self.rankingTable.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = rankingTable.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let titleLabel = cell.viewWithTag(1) as! UILabel
        let nameLabel = cell.viewWithTag(2) as! UILabel
        let tagLabel = cell.viewWithTag(3) as! UILabel
        let totalLabel = cell.viewWithTag(4) as! UILabel
        let created_atLabel = cell.viewWithTag(5) as! UILabel
        
        let postsindex = posts[indexPath.row]
        let totalindex = totalcount[indexPath.row]
        
        let created_at = postsindex["created_at"]!
        let from = created_at!.index(created_at!.startIndex, offsetBy:0)
        let to = created_at!.index(created_at!.startIndex, offsetBy:10)
        let newString = String(created_at![from..<to])
        
        titleLabel.text = postsindex["title"]!
        nameLabel.text = postsindex["name"]!
        tagLabel.text = postsindex["tag_name"]!
        totalLabel.text = "total:" + String(totalindex["total"]! ?? 0)
        created_atLabel.text = newString
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return view.frame.size.height/6
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
