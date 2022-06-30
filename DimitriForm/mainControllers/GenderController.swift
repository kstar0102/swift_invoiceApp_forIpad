//
//  GenderController.swift
//  DimitriForm
//
//  Created by Kei on 4/17/22.
//
import UIKit
import Foundation

class GenderController: UIViewController{
    @IBOutlet weak var gen_edit: UITextField!
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var userdata:[String:String] = [:]
    var firstname = ""
    var lastname = ""
    var address = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstname = userdata["firstname"]!
        lastname = userdata["lastname"]!
        address = userdata["address"]!
        let gender = userdata["gender"]
        if(gender != ""){
            gen_edit.text = gender
        }
        gen_edit.becomeFirstResponder()
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
    @IBAction func gender_pre_btn(_ sender: Any) {
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "addresscontroller") as! AddressController
        newViewController.userdata = userdata
        self.present(newViewController, animated: true, completion: nil)
    }
    @IBAction func gender_next_btn(_ sender: Any) {
        if(gen_edit.text != ""){
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "birthcontroller") as! BirthController
            userdata = ["firstname": firstname, "lastname": lastname, "gender":gen_edit.text!, "address":address]
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
