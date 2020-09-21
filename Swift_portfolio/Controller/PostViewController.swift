//
//  PostViewController.swift
//  Swift_portfolio
//
//  Created by Yu Watanabe on 2020/09/20.
//  Copyright © 2020 yu_w. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PostViewController: UIViewController {

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var commentText: UITextView!
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func sendButton(_ sender: Any) {
        var headers: [String:String] = [:]
        var params: [String: String] = [:]
        
        headers["access-token"] = appDelegate.accesstoken
        headers["client"] = appDelegate.client
        headers["uid"] = appDelegate.uid
        
        params["title"] = titleText.text!
        params["text"] = commentText.text!
        
        Alamofire.request("http://localhost:3000/api/v1/posts", method: .post, parameters: params, headers: headers).responseJSON { response in
            
            print("Request: \(String(describing: response.request))")
            print("Response: \(String(describing: response.response))")
            
            if response.response?.statusCode == 200 {
                print("success")
                
            } else {
                print("Error: \(String(describing: response.error))")

            }
        }
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


