//
//  lastnameController.swift
//  DimitriForm
//
//  Created by Kei on 4/17/22.
//
import UIKit
import Foundation

class LastnameController: UIViewController{
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var userdata:[String:String] = [:]
    var firstname = ""
    @IBOutlet weak var last_edit: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .fullScreen
        let name = userdata["lastname"]
        if(name != ""){
            last_edit.text = name
        }
        firstname = userdata["firstname"]!
        last_edit.becomeFirstResponder()
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
    @IBAction func previous_btn(_ sender: Any) {
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "firsnameController") as! ViewController
        newViewController.userdata = userdata
        self.present(newViewController, animated: true, completion: nil)
    }
    @IBAction func last_next_btn(_ sender: Any) {
        if(last_edit.text != ""){
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "addresscontroller") as! AddressController
            userdata = ["firstname": firstname, "lastname": last_edit.text!]
            newViewController.userdata = userdata
            self.present(newViewController, animated: true, completion: nil)
        }else{
            Common.NoticeAlert(vc: self, Nmessage: "Please fill in the input field.")
        }
    }
    
    @IBAction func cancelL(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "splash") as! SplashController
        self.present(newViewController, animated: true, completion: nil)
    }
}
