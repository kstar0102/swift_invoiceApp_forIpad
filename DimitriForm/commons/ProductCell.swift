//
//  ProductCell.swift
//  DimitriForm
//
//  Created by Kei on 6/5/22.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var desL: UILabel!
    @IBOutlet weak var unitL: UILabel!
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
