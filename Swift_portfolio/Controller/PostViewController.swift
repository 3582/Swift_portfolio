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
import AudioToolbox

class PostViewController: UIViewController, UITextFieldDelegate{
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var commentText: UITextView!

    @IBOutlet weak var taskButton: UIButton!
    @IBOutlet weak var currentTime: UILabel!
    
    @IBOutlet weak var refreshB: UIButton!
    
    var time: [Int] = [0,0]
    var minute = String()
    var second = String()
    var addtimer = Timer()
    var starting = false
    var indexInt = Int()
    var mylistBool = false
    var refresh = false
    var task = false
    
    var textArray = [String]()
    var totalArray = [String]()

    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshB.isHidden = true
        
        titleText.delegate = self
        
        if UserDefaults.standard.object(forKey: "TodoList") != nil{
            textArray = UserDefaults.standard.object(forKey: "TodoList") as! [String]
        }
        
        if UserDefaults.standard.object(forKey: "TotalList") != nil{
            totalArray = UserDefaults.standard.object(forKey: "TotalList") as! [String]
        }
        if mylistBool == true {
                titleText.text = textArray[indexInt]
                totalLabel.text = totalArray[indexInt]
        }
        
        // Do any additional setup after loading the view.
    }
    
    func timerStart(){
        getTime()
        addtimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(progress), userInfo: nil, repeats: true)
        
    }
    
    @objc func progress(){
        if (time[0] == 0 && time[1] == 0){
            var soundIdRing:SystemSoundID = 1000
            if let soundUrl = CFBundleCopyResourceURL(CFBundleGetMainBundle(), nil, nil, nil){
                   AudioServicesCreateSystemSoundID(soundUrl, &soundIdRing)
                   AudioServicesPlaySystemSound(soundIdRing)
                
            }
            
            taskButton.setTitle("START", for: .normal)
            
            starting = false
            addtimer.invalidate()
            
            if refresh == true {
                refresh = false
                
            } else if task == true {
                plusTotal()
                refreshB.isHidden = false
                
                task = false
            }
            
            if mylistBool == false {
                textArray.append(titleText.text!)
                UserDefaults.standard.set(textArray, forKey: "TodoList")
                totalArray.append(totalLabel.text!)
                UserDefaults.standard.set(totalArray, forKey: "TotalList")
                
            }else{
                textArray[indexInt] = titleText.text!
                UserDefaults.standard.set(textArray, forKey: "TodoList")
                totalArray[indexInt] = totalLabel.text!
                UserDefaults.standard.set(totalArray, forKey: "TotalList")
            }
            

        } else if (time[1] > 0){
            time[1] -= 1
            
        } else {
            time[1] += 59
            
            if (time[0] > 0) {
                time[0] -= 1
                
            }

        }
        minute = String(time[0])
        second = String(time[1])
        
        if time[0] >= 0 && time[0] < 10 {
            minute = "0" + minute
        }
        if time[1] >= 0 && time[1] < 10 {
            second = "0" + second
        }
        
        currentTime.text = minute + ":" + second
    }

    // キーボードを閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textArray[indexInt] = titleText.text!
        UserDefaults.standard.set(textArray, forKey: "TodoList")
        
        
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func startButton(_ sender: Any) {
        if currentTime.text == "00:00" {
            currentTime.text = "25:00"
            refreshB.isHidden = true
        }
        if starting == false {
            taskButton.setTitle("STOP", for: .normal)
            starting = true
            timerStart()
            task = true
            
        }else{
            taskButton.setTitle("START", for: .normal)
            starting = false
            
            addtimer.invalidate()
        }
    }
    @IBAction func refreshButton(_ sender: Any) {
        currentTime.text = "05:00"
        refreshB.isHidden = true
        refresh = true
        
        taskButton.setTitle("STOP", for: .normal)
        starting = true
        timerStart()
        
    }
    
    //合計回数加算
    func plusTotal(){
        let from = totalLabel.text!.index(totalLabel.text!.startIndex, offsetBy:0)
        let to = totalLabel.text!.index(totalLabel.text!.startIndex, offsetBy: 6)
        
        let from_time = totalLabel.text!.index(totalLabel.text!.startIndex, offsetBy:6)
        let to_time = totalLabel.text!.index(totalLabel.text!.startIndex, offsetBy: totalLabel.text!.count)
        
        let total_time = Int(totalLabel.text![from_time..<to_time])! + 1
        
        totalLabel.text = totalLabel.text![from..<to] + String(total_time)
    }
    
    //labelから時間取得
    func getTime() {
        let from = totalLabel.text!.index(totalLabel.text!.startIndex, offsetBy:0)
        let to = totalLabel.text!.index(totalLabel.text!.startIndex, offsetBy: 2)
        
        let from_s = totalLabel.text!.index(totalLabel.text!.startIndex, offsetBy:3)
        let to_s = totalLabel.text!.index(totalLabel.text!.startIndex, offsetBy: 5)
        
        let minute_int = Int(currentTime.text![from..<to])!
        let second_int = Int(currentTime.text![from_s..<to_s])!
        
        time[0] = minute_int
        time[1] = second_int
    }
    
    

    
//    @IBAction func sendButton(_ sender: Any) {
//        var headers: [String:String] = [:]
//        var params: [String: String] = [:]
//
//        headers["access-token"] = appDelegate.accesstoken
//        headers["client"] = appDelegate.client
//        headers["uid"] = appDelegate.uid
//
//        params["title"] = titleText.text!
//        params["text"] = commentText.text!
//
//        Alamofire.request("http://localhost:3000/api/v1/posts", method: .post, parameters: params, headers: headers).responseJSON { response in
//
//            print("Request: \(String(describing: response.request))")
//            print("Response: \(String(describing: response.response))")
//
//            if response.response?.statusCode == 200 {
//                print("success")
//
//            } else {
//                print("Error: \(String(describing: response.error))")
//
//            }
//        }
//    }
}
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


