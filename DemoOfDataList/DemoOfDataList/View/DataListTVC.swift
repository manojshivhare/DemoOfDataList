//
//  DataListTVC.swift
//  DemoOfDataList
//
//  Created by Manoj Shivhare on 28/05/24.
//

import UIKit

class DataListTVC: UITableViewCell {
    
    //MARK: --------------- IBOutlet---------------
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var userIdLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
