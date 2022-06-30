//
//  ProductViewController.swift
//  DimitriForm
//
//  Created by Kei on 6/5/22.
//

import Foundation
import UIKit

class ProductViewController: UIViewController{
    @IBOutlet weak var desT: UITextField!
    @IBOutlet weak var unitT: UITextField!
    @IBOutlet weak var nameT: UITextField!
    
    var Pdata:[ProductData] = []
    var PId = UUID()
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Pdata = UserDatabase.getCurrentProductDatas(Sid: PId);
        nameT.text = Pdata[0].productname;
        desT.text = Pdata[0].productdes
        unitT.text = Pdata[0].productunit
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
    
    @IBAction func updateB(_ sender: Any) {
        UserDatabase.updataProductdata(PId: PId, name: nameT.text!, unit: unitT.text!, des: desT.text!)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "productcontroller") as! ProductController
        newViewController.session = "ok"
        self.present(newViewController, animated: true, completion: nil)
    }
    @IBAction func deleteB(_ sender: Any) {
        let alertController = UIAlertController(title: "Warning", message: "Do you really delete?", preferredStyle: .alert)

         // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { [self]
             UIAlertAction in
             NSLog("OK Pressed")
            UserDatabase.deleteCurrentProductData(Did: PId)
            
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "productcontroller") as! ProductController
            newViewController.session = "ok"
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
    @IBAction func cancelB(_ sender: Any) {
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "productcontroller") as! ProductController
        newViewController.session = "ok"
        self.present(newViewController, animated: true, completion: nil)
    }
}
