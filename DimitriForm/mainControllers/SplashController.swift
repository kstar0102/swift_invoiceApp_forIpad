//
//  SplashController.swift
//  DimitriForm
//
//  Created by Kei on 5/25/22.
//

import Foundation
import UIKit

class SplashController: UIViewController{
    @IBOutlet weak var mainbtn: UIButton!
    var session = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        mainbtn.isHidden = true
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
    @IBAction func viewcontact(_ sender: Any) {
        if(Common.session == "ok"){
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "admincontroller") as! AdminController
            newViewController.session = "ok"
            self.present(newViewController, animated: true, completion: nil)
        }else{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "logincontroller") as! LoginController
            newViewController.status = "splash"
            newViewController.gopage = "contact"
            self.present(newViewController, animated: true, completion: nil)
        }
    }
    @IBAction func mainpage(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "searchcontroller") as! SearchController
        self.present(newViewController, animated: true, completion: nil)
    }
    @IBAction func firstbtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "firsnameController") as! ViewController
        self.present(newViewController, animated: true, completion: nil)
    }

}
