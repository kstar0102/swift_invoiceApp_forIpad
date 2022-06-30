//
//  CustomTableViewCell.swift
//  DimitriForm
//
//  Created by Kei on 4/19/22.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var secondary: UILabel!
    @IBOutlet weak var primary: UILabel!
    @IBOutlet weak var division: UILabel!
    @IBOutlet weak var emplyoer: UILabel!
    @IBOutlet weak var cce: UILabel!
    @IBOutlet weak var cpp: UILabel!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var birth: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var lastname: UILabel!
    @IBOutlet weak var firstname: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
