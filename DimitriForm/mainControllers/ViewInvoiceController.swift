//
//  ViewInvoiceController.swift
//  DimitriForm
//
//  Created by Kei on 5/20/22.
//

import Foundation
import UIKit

class ViewInvoiceController: UIViewController{
    @IBOutlet weak var viewImg: UIImageView!
    var invoiceId:[UUID] = []
    var index:Int = 0
    var indata:[InvoiceData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indata = UserDatabase.getCurrentInvoiceDatas(Sid: invoiceId[index])
        
        let imageData:NSData = indata[0].inImage! as NSData
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        let decodedData = Data(base64Encoded: strBase64, options: .ignoreUnknownCharacters)!
        let image = UIImage(data: decodedData)
        viewImg.image = image
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
    @IBAction func backBtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "searchcontroller") as! SearchController
         self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction func printBtn(_ sender: Any) {
        indata = UserDatabase.getCurrentInvoiceDatas(Sid: invoiceId[index])
        
        let imageData:NSData = indata[0].inImage! as NSData
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        let decodedData = Data(base64Encoded: strBase64, options: .ignoreUnknownCharacters)!
        let image = UIImage(data: decodedData)
        
        let printController = UIPrintInteractionController.shared
            // 2
        let printInfo = UIPrintInfo(dictionary:nil)
        printInfo.outputType = .general
        printInfo.jobName = "print Job"
        printController.printInfo = printInfo
        printController.printingItem = image
        
        // If you want to specify a printer
//         guard let printerURL = URL(string: "Your printer URL here, e.g. ipps://HPDC4A3E0DE24A.local.:443/ipp/print") else { return }
//         guard let currentPrinter = UIPrinter(url: printerURL) else { return }
                
        // 3
//        let formatter = UIMarkupTextPrintFormatter(markupText: textView.text)
//        formatter.perPageContentInsets = UIEdgeInsets(top: 72, left: 72, bottom: 72, right: 72)
//        printController.printFormatter = formatter
                
        // 4
        printController.present(animated: true)
//       printController.present(animated: true, completionHandler: nil)
//       printController.present(from: self.view.frame, in: self.view, animated: true, completionHandler: nil)
    }
}
