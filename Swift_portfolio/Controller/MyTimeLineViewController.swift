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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTable.delegate = self
        taskTable.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height/7
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
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
