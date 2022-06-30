//
//  ViewController.swift
//  DimitriForm
//
//  Created by Kei on 4/17/22.
//

import UIKit

class ViewController: UIViewController{
    @IBOutlet weak var first_edit: UITextField!
    var userdata:[String:String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = UIViewController()
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(vc, animated: true, completion: nil)
        
        self.modalPresentationStyle = .fullScreen
        let name = userdata["firstname"]
        
        if(name != ""){
            first_edit.text = name
        }
        first_edit.becomeFirstResponder()
        
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false

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
    
    @IBAction func next_btn(_ sender: Any) {
        if(first_edit.text != ""){
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            userdata = ["firstname": first_edit.text!]
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "lastnamecontroller") as! LastnameController
            newViewController.userdata = userdata
            self.present(newViewController, animated: true, completion: nil)
        }else{
            Common.NoticeAlert(vc: self, Nmessage: "Please fill in the input field.")
        }
        
    }
    @IBAction func beforebtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "splash") as! SplashController
        self.present(newViewController, animated: true, completion: nil)
    }
}

