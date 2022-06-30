//
//  EditController.swift
//  DimitriForm
//
//  Created by Kei on 4/30/22.
//

import Foundation
import UIKit
import CoreData
import SwiftPhoneNumberFormatter

class EditController:UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var first_edit: UITextField!
    @IBOutlet weak var ccp_edit: UITextField!
    @IBOutlet weak var cce_edit: UITextField!
    @IBOutlet weak var division_edit: UITextField!
    @IBOutlet weak var primary_edit: PhoneFormattedTextField!
    @IBOutlet weak var secondary_edit: PhoneFormattedTextField!
    @IBOutlet weak var postal_edit: UITextField!
    @IBOutlet weak var employer_edit: UITextField!
    @IBOutlet weak var note_edit: UITextField!
    @IBOutlet weak var city_edit: UITextField!
    @IBOutlet weak var company_edit: UITextField!
    @IBOutlet weak var address_edit: UITextField!
    @IBOutlet weak var birth_edit: UITextField!
    @IBOutlet weak var gender_edit: UITextField!
    @IBOutlet weak var last_edit: UITextField!
    
    var UserId = UUID()
    var userdata:[UserData] = []
    var pageinfo = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userdata = UserDatabase.getCurrentUserDatas(Sid: UserId)
        
        first_edit.text = userdata[0].firstname!
        postal_edit.text = userdata[0].postal!
        address_edit.text = userdata[0].address!
        secondary_edit.text = userdata[0].secondary!
        primary_edit.text = userdata[0].primary!
        division_edit.text = userdata[0].division!
        employer_edit.text = userdata[0].employer!
        note_edit.text = userdata[0].note!
        city_edit.text = userdata[0].city!
        cce_edit.text = userdata[0].cce!
        ccp_edit.text = userdata[0].cpp!
        company_edit.text = userdata[0].company!
        birth_edit.text = userdata[0].birth!
        gender_edit.text = userdata[0].gender!
        last_edit.text = userdata[0].lastname!
        
        primary_edit.delegate = self
        primary_edit.keyboardType = .numberPad
        
        primary_edit.textDidChangeBlock = { field in
          if let text = field?.text, text != "" {
              print(text)
          } else {
              print("No text")
          }
        }
        
        secondary_edit.delegate = self
        secondary_edit.keyboardType = .numberPad
        
        secondary_edit.textDidChangeBlock = { field in
          if let text = field?.text, text != "" {
              print(text)
          } else {
              print("No text")
          }
        }

       defaultExample()
        
    
        
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
            // Find out what the text field will be after adding the current edit
        let text = (primary_edit.text! as NSString).replacingCharacters(in: range, with: string)
        let text1 = (secondary_edit.text! as NSString).replacingCharacters(in: range, with: string)
        
        if Int(text) != nil{
            defaultExample()
        }
        if Int(text1) != nil{
            defaultExample()
        }
        return true
        }
    
    func defaultExample() {
        primary_edit.config.defaultConfiguration = PhoneFormat(defaultPhoneFormat: "#-(###)###-####");
        secondary_edit.config.defaultConfiguration = PhoneFormat(defaultPhoneFormat: "#-(###)###-####")
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        UserDatabase.updataUserdata(UserId: UserId, firstname: first_edit.text!, lastname: last_edit.text!, postal: postal_edit.text!, address: address_edit.text!, secondary: secondary_edit.text!, primary: primary_edit.text!, division: division_edit.text!, employer: employer_edit.text!, note: note_edit.text!, city: city_edit.text!, cce: cce_edit.text!, cpp: ccp_edit.text!, company: company_edit.text!, birth: birth_edit.text!, gender: gender_edit.text!)
        
        if(pageinfo == "detail"){
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "detailcontroller") as! DetailController
            newViewController.UserId = UserId
            self.present(newViewController, animated: true, completion: nil)
        }else{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "viewcontact") as! ViewContactController
            newViewController.session = "ok"
            self.present(newViewController, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func cancelbtn(_ sender: Any) {
        if(pageinfo == "detail"){
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "detailcontroller") as! DetailController
            newViewController.UserId = UserId
            self.present(newViewController, animated: true, completion: nil)
        }else{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "viewcontact") as! ViewContactController
            newViewController.session = "ok"
            self.present(newViewController, animated: true, completion: nil)
        }
    }
}
