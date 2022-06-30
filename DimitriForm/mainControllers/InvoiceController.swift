//
//  InvoiceController.swift
//  DimitriForm
//
//  Created by Kei on 5/3/22.
//

import Foundation
import UIKit
import PDFKit
import MobileCoreServices
import UniformTypeIdentifiers

class InvoiceController: UIViewController , UITextFieldDelegate{

    @IBOutlet weak var quanA: UILabel!
    @IBOutlet weak var unitA: UILabel!
    @IBOutlet weak var productA: UILabel!
    @IBOutlet weak var invoiceA: UILabel!
    @IBOutlet weak var dateA: UILabel!
    @IBOutlet weak var desA: UILabel!
    
    @IBOutlet weak var dateE: UITextField!
    @IBOutlet weak var des3E: UITextField!
    @IBOutlet weak var quan3E: UITextField!
    @IBOutlet weak var unit3E: UITextField!
    @IBOutlet weak var product3E: DropDown!
    @IBOutlet weak var des2E: UITextField!
    @IBOutlet weak var quan2E: UITextField!
    @IBOutlet weak var unit2E: UITextField!
    @IBOutlet weak var product2E: DropDown!
    @IBOutlet weak var quan1E: UITextField!
    @IBOutlet weak var des1E: UITextField!
    @IBOutlet weak var unit1E: UITextField!
    @IBOutlet weak var product1E: DropDown!
    @IBOutlet weak var invoiceE: UITextField!
    
    var datePicker :UIDatePicker!
    
    var UserId = UUID()
    var invoicedata:[String:String] = [:]
    var productData:[ProductData] = []
    var productArray: [String] = []
    var productdesArray: [String] = []
    var productunitArray: [String] = []
    var producteId:[UUID] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quanA.isHidden = true
        unitA.isHidden = true
        productA.isHidden = true
        invoiceA.isHidden = true
        dateA.isHidden = true
        desA.isHidden = true
        
        dateE.delegate = self
        unit1E.delegate = self
        unit2E.delegate = self
        unit3E.delegate = self
        quan1E.delegate = self
        quan2E.delegate = self
        quan3E.delegate = self
        
        productData = UserDatabase.getProductDatas()
        if(productData.count != 0){
            for j in 0...productData.count - 1{
                productArray.append(productData[j].productname!)
                productdesArray.append(productData[j].productdes!)
                productunitArray.append(productData[j].productunit!)
                producteId.append(productData[j].id!)
            }
        }
//        print(productArray)
        
        product1E.optionArray = productArray
        product1E.checkMarkEnabled = false
        
        product2E.optionArray = productArray
        product2E.checkMarkEnabled = false
        
        product3E.optionArray = productArray
        product3E.checkMarkEnabled = false
        
        product1E.didSelect{(selectedText , index , id) in
            print("Selected String: \(selectedText) \n index: \(index) \n Id: \(id)")
//            newViewController.invoiceId = self.invoiceId
//            newViewController.index = index
            self.unit1E.text = self.productunitArray[index]
            self.des1E.text = self.productdesArray[index]
            self.quan1E.text = "1"
        }
        
        product2E.didSelect{(selectedText , index , id) in
            print("Selected String: \(selectedText) \n index: \(index) \n Id: \(id)")
//            newViewController.invoiceId = self.invoiceId
//            newViewController.index = index
            self.unit2E.text = self.productunitArray[index]
            self.des2E.text = self.productdesArray[index]
            self.quan2E.text = "1"
        }
        
        product3E.didSelect{(selectedText , index , id) in
            print("Selected String: \(selectedText) \n index: \(index) \n Id: \(id)")
//            newViewController.invoiceId = self.invoiceId
//            newViewController.index = index
            self.unit3E.text = self.productunitArray[index]
            self.des3E.text = self.productdesArray[index]
            self.quan3E.text = "1"
        }
        
        
        datePicker = UIDatePicker.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 300))
        datePicker.addTarget(self, action: #selector(self.dateChanged), for: .allEvents)
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        datePicker.datePickerMode = .date
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        let dateString = df.string(from: date)
        dateE.text = dateString
        dateE.inputView = datePicker
        let doneButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(self.datePickerDone))
        let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 50))
        toolBar.setItems([UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil), doneButton], animated: true)
        dateE.inputAccessoryView = toolBar
    }
    
    @objc func datePickerDone() {
        dateE.resignFirstResponder()
   }

    @objc func dateChanged() {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd/MM/yyyy"
        let selectedDate = dateFormat.string(from: datePicker.date)
        
        dateE.text = selectedDate
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Common.AppUtility.lockOrientation(.landscape)
       }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       Common.AppUtility.lockOrientation(.all)
    }
    @IBAction func sendInvoice(_ sender: Any) {
        
        if(invoiceE.text != ""){
            if(product1E.text != ""){
                if(unit1E.text != ""){
                    if(quan1E.text != ""){
                        if(des1E.text != ""){
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "inscontroller") as! InSController
                            invoicedata = ["date":dateE.text!, "invoice":invoiceE.text!,
                                           "product1":product1E.text!, "des1":des1E.text!,"quan1":quan1E.text!,"unit1":unit1E.text!,
                                           "product2":product2E.text!, "des2":des2E.text!,"quan2":quan2E.text!,"unit2":unit2E.text!,
                                           "product3":product3E.text!, "des3":des3E.text!,"quan3":quan3E.text!,"unit3":unit3E.text!]
                            newViewController.UserId = UserId
                            newViewController.invoicedata = invoicedata
                            self.present(newViewController, animated: true, completion: nil)
                        }else{
                            Common.NoticeAlert(vc: self, Nmessage: "Please enter the description")
                            desA.isHidden = false
                        }
                    }else{
                        Common.NoticeAlert(vc: self, Nmessage: "Please enter the quantity")
                        quanA.isHidden = false
                    }
                }else{
                    Common.NoticeAlert(vc: self, Nmessage: "Please enter the unit")
                    unitA.isHidden = false
                }
            }else{
                Common.NoticeAlert(vc: self, Nmessage: "Please enter the Product name")
                productA.isHidden = false
            }
        }else{
            Common.NoticeAlert(vc: self, Nmessage: "Please enter the invoice title")
            invoiceA.isHidden = false
        }
        
    }
    @IBAction func cancelbtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "detailcontroller") as! DetailController
        newViewController.UserId = UserId
        self.present(newViewController, animated: true, completion: nil)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      let invalidCharacters = CharacterSet(charactersIn: "0123456789.").inverted
      return (string.rangeOfCharacter(from: invalidCharacters) == nil)
    }

}
