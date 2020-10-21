//
//  MyTimeLineViewController.swift
//  Swift_portfolio
//
//  Created by Yu Watanabe on 2020/10/07.
//  Copyright © 2020 yu_w. All rights reserved.
//

import UIKit

class MyTimeLineViewController: UIViewController,UITableViewDelegate,UITableViewDataSource ,UITextFieldDelegate{
    

    @IBOutlet weak var taskTable: UITableView!
    @IBOutlet weak var taskText: UITextField!
    
    var textArray = [String]()
    var totalArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTable.delegate = self
        taskTable.dataSource = self
        taskText.delegate = self
        
//        let appDomain = Bundle.main.bundleIdentifier
//        UserDefaults.standard.removePersistentDomain(forName: appDomain!)
        
        if UserDefaults.standard.object(forKey: "TodoList") != nil{
            textArray = UserDefaults.standard.object(forKey: "TodoList") as! [String]
        }
        
        if UserDefaults.standard.object(forKey: "TotalList") != nil{
            totalArray = UserDefaults.standard.object(forKey: "TotalList") as! [String]
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return textArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = taskTable.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = textArray[indexPath.row]
        
        let totalLabel = cell.viewWithTag(1) as! UILabel
        if UserDefaults.standard.object(forKey: "TotalList") != nil{
            totalLabel.text = totalArray[indexPath.row]
        } else {
            
            totalLabel.text = "total:0"
        }

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height/10
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postVC = storyboard?.instantiateViewController(withIdentifier: "Post") as! PostViewController
//        let rootVC = UIApplication.shared.windows.first?.rootViewController as? UITabBarController
//        let navigationController = rootVC?.children[0] as? UINavigationController
//        rootVC?.selectedIndex = 0
//        navigationController?.pushViewController(postVC, animated: true)
        postVC.indexInt = indexPath.row
        postVC.mylistBool = true
        self.present(postVC, animated: true, completion: nil)
        //ハイライト設定
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textArray.append(taskText.text!)
        totalArray.append("total:0")
        
        taskText.resignFirstResponder()
        taskText.text = ""
        taskTable.reloadData()
        
        UserDefaults.standard.set(textArray, forKey: "TodoList")
        UserDefaults.standard.set(totalArray, forKey: "TotalList")
        
        return true
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
