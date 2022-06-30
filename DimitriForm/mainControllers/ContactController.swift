//
//  ContactController.swift
//  DimitriForm
//
//  Created by Kei on 6/6/22.
//

import Foundation
import UIKit

class ContactController: UIViewController, UITextFieldDelegate{
    @IBOutlet weak var secondaryT: PhoneFormattedTextField!
    @IBOutlet weak var primaryT: PhoneFormattedTextField!
    @IBOutlet weak var nameT: UITextField!
    
    var userid = UUID()
    var userdata:[UserData] = []
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userdata = UserDatabase.getCurrentUserDatas(Sid: userid);
        
        nameT.text = userdata[0].firstname! + " " + userdata[0].lastname!
        primaryT.text = userdata[0].primary!
        secondaryT.text = userdata[0].secondary!
        
        primaryT.delegate = self
        primaryT.keyboardType = .numberPad
        
        primaryT.textDidChangeBlock = { field in
          if let text = field?.text, text != "" {
              print(text)
          } else {
              print("No text")
          }
        }
        
        secondaryT.delegate = self
        secondaryT.keyboardType = .numberPad
        
        secondaryT.textDidChangeBlock = { field in
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
        let text = (primaryT.text! as NSString).replacingCharacters(in: range, with: string)
        let text1 = (secondaryT.text! as NSString).replacingCharacters(in: range, with: string)
        
        if Int(text) != nil{
            defaultExample()
        }
        if Int(text1) != nil{
            defaultExample()
        }
        return true
        }
    
    func defaultExample() {
        primaryT.config.defaultConfiguration = PhoneFormat(defaultPhoneFormat: "#-(###)###-####");
        secondaryT.config.defaultConfiguration = PhoneFormat(defaultPhoneFormat: "#-(###)###-####")
    }
    
    @IBAction func cancelB(_ sender: Any) {
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "viewcontact") as! ViewContactController
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction func deleteB(_ sender: Any) {
        let alertController = UIAlertController(title: "Warning", message: "Do you really delete?", preferredStyle: .alert)

         // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { [self]
             UIAlertAction in
             NSLog("OK Pressed")
            UserDatabase.deleteCurrentUserData(Did: userid)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "viewcontact") as! ViewContactController
            self.present(newViewController, animated: true, completion: nil)
         }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
             UIAlertAction in
             NSLog("Cancel Pressed")
         }

         // Add the actions
         alertController.addAction(okAction)
         alertController.addAction(cancelAction)

         // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func updateB(_ sender: Any) {
        UserDatabase.updataUserdata(UserId: userid, firstname: userdata[0].firstname!, lastname: userdata[0].lastname!, postal: userdata[0].postal!, address: userdata[0].address!, secondary: secondaryT.text!, primary: primaryT.text!, division: userdata[0].division!, employer: userdata[0].employer!, note: userdata[0].note!, city: userdata[0].city!, cce: userdata[0].cce!, cpp: userdata[0].cpp!, company: userdata[0].company!, birth: userdata[0].birth!, gender: userdata[0].gender!)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "viewcontact") as! ViewContactController
        self.present(newViewController, animated: true, completion: nil)
    }
    
}
