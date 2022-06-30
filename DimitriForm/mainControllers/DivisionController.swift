//
//  DivisionController.swift
//  DimitriForm
//
//  Created by Kei on 4/17/22.
//
import UIKit
import Foundation

class DivisionController : UIViewController, UITextFieldDelegate{
    @IBOutlet weak var divi_edit: UITextField!
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
        let division = userdata["division"]
        if(division != ""){
            divi_edit.text = division
        }
        divi_edit.becomeFirstResponder()
        divi_edit.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
      return (string.rangeOfCharacter(from: invalidCharacters) == nil)
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
    @IBAction func divi_pre_btn(_ sender: Any) {
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "employercontroller") as! EmployerController
        newViewController.userdata = userdata
        self.present(newViewController, animated: true, completion: nil)
    }
    @IBAction func divi_next_btn(_ sender: Any) {
        if(divi_edit.text != ""){
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "primarycontroller") as! PrimaryController
            userdata = ["firstname": firstname, "lastname": lastname, "division":divi_edit.text!, "address":address, "gender":gender, "birth":birth, "company":company, "cpp":cpp, "cce":cce, "employer":employer]
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
