//
//  LoginController.swift
//  DimitriForm
//
//  Created by Kei on 4/21/22.
//

import Foundation
import UIKit
import Alamofire

class LoginController:UIViewController{
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var passlabel: UILabel!
    @IBOutlet weak var password_edit: UITextField!
    @IBOutlet weak var username_edit: UITextField!
    
    var status = ""
    var gopage = ""
    var UserId = UUID()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Common.AppUtility.lockOrientation(.landscape)
           // Or to rotate and lock
    //        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
    }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       // Don't forget to reset when view is being removed
       Common.AppUtility.lockOrientation(.all)
   }
    @IBAction func login_btn(_ sender: Any) {
        let username = username_edit.text
        let password = password_edit.text

        if(username != "admin"){
            if(username != ""){
                namelabel.text = "Incorrect your username"
            }else{
                namelabel.text = "Please fill in the blank"
            }
        }

        if(password != "1234" || password != ""){
            if(password != "" ){
                passlabel.text = "Incorrect your password"
            }else{
                passlabel.text = "Please fill in the blank"
            }

        }

        if(username == "admin"){
            if(password == "1234"){
                namelabel.text = ""
                passlabel.text = ""
                username_edit.text = ""
                password_edit.text = ""
                if(gopage == "invoice"){
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "invoicecontroller") as! InvoiceController
                    newViewController.UserId = UserId
                    Common.session = "ok"
                    self.present(newViewController, animated: true, completion: nil)
                }else if(gopage == "search"){
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "searchcontroller") as! SearchController
                    Common.session = "ok"
                    self.present(newViewController, animated: true, completion: nil)
                }else{
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "admincontroller") as! AdminController
                    newViewController.session = "ok"
                    Common.session = "ok"
                    self.present(newViewController, animated: true, completion: nil)
                }
            }
        }
    }
    @IBAction func backbtn(_ sender: Any) {
        if(status == "detail"){
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "detailcontroller") as! DetailController
            newViewController.UserId = UserId
            self.present(newViewController, animated: true, completion: nil)
        }else{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "splash") as! SplashController
            self.present(newViewController, animated: true, completion: nil)
        }
    }
}
