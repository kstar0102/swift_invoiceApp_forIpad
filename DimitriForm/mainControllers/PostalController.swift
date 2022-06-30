//
//  PostalController.swift
//  DimitriForm
//
//  Created by Kei on 4/18/22.
//
import UIKit
import Foundation

class PostalController : UIViewController{
    @IBOutlet weak var pos_edit: UITextField!
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var userdata:[String:String] = [:]
    var firstname = ""
    var lastname = ""
    var address = ""
    var gender = ""
    var birth = ""
    var company = ""
    var cpp = ""
    var cce = ""
    var employer = ""
    var division = ""
    var primary = ""
    var secondary = ""
    var city = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstname = userdata["firstname"]!
        lastname = userdata["lastname"]!
        address = userdata["address"]!
        gender = userdata["gender"]!
        birth = userdata["birth"]!
        company = userdata["company"]!
        cpp = userdata["cpp"]!
        cce = userdata["cce"]!
        employer = userdata["employer"]!
        division = userdata["division"]!
        primary = userdata["primary"]!
        secondary = userdata["secondary"]!
        city = userdata["city"]!
        let postal = userdata["postal"]
        if(city != ""){
            pos_edit.text = postal
        }
        pos_edit.becomeFirstResponder()
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
    
 
    
    @IBAction func pos_next_btn(_ sender: Any) {
        if(pos_edit.text != ""){
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "notescontroller") as! NotesController
            userdata = ["firstname": firstname, "lastname": lastname, "postal":pos_edit.text!, "address":address, "gender":gender, "birth":birth, "company":company, "cpp":cpp, "cce":cce, "employer":employer, "division":division, "primary":primary, "secondary": secondary, "city":city]
            newViewController.userdata = userdata
            self.present(newViewController, animated: true, completion: nil)
        }else{
            Common.NoticeAlert(vc: self, Nmessage: "Please fill in the input field.")
        }
    }
    @IBAction func pos_pre_btn(_ sender: Any) {
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "citycontroller") as! CityController
        newViewController.userdata = userdata
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction func cancelbtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "splash") as! SplashController
        self.present(newViewController, animated: true, completion: nil)
    }
}
