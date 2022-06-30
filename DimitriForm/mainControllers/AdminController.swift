//
//  AdminController.swift
//  DimitriForm
//
//  Created by Kei on 6/6/22.
//

import Foundation
import UIKit

class AdminController: UIViewController{
    var session = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    @IBAction func cancelBtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "splash") as! SplashController
        newViewController.session = "ok"
        Common.session = "ok"
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction func logout(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "splash") as! SplashController
        newViewController.session = "cancel"
        Common.session = "cancel"
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction func productbtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "productcontroller") as! ProductController
        newViewController.session = "ok"
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction func mainBtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "searchcontroller") as! SearchController
        self.present(newViewController, animated: true, completion: nil)
    }
    @IBAction func contactbtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "viewcontact") as! ViewContactController
        newViewController.session = "ok"
        self.present(newViewController, animated: true, completion: nil)
    }
}
