//
//  NotesController.swift
//  DimitriForm
//
//  Created by Kei on 4/18/22.
//
import UIKit
import Foundation
import Alamofire

class NotesController : UIViewController{
    @IBOutlet weak var not_edit: UITextField!
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
    var postal = ""
    
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
        postal = userdata["postal"]!
        
        not_edit.becomeFirstResponder()
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
    @IBAction func not_next_btn(_ sender: Any) {
        if(not_edit.text != ""){
            let Udata = UserData(context: UserDatabase.persistentContainer.viewContext)
            
             Udata.id = UUID()
             Udata.firstname = firstname
             Udata.lastname = lastname
             Udata.gender = gender
             Udata.birth = birth
             Udata.company = company
             Udata.cpp = cpp
             Udata.cce = cce
             Udata.employer = self.employer
             Udata.division = self.division
             Udata.primary = self.primary
             Udata.address = self.address
             Udata.secondary = self.secondary
             Udata.city = self.city
             Udata.postal = self.postal
             Udata.note = self.not_edit.text!
            
             UserDatabase.saveContext()
            
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "splash") as! SplashController
            self.present(newViewController, animated: true, completion: nil)
 
            
//            let Url = String(format: Common.updateUrl)
//                guard let serviceUrl = URL(string: Url) else { return }
//                let parameters: [String: Any] = [
//                    "firstname": self.firstname,
//                    "lastname": self.lastname,
//                    "gender": self.gender,
//                    "birthday": self.birth,
//                    "company":self.company,
//                    "cppNumber":self.cpp,
//                    "cceNumber":self.cce,
//                    "employer":self.employer,
//                    "divisionNum":self.division,
//                    "primaryPhone":self.primary,
//                    "secondaryPhone":self.secondary,
//                    "address":self.address,
//                    "city":self.city,
//                    "postal":self.postal,
//                    "notes":self.not_edit.text!
//                ]
//
//                var request = URLRequest(url: serviceUrl)
//                request.httpMethod = "POST"
//                request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
//                guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
//                    return
//                }
//                request.httpBody = httpBody
//                request.timeoutInterval = 20
//                let session = URLSession.shared
//                session.dataTask(with: request) { (data, response, error) in
//                    if let response = response {
//                        print(response)
//                    }
//                    if let data = data {
//                        do {
//                            let json : [String: AnyObject] = try JSONSerialization.jsonObject(with: data, options: []) as! [String : AnyObject]
//                        } catch {
//                            print(error)
//                        }
//                    }
//                }.resume()
        }else{
            Common.NoticeAlert(vc: self, Nmessage: "Please fill in the input field.")
        }
    }
    
    @IBAction func not_pre_btn(_ sender: Any) {
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "postalcontroller") as! PostalController
        newViewController.userdata = userdata
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction func cancelbtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "splash") as! SplashController
        self.present(newViewController, animated: true, completion: nil)
    }
    
}

