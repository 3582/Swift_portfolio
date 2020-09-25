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

class AuthViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var user_name: UITextField!
    @IBOutlet weak var user_email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var password_confirmation: UITextField!
    
    @IBOutlet weak var albumImage: UIImageView!
    
    var accesstoken: String!
    var client: String!
    var uid:String!
    var current_user_id:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    // キーボードを閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //画像選択
    var picker: UIImagePickerController! = UIImagePickerController()
    @IBAction func albumAction(_ sender: Any) {
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        picker.delegate = self
        present(picker, animated: true, completion: nil)
        
    }
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        if let image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage {
            albumImage.image = image
            
        } else{
            print("Error")
        }

        // モーダルビューを閉じる
        self.dismiss(animated: true, completion: nil)
    }

     //画像選択がキャンセルされた時に呼ばれる.
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {

        // モーダルビューを閉じる
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func login_success() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Post") as! PostViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func signin_button(_ sender: Any) {
        var params: [String: String] = [:]
        params["email"] = user_email.text!
        params["password"] = password.text!
        params["password_confirmation"] = password_confirmation.text!
        
        Alamofire.request("http://localhost:3000/api/v1/auth/sign_in", method: .post, parameters: params).responseJSON { response in
            print("Request: \(String(describing: response.request))")
            print("Response: \(String(describing: response.response))")
            
            //エラーがなかった場合
            if response.response?.statusCode == 200 {
                self.login_success()

                //responseからヘッダー情報を取り出して変数に保存する
                self.accesstoken = (response.response?.allHeaderFields["access-token"] as? String)!
                self.client = (response.response?.allHeaderFields["client"] as? String)!
                self.uid = (response.response?.allHeaderFields["uid"] as? String)!

                //通信後にこれらの情報を取ってこれていた場合は
                if self.accesstoken != nil && self.client != nil && self.uid != nil {
                    print("current_user_id保存成功_signin")

                    //responseから保存したアカウントデータのIDを抜き出す
                    let json:JSON = JSON(response.result.value ?? kill)
                    json.forEach { (arg) in
                        let (_, json) = arg
                        self.current_user_id = json["id"].intValue
                    }

                    let current_user_id: Int = self.current_user_id
                    let accesstoken: String = self.accesstoken
                    let client: String = self.client
                    let uid: String = self.uid

                    print("accesstoken: \(String(describing: accesstoken))")
                    print("client: \(String(describing: client))")
                    print("uid: \(String(describing: uid))")
                    print("CurrentUserID: \(String(describing: current_user_id))")

                    let current_user = Currentuser()
                    
                    //パラメーターセット
                    current_user.current_user_id = current_user_id

                    //appDelegateに上げる
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.current_user_id = current_user
                    appDelegate.accesstoken = accesstoken
                    appDelegate.client = client
                    appDelegate.uid = uid

                }
                //エラーがあった場合
            } else {
                print("Error: \(String(describing: response.error))")
                
            }
        }
    }
    
    
    @IBAction func signup_button(_ sender: Any) {
        var params: [String: String] = [:]
        params["name"] = user_name.text!
        params["email"] = user_email.text!
        params["password"] = password.text!
        params["password_confirmation"] = password_confirmation.text!
        
        Alamofire.request("http://localhost:3000/api/v1/auth", method: .post, parameters: params).responseJSON { response in
            print("Request: \(String(describing: response.request))")
            print("Response: \(String(describing: response.response))")
            print("Error: \(String(describing: response.error))")

            //エラーがなかった場合
            if response.response?.statusCode == 200 {
                self.login_success()

                //responseからヘッダー情報を取り出して変数に保存する
                self.accesstoken = (response.response?.allHeaderFields["access-token"] as? String)!
                self.client = (response.response?.allHeaderFields["client"] as? String)!
                self.uid = (response.response?.allHeaderFields["uid"] as? String)!

                //通信後にこれらの情報を取ってこれていた場合は
                if self.accesstoken != nil && self.client != nil && self.uid != nil {
                    print("current_user_id保存成功_signup")

                    //responseから保存したアカウントデータのIDを抜き出す
                    let json:JSON = JSON(response.result.value ?? kill)
                    json.forEach { (arg) in
                        let (_, json) = arg
                        self.current_user_id = json["id"].intValue
                    }

                    let current_user_id: Int = self.current_user_id
                    let accesstoken: String = self.accesstoken
                    let client: String = self.client
                    let uid: String = self.uid

                    print("accesstoken: \(String(describing: accesstoken))")
                    print("client: \(String(describing: client))")
                    print("uid: \(String(describing: uid))")
                    print("CurrentUserID: \(String(describing: current_user_id))")

                    let current_user = Currentuser()
                    //パラメーターセット
                    current_user.current_user_id = current_user_id

                    //appDelegateに上げる
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.current_user_id = current_user
                    appDelegate.accesstoken = accesstoken
                    appDelegate.client = client
                    appDelegate.uid = uid

                }
                //エラーがあった場合
            } else {
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
}
