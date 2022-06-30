//
//  Common.swift
//  DimitriForm
//
//  Created by Kei on 4/17/22.
//
import UIKit
import Foundation

class Common{
    struct AppUtility {

        static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        
            if let delegate = UIApplication.shared.delegate as? AppDelegate {
                delegate.orientationLock = orientation
            }
        }

        /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
        static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
       
            self.lockOrientation(orientation)
        
            UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
            UINavigationController.attemptRotationToDeviceOrientation()
        }

    }
    struct userdata{
        let firstname: String
        let lastname: String
    }
    
    static var session = "no"
    
    static let updateUrl = "http://10.10.11.158:3000/api/todos"
    
    static func NoticeAlert(vc: UIViewController, Nmessage: String){
        let dialogMessage = UIAlertController(title: "Warning", message: Nmessage, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            dialogMessage.dismiss(animated: true, completion: nil)
         })
        
        dialogMessage.addAction(ok)
        vc.present(dialogMessage, animated: true, completion: nil)
    }
}
