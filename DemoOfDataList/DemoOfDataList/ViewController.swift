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
    private var pageCount = 10
    
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
        ApiManager.shared.getApiData(urlStr: dataUrlStr, pageCount: pageCount, resultType: [ListModel].self) { [weak self] result in
            if let result, result.isEmpty == false{
                self?.listArray = result
                DispatchQueue.main.async {
                    self?.dataList.reloadData()
                }
            }
        }
    }
    
}

//MARK: --------------- TableView Methods Extension---------------
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataObject = listArray[indexPath.row]
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let detailsVC = storyBoard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        detailsVC.dataObject = dataObject
        self.present(detailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if listArray.count - 1  == indexPath.row {
            pageCount = pageCount + 10
            callApi()
        }
    }
}
