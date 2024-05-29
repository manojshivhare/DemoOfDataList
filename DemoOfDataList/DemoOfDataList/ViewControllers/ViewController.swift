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
    //MARK: --------------- Variable---------------
    private var activityView = UIActivityIndicatorView(style: .large)
    private let dataUrlStr = "https://jsonplaceholder.typicode.com/posts?_page=1&_limit="
    private var listArray = [ListModel]()
    private var pageCount = 10
    private var selectedRow: Int?
    
    //MARK: --------------- View Life Cycle---------------
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "List of data"
        callApi()
        setupTableView()
    }
    
    private func setupTableView(){
        dataList.register(UINib(nibName: "DataListTVC", bundle: nil), forCellReuseIdentifier: "DataListTVC")
        dataList.dataSource = self
        dataList.delegate = self
    }
    
    private func showActivityIndicatory() {
        activityView.center = self.view.center
        view.addSubview(activityView)
        activityView.startAnimating()
    }
    
    private func hideActivityIndicator(){
        activityView.stopAnimating()
        activityView.removeFromSuperview()
    }
    
    private func callApi(){
        showActivityIndicatory()
        ApiManager.shared.getApiData(urlStr: dataUrlStr, pageCount: pageCount, resultType: [ListModel].self) { [weak self] result in
            if let result, result.isEmpty == false{
                self?.listArray = result
                DispatchQueue.main.async {
                    self?.hideActivityIndicator()
                    self?.dataList.reloadData()
                }
            }else{
                let alert = UIAlertController(title: "Alert!", message: "No data found", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "dismiss", style: .default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailScreen",let selectedRow {
            let destinationVC = segue.destination as! DetailsViewController
            destinationVC.dataObject = listArray[selectedRow]
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
        selectedRow = indexPath.row
        performSegue(withIdentifier: "detailScreen", sender: self)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if listArray.count - 1  == indexPath.row {
            pageCount = pageCount + 10
            callApi()
        }
    }
}
