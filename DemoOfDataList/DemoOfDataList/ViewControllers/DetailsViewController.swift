//
//  DetailsViewController.swift
//  DemoOfDataList
//
//  Created by Manoj Shivhare on 28/05/24.
//

import UIKit

class DetailsViewController: UIViewController {
    
    //MARK: --------------- IBOutlet---------------
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    //MARK: --------------- Variable---------------
    var dataObject: ListModel?
    
    //MARK: --------------- View Life Cycle---------------
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Details of data"
        updateData()
    }
    
    private func updateData(){
        if let dataObject{
            titleLabel.text = dataObject.title
            idLabel.text = "id: \(dataObject.id)"
            userIdLabel.text = "UserId: \(dataObject.userId)"
            descriptionLabel.text = dataObject.body
        }
    }
}
