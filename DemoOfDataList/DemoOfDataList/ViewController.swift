//
//  ViewController.swift
//  DemoOfDataList
//
//  Created by Manoj Shivhare on 28/05/24.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: --------------- IBOutlet---------------
    @IBOutlet weak var dataList: UITableView!
    
    private let dataUrlStr = "https://jsonplaceholder.typicode.com/posts?_page=1&_limit="
    private var listArray = [ListModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callApi()
        setupTableView()
    }
    
    private func setupTableView(){
        dataList.register(UINib(nibName: "DataListTVC", bundle: nil), forCellReuseIdentifier: "DataListTVC")
        dataList.dataSource = self
        dataList.delegate = self
    }
    
    private func callApi(){
        ApiManager.shared.getApiData(urlStr: dataUrlStr, pageCount: 10, resultType: [ListModel].self) { [weak self] result in
            if let result, result.isEmpty == false{
                self?.listArray = result
                DispatchQueue.main.async {
                    self?.dataList.reloadData()
                }
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataListTVC") as! DataListTVC
        let dataObject = listArray[indexPath.row]
        cell.titleLabel.text = dataObject.title
        cell.idLabel.text = "id: \(dataObject.id)"
        cell.userIdLabel.text = "UserId: \(dataObject.userId)"
        cell.descriptionLabel.text = dataObject.body
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
