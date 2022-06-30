//
//  BirthController.swift
//  DimitriForm
//
//  Created by Kei on 4/17/22.
//

import UIKit
import Foundation

class BirthController : UIViewController, UITextFieldDelegate{
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var bit_edit: UITextField!
    var userdata:[String:String] = [:]
    var firstname = ""
    var lastname = ""
    var address = ""
    var gender = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstname = userdata["firstname"]!
        lastname = userdata["lastname"]!
        address = userdata["address"]!
        gender = userdata["gender"]!
        let birth = userdata["birth"]
        if(birth != ""){
            bit_edit.text = birth
        }
        bit_edit.becomeFirstResponder()
        bit_edit.keyboardType = .numberPad
        bit_edit.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn
      range: NSRange, replacementString string: String) -> Bool {

        if bit_edit.text?.count == 0 && string == "0" {
            return false
        }
        return string == string.filter("0123456789".contains)
    }
    
    @IBAction func datePickerChanged(_ sender: Any) {
        datePicker.datePickerMode = UIDatePicker.Mode.date
        let dateFormatter = DateFormatter()
//            dateFormatter.dateStyle = DateFormatter.Style.short
//            dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let selectedDate = dateFormatter.string(from: datePicker.date)

//            let strDate = dateFormatter.string(from: datePicker.date)
            bit_edit.text = selectedDate
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
    @IBAction func birth_next_btn(_ sender: Any) {
        if(bit_edit.text != ""){
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "componycontroller") as! ComponyController
            userdata = ["firstname": firstname, "lastname": lastname, "birth":bit_edit.text!, "address":address, "gender":gender]
            newViewController.userdata = userdata
            self.present(newViewController, animated: true, completion: nil)
        }else{
            Common.NoticeAlert(vc: self, Nmessage: "Please fill in the input field.")
        }
    }
    @IBAction func birth_pre_btn(_ sender: Any) {
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "gendercontroller") as! GenderController
        newViewController.userdata = userdata
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction func cancelbtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "splash") as! SplashController
        self.present(newViewController, animated: true, completion: nil)
    }
}
