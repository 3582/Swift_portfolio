//
//  AuthViewController.swift
//  Swift_portfolio
//
//  Created by Yu Watanabe on 2020/09/12.
//  Copyright © 2020 yu_w. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AuthViewController: UIViewController {
    
    @IBOutlet weak var user_name: UITextField!
    @IBOutlet weak var user_email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var password_confirmation: UITextField!
    
    var accesstoken: String!
    var client: String!
    var uid:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signup_button(_ sender: Any) {
        var params: [String: String] = [:]
        params["user_name"] = user_name.text!
        params["email"] = user_email.text!
        params["password"] = password.text!
        params["password_confirmation"] = password_confirmation.text!
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
