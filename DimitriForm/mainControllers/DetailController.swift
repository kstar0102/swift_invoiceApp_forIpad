//
//  DetailController.swift
//  DimitriForm
//
//  Created by Kei on 4/20/22.
//

import Foundation
import UIKit

class DetailController:UIViewController{

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var postal: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var secondary: UILabel!
    @IBOutlet weak var primary: UILabel!
    @IBOutlet weak var division: UILabel!
    @IBOutlet weak var employer: UILabel!
    @IBOutlet weak var notes: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var cce: UILabel!
    @IBOutlet weak var ccp: UILabel!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var birth: UILabel!
    @IBOutlet weak var gender: UILabel!

    var UserId = UUID()
    
    var userdata:[UserData] = []
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userdata = UserDatabase.getCurrentUserDatas(Sid: UserId)
        
        name.text = userdata[0].firstname! + "  " + userdata[0].lastname!
        postal.text = userdata[0].postal!
        address.text = userdata[0].address!
        secondary.text = userdata[0].secondary!
        primary.text = userdata[0].primary!
        division.text = userdata[0].division!
        employer.text = userdata[0].employer!
        notes.text = userdata[0].note!
        city.text = userdata[0].city!
        cce.text = userdata[0].cce!
        ccp.text = userdata[0].cpp!
        company.text = userdata[0].company!
        birth.text = userdata[0].birth!
        gender.text = userdata[0].gender!
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Common.AppUtility.lockOrientation(.landscape)
           // Or to rotate and lock
    //        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       // Don't forget to reset when view is being removed editcontroller
       Common.AppUtility.lockOrientation(.all)
    }
    @IBAction func edit_btn(_ sender: Any) {
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "editcontroller") as! EditController
        newViewController.UserId = UserId
        newViewController.pageinfo = "detail"
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction func deletebtn(_ sender: Any) {
        // Create the alert controller
        let alertController = UIAlertController(title: "Warning", message: "Do you really delete?", preferredStyle: .alert)

         // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { [self]
             UIAlertAction in
             NSLog("OK Pressed")
            UserDatabase.deleteCurrentUserData(Did: UserId)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "searchcontroller") as! SearchController
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
    
    @IBAction func invoiceBtn(_ sender: Any) {
        if(Common.session == "ok"){
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "invoicecontroller") as! InvoiceController
            newViewController.UserId = UserId
            self.present(newViewController, animated: true, completion: nil)
        }else{
            let alertController = UIAlertController(title: "Error", message: "Please Login.", preferredStyle: .alert)

             // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { [self]
                 UIAlertAction in
                 NSLog("OK Pressed")
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "logincontroller") as! LoginController
                newViewController.status = "detail"
                newViewController.gopage = "invoice"
                newViewController.UserId = UserId
                self.present(newViewController, animated: true, completion: nil)
             }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                 UIAlertAction in
                 NSLog("Cancel Pressed")
             }

             // Add the actions
             alertController.addAction(okAction)
             alertController.addAction(cancelAction)
             self.present(alertController, animated: true, completion: nil)
        }
        
    }
    @IBAction func backbtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "searchcontroller") as! SearchController
         self.present(newViewController, animated: true, completion: nil)
    }
}
