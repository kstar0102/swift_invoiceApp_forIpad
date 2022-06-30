//
//  PrimaryController.swift
//  DimitriForm
//
//  Created by Kei on 4/17/22.
//
import UIKit
import Foundation
import SwiftPhoneNumberFormatter

class PrimaryController : UIViewController, UITextFieldDelegate {
    @IBOutlet weak var pri_edit: PhoneFormattedTextField!
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var userdata:[String:String] = [:]
    var Pdata:[UserData] = []
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
        let primary = userdata["primary"]
        
        if(primary != ""){
            pri_edit.text = primary
        }
        
        pri_edit.becomeFirstResponder()
        pri_edit.delegate = self
        pri_edit.keyboardType = .numberPad
        
        pri_edit.textDidChangeBlock = { field in
          if let text = field?.text, text != "" {
              print(text)
          } else {
              print("No text")
          }
        }

       defaultExample()
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            // Find out what the text field will be after adding the current edit
        let text = (pri_edit.text! as NSString).replacingCharacters(in: range, with: string)
        if Int(text) != nil{
            defaultExample()
        }
        return true
        }
    
    func defaultExample() {
        pri_edit.config.defaultConfiguration = PhoneFormat(defaultPhoneFormat: "#-(###)###-####")
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
    @IBAction func pri_pre_btn(_ sender: Any) {
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "divisioncontroller") as! DivisionController
        newViewController.userdata = userdata
        self.present(newViewController, animated: true, completion: nil)
    }
    @IBAction func pri_next_btn(_ sender: Any) {
        if(pri_edit.text != ""){
            Pdata = UserDatabase.getCurrentPhoneDatas(phoneNumaber: pri_edit.text!)
            if(Pdata.count != 0){
                Common.NoticeAlert(vc: self, Nmessage: "This phone number already exists. Please re-enter.")
            }else{
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "secondarycontroller") as! SecondaryController
                userdata = ["firstname": firstname, "lastname": lastname, "primary":pri_edit.text!, "address":address, "gender":gender, "birth":birth, "company":company, "cpp":cpp, "cce":cce, "employer":employer, "division":division]
                newViewController.userdata = userdata
                self.present(newViewController, animated: true, completion: nil)
            }
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
