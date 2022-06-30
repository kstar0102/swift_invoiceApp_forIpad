import Foundation
import UIKit

class InSController: UIViewController{

    @IBOutlet weak var dateT: UITextField!
    @IBOutlet weak var soldT: UITextField!
    @IBOutlet weak var amount3L: UILabel!
    @IBOutlet weak var unit3L: UILabel!
    @IBOutlet weak var des3L: UILabel!
    @IBOutlet weak var product3L: UILabel!
    @IBOutlet weak var quan3L: UILabel!
    @IBOutlet weak var amount2L: UILabel!
    @IBOutlet weak var unit2L: UILabel!
    @IBOutlet weak var des2L: UILabel!
    @IBOutlet weak var product2L: UILabel!
    @IBOutlet weak var quan2L: UILabel!
    @IBOutlet weak var amount1L: UILabel!
    @IBOutlet weak var unit1L: UILabel!
    @IBOutlet weak var des1L: UILabel!
    @IBOutlet weak var product1L: UILabel!
    @IBOutlet weak var quan1L: UILabel!
    @IBOutlet weak var totalL: UILabel!
    @IBOutlet weak var addressL: UILabel!
    @IBOutlet weak var invoiceL: UILabel!
    @IBOutlet weak var secondaryL: UILabel!
    @IBOutlet weak var primaryL: UILabel!
    @IBOutlet weak var cityL: UILabel!
    var screenImg = UIImage(named:"ImageName")
    var UserId = UUID()
    var invoicedata:[String:String] = [:]
    var userdata:[UserData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userdata = UserDatabase.getCurrentUserDatas(Sid: UserId)
//        dateL.layer.borderColor = UIColor.darkGray.cgColor
//        dateL.layer.borderWidth = 1
        soldT.text = userdata[0].firstname! + " " + userdata[0].lastname!
//        cityL.text = userdata[0].city!
//        primaryL.text = userdata[0].primary!
//        secondaryL.text = userdata[0].secondary!
        addressL.text = userdata[0].address!
        
        dateT.text = invoicedata["date"]
        invoiceL.text = invoicedata["invoice"]
        product1L.text = invoicedata["product1"]
        product2L.text = invoicedata["product2"]
        product3L.text = invoicedata["product3"]
        des1L.text = invoicedata["des1"]
        des2L.text = invoicedata["des2"]
        des3L.text = invoicedata["des3"]
        unit1L.text = invoicedata["unit1"]
        unit2L.text = invoicedata["unit2"]
        unit3L.text = invoicedata["unit3"]
        quan1L.text = invoicedata["quan1"]
        quan2L.text = invoicedata["quan2"]
        quan3L.text = invoicedata["quan3"]
        
        let unit1 = Double(invoicedata["unit1"]!)
        let unit2 = Double(invoicedata["unit2"]!)
        let unit3 = Double(invoicedata["unit3"]!)
        let quan1 = Double(invoicedata["quan1"]!)
        let quan2 = Double(invoicedata["quan2"]!)
        let quan3 = Double(invoicedata["quan3"]!)
        
        let amount1 = unit1! * quan1!
        if(unit2 != nil){
            let amount2 = unit2! * quan2!
            amount2L.text = String(amount2)
            if(unit3 != nil){
                let amount3 = unit3! * quan3!
                amount3L.text = String(amount3)
                let total = amount1 + amount2 + amount3
                totalL.text = String(total)
            }else{
                totalL.text = String(amount1 + amount2)
            }
        }else{
            totalL.text = String(amount1)
        }
        
        amount1L.text = String(amount1)
    }
    
    @IBAction func saveImg(_ sender: Any) {
        let imageSize = UIScreen.main.bounds.size as CGSize;
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
        let context = UIGraphicsGetCurrentContext()
        for obj : AnyObject in UIApplication.shared.windows {
            
            if let window = obj as? UIWindow {
                if window.responds(to: #selector(getter: UIWindow.screen)) || window.screen == UIScreen.main {
                    // so we must first apply the layer's geometry to the graphics context
                    context!.saveGState();
                    // Center the context around the window's anchor point
                    context!.translateBy(x: window.center.x, y: window.center
                        .y);
                    // Apply the window's transform about the anchor point
                    context!.concatenate(window.transform);
                                    // Offset by the portion of the bounds left of and above the anchor point
                    context!.translateBy(x: -window.bounds.size.width * window.layer.anchorPoint.x,
                                         y: -window.bounds.size.height * window.layer.anchorPoint.y);
                    // Render the layer hierarchy to the current context
                    window.layer.render(in: context!)
                    // Restore the context
                    context!.restoreGState();
                }
            }
        }
        screenImg = UIGraphicsGetImageFromCurrentImageContext()!
        
        let Indata = InvoiceData(context: UserDatabase.persistentContainer.viewContext)
        Indata.id = UUID()
        Indata.title = product1L.text
        Indata.inImage = screenImg?.pngData()
        UserDatabase.saveContext()
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "searchcontroller") as! SearchController
        self.present(newViewController, animated: true, completion: nil)
        
//        export(image: screenImg!)
    }
    
    @IBAction func prebtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "invoicecontroller") as! InvoiceController
        newViewController.UserId = UserId
        self.present(newViewController, animated: true, completion: nil)
    }
    
    func export(image: UIImage) {
        guard let imageData = image.pngData() else { // 1
            return
        }
        
        let fileManager = FileManager.default // 2

        do {
            let fileURL = fileManager.temporaryDirectory.appendingPathComponent(invoiceL.text! + ".png") // 3
            print(fileURL)
            
            try imageData.write(to: fileURL) // 4
                            
            if #available(iOS 14, *) {
                let controller = UIDocumentPickerViewController(forExporting: [fileURL]) // 5
                present(controller, animated: true)
                print("open1")
            } else {
                let controller = UIDocumentPickerViewController(url: fileURL, in: .exportToService) // 6
                present(controller, animated: true)
                print("open2")
            }
            
        } catch {
            print("Error creating file")
        }
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
    
}
