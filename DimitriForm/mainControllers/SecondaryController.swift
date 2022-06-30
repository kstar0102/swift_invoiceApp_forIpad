//
//  SecondaryController.swift
//  DimitriForm
//
//  Created by Kei on 4/18/22.
//
import UIKit
import Foundation
import SwiftPhoneNumberFormatter

class SecondaryController : UIViewController,UITextFieldDelegate{
    @IBOutlet weak var sec_edit: PhoneFormattedTextField!
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var userdata:[String:String] = [:]
    var Sdata:[UserData] = []
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
        let secondary = userdata["secondary"]
        if(secondary != ""){
            sec_edit.text = secondary
        }
        sec_edit.becomeFirstResponder()
        sec_edit.delegate = self
        sec_edit.keyboardType = .numberPad
        
        sec_edit.textDidChangeBlock = { field in
          if let text = field?.text, text != "" {
              print(text)
          } else {
              print("No text")
          }
        }

       defaultExample()
        // Do any additional setup after loading the view.
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            // Find out what the text field will be after adding the current edit
        let text = (sec_edit.text! as NSString).replacingCharacters(in: range, with: string)
        if Int(text) != nil{
            defaultExample()
        }
        return true
        }
    
    func defaultExample() {
        sec_edit.config.defaultConfiguration = PhoneFormat(defaultPhoneFormat: "#-(###)###-####")
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
    @IBAction func sec_next_btn(_ sender: Any) {
        if(sec_edit.text != ""){
            Sdata = UserDatabase.getCurrentPhoneDatas(phoneNumaber: sec_edit.text!)
            if(Sdata.count != 0){
                Common.NoticeAlert(vc: self, Nmessage: "This phone number already exists. Please re-enter.")
            }else{
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "citycontroller") as! CityController
                userdata = ["firstname": firstname, "lastname": lastname, "secondary":sec_edit.text!, "address":address, "gender":gender, "birth":birth, "company":company, "cpp":cpp, "cce":cce, "employer":employer, "division":division, "primary":primary]
                newViewController.userdata = userdata
                self.present(newViewController, animated: true, completion: nil)
            }
        }else{
            Common.NoticeAlert(vc: self, Nmessage: "Please fill in the input field.")
        }
    }
    @IBAction func secpre_btn(_ sender: Any) {
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "primarycontroller") as! PrimaryController
        newViewController.userdata = userdata
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction func cancelbtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "splash") as! SplashController
        self.present(newViewController, animated: true, completion: nil)
    }
}
