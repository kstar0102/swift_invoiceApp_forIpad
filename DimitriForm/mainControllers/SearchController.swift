//
//  SearchController.swift
//  DimitriForm
//
//  Created by Kei on 4/18/22.
//
import UIKit
import Foundation

class SearchController : UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var contactbtn: UIButton!
    @IBOutlet weak var mainDropDown: DropDown!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var userdata:[UserData] = []
    var indata:[InvoiceData] = []
    var data:[String] = []
    var filteredData: [String]!
    var invoiceArray: [String] = []
    var invoiceId:[UUID] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        self.registerTableViewCells()
        contactbtn.isHidden = true
        
        userdata = UserDatabase.getUserDatas()
        indata = UserDatabase.getInvoiceDatas()
        
        
        if(userdata.count != 0){
            for i in 0...userdata.count - 1 {
                data.append(userdata[i].firstname! + "   " + userdata[i].lastname! + "   "
                            + userdata[i].gender! + "   "
                            + userdata[i].birth! + "   "
                            + userdata[i].address! + "   "
                            + userdata[i].company! + "   "
                            + userdata[i].cpp! + "   "
                            + userdata[i].cce! + "   "
                            + userdata[i].employer! + "   "
                            + userdata[i].primary!.components(separatedBy: CharacterSet.decimalDigits.inverted)
                                .joined() + "   "
                            + userdata[i].secondary!.components(separatedBy: CharacterSet.decimalDigits.inverted)
                                .joined())
            }
        }
        
        if(indata.count != 0){
            for j in 0...indata.count - 1{
                invoiceArray.append(indata[j].title!)
                invoiceId.append(indata[j].id!)
            }
        }
        
        filteredData = data
        mainDropDown.optionArray = invoiceArray
        mainDropDown.checkMarkEnabled = false
        
        mainDropDown.didSelect{(selectedText , index , id) in
            print("Selected String: \(selectedText) \n index: \(index) \n Id: \(id)")
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "viewinvoice") as! ViewInvoiceController
            newViewController.invoiceId = self.invoiceId
            newViewController.index = index
            self.present(newViewController, animated: true, completion: nil)

        }
        
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
    
    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "CustomTableViewCell", bundle: nil)
        self.tableView.register(textFieldCell, forCellReuseIdentifier: "CustomTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as? CustomTableViewCell
        
//        let Arr = filteredData[indexPath.row].components(separatedBy: " ")
//        print(Arr)
//        cell!.firstname.text = Arr[0];
//        cell!.lastname.text = Arr[1];
//        cell!.gender.text = Arr[2];
//        cell!.birth.text = Arr[3];
//        cell!.company.text = Arr[5];
//        cell!.cpp.text = Arr[6];
//        cell!.cce.text = Arr[7];
//        cell!.emplyoer.text = Arr[8];
//        cell!.division.text = Arr[4];
//        cell!.primary.text = Arr[9];
//        cell!.secondary.text = Arr[10];
        cell!.firstname.text = filteredData[indexPath.row]

        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "detailcontroller") as! DetailController
        newViewController.UserId = userdata[indexPath.row].id!
        self.present(newViewController, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }

    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        filteredData = searchText.isEmpty ? data : data.filter { (item: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        tableView.reloadData()
    }
    
//    func defaultExample() {
//        pri_edit.config.defaultConfiguration = PhoneFormat(defaultPhoneFormat: "#-(###)###-####")
//    }

    
    @IBAction func newenter(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "firsnameController") as! ViewController
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction func viewcontact(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "logincontroller") as! LoginController
        newViewController.status = "main"
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction func cancelbtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "splash") as! SplashController
        self.present(newViewController, animated: true, completion: nil)
    }
}
