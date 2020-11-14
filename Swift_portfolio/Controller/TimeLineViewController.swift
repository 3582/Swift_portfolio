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
        rankingAPI(apiname: "recent", limit: "3")
    }
    
    @IBOutlet weak var timeLineTable: UITableView!
    
    var userName = String()
    var userImageDate = Data()
    var userImage = UIImage()
    var tileString = String()
    var createDate = String()
    var userImageProfileImageString = String()
    
    var contentsArray = [Contents]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLineTable.delegate = self
        timeLineTable.dataSource = self

        print("timeline")
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = timeLineTable.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let profileImageView = cell.viewWithTag(1) as! UIImageView
        profileImageView.sd_setImage(with: URL(string: contentsArray[indexPath.row].userImageString), completed:nil )
        profileImageView.layer.cornerRadius = 30.00
        
        let userNameLabel = cell.viewWithTag(2) as! UILabel
        userNameLabel.text = contentsArray[indexPath.row].userNameString
        
        let dateLabel = cell.viewWithTag(3) as! UILabel
        dateLabel.text = contentsArray[indexPath.row].postDateString
        
        let titleLabel = cell.viewWithTag(4) as! UILabel
        titleLabel.text = contentsArray[indexPath.row].titleString
        
        let contentImageView = cell.viewWithTag(5) as! UIImageView
        contentImageView.sd_setImage(with: URL(string: contentsArray[indexPath.row].contentImageString), completed:nil )
        contentImageView.layer.cornerRadius = 20.00
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 600
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }    

    @IBAction func profileButton(_ sender: Any) {
        let authVC = storyboard?.instantiateViewController(withIdentifier: "Auth") as! AuthViewController
        authVC.presentationController?.delegate = self

        self.present(authVC, animated: true, completion: nil)
    }
    
    func rankingAPI(apiname:String,limit:String){
        
        Alamofire.request("http://localhost:3000/api/v1/posts/\(apiname)/\(limit)", method: .get).responseJSON { response in
            print("Request: \(String(describing: response.request))")
            print("Response: \(String(describing: response.response))")
            print("Response: \(String(describing: response.description))")
            print("Error: \(String(describing: response.error))")
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
