//
//  AddressController.swift
//  DimitriForm
//
//  Created by Kei on 4/17/22.
//
import UIKit
import Foundation

class AddressController: UIViewController{
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    @IBOutlet weak var add_edit: UITextField!
    var userdata:[String:String] = [:]
    var firstname = ""
    var lastname = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstname = userdata["firstname"]!
        lastname = userdata["lastname"]!
        let address = userdata["address"]
        if(address != ""){
            add_edit.text = address
        }
        add_edit.becomeFirstResponder()
        // Do any additional setup after loading the view.
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
    @IBAction func address_pre_btn(_ sender: Any) {
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "lastnamecontroller") as! LastnameController
        newViewController.userdata = userdata
        self.present(newViewController, animated: true, completion: nil)
    }
    @IBAction func address_next_btn(_ sender: Any) {
        if(add_edit.text != ""){
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "gendercontroller") as! GenderController
            userdata = ["firstname": firstname, "lastname": lastname, "address":add_edit.text!]
            newViewController.userdata = userdata
            self.present(newViewController, animated: true, completion: nil)
        }else{
            Common.NoticeAlert(vc: self, Nmessage: "Please fill in the input field.")
        }
    }
    @IBAction func cancelbtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "splash") as! SplashController
        self.present(newViewController, animated: true, completion: nil)
    }
}
