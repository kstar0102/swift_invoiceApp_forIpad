//
//  CppController.swift
//  DimitriForm
//
//  Created by Kei on 4/17/22.
//

import UIKit
import Foundation

class CppController : UIViewController, UITextFieldDelegate{
    @IBOutlet weak var cpp_edit: UITextField!
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var userdata:[String:String] = [:]
    var firstname = ""
    var lastname = ""
    var address = ""
    var gender = ""
    var birth = ""
    var company = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstname = userdata["firstname"]!
        lastname = userdata["lastname"]!
        address = userdata["address"]!
        gender = userdata["gender"]!
        birth = userdata["birth"]!
        company = userdata["company"]!
        let cpp = userdata["cpp"]
        if(cpp != ""){
            cpp_edit.text = cpp
        }
        cpp_edit.becomeFirstResponder()
        cpp_edit.delegate = self
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      let invalidCharacters = CharacterSet(charactersIn: "0123456789.").inverted
      return (string.rangeOfCharacter(from: invalidCharacters) == nil)
    }
    
    @IBAction func cpp_next_btn(_ sender: Any) {
        if(cpp_edit.text != ""){
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ccecontroller") as! CceController
            userdata = ["firstname": firstname, "lastname": lastname, "cpp":cpp_edit.text!, "address":address, "gender":gender, "birth":birth, "company":company]
            newViewController.userdata = userdata
            self.present(newViewController, animated: true, completion: nil)
        }else{
            Common.NoticeAlert(vc: self, Nmessage: "Please fill in the input field.")
        }
    }
    @IBAction func cpp_pre_bnt(_ sender: Any) {
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "componycontroller") as! ComponyController
        newViewController.userdata = userdata
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction func cancelbtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "splash") as! SplashController
        self.present(newViewController, animated: true, completion: nil)
    }
}
