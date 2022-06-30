//
//  ProductController.swift
//  DimitriForm
//
//  Created by Kei on 5/30/22.
//

import Foundation
import UIKit

class ProductController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var proname: UITextField!
    @IBOutlet weak var prodes: UITextField!
    @IBOutlet weak var prounit: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var session = ""
    var Pdata:[ProductData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prounit.delegate = self
        Pdata = UserDatabase.getProductDatas()
        
        self.registerTableViewCells()
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
    
    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "ProductCell", bundle: nil)
        self.tableView.register(textFieldCell, forCellReuseIdentifier: "ProductCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Pdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductCell
        cell?.nameL.text = Pdata[indexPath.row].productname
        cell?.unitL.text = Pdata[indexPath.row].productunit
        cell?.desL.text = Pdata[indexPath.row].productdes
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "productview") as! ProductViewController
        newViewController.PId = Pdata[indexPath.row].id!
        self.present(newViewController, animated: true, completion: nil)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      let invalidCharacters = CharacterSet(charactersIn: "0123456789.").inverted
      return (string.rangeOfCharacter(from: invalidCharacters) == nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "admincontroller") as! AdminController
        newViewController.session = self.session
        self.present(newViewController, animated: true, completion: nil)
    }
    @IBAction func resigter(_ sender: Any) {
        if(proname.text != ""){
            if(prounit.text != ""){
                if(prodes.text != ""){
                    
                    let Pdata = ProductData(context: UserDatabase.persistentContainer.viewContext);
                    
                    Pdata.id = UUID();
                    Pdata.productname = proname.text!;
                    Pdata.productunit = prounit.text!;
                    Pdata.productdes = prodes.text!;
                    
                    UserDatabase.saveContext();
                    
                    proname.text = "";
                    prodes.text = "";
                    prounit.text = "";
                    
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "productcontroller") as! ProductController
                    newViewController.session = "ok"
                    self.present(newViewController, animated: true, completion: nil)
                    
                }else{
                    Common.NoticeAlert(vc: self, Nmessage: "Please enter the product description")
                }
            }else{
                Common.NoticeAlert(vc: self, Nmessage: "Please enter the product unit price")
            }
        }else{
            Common.NoticeAlert(vc: self, Nmessage: "Please enter the product name")
        }
        
        
    }
}
