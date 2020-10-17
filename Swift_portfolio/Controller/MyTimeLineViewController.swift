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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTable.delegate = self
        taskTable.dataSource = self
        taskText.delegate = self
        
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
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height/10
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postVC = PostViewController()
        let rootVC = UIApplication.shared.windows.first?.rootViewController as? UITabBarController
        let navigationController = rootVC?.children[0] as? UINavigationController

        rootVC?.selectedIndex = 0
        navigationController?.pushViewController(postVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textArray.append(taskText.text!)
        taskText.resignFirstResponder()
        taskText.text = ""
        taskTable.reloadData()
        
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
