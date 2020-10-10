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

    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var commentText: UITextView!

    @IBOutlet weak var currentTime: UILabel!
    
    //0分0秒
    var time: [Int] = [1,0]
    var addtimer = Timer()
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func timerStart(){
        currentTime.text = String(time[0]) + ":" + String(time[1])
        addtimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(progress), userInfo: nil, repeats: true)
        
    }
    func timerstop(){
        addtimer.invalidate()
    }
    
    @objc func progress(){
        if (time[0] == 0 && time[1] == 0){
            addtimer.invalidate()
        } else if (time[1] > 0){
            time[1] -= 1
            
        } else {
            time[1] += 59
            
            if (time[0] > 0) {
                time[0] -= 1
                
            }
        }
        currentTime.text = String(time[0]) + ":" + String(time[1])
        
    }

    // キーボードを閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
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


