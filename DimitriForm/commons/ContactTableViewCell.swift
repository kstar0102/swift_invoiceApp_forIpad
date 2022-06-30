//
//  ContactTableViewCell.swift
//  DimitriForm
//
//  Created by Kei on 5/19/22.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var secondaryL: UILabel!
    @IBOutlet weak var primaryL: UILabel!
    @IBOutlet weak var nameL: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
