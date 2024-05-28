//
//  APIManager.swift
//  DemoOfDataList
//
//  Created by Manoj Shivhare on 28/05/24.
//

import Foundation

class ApiManager{
    //MARK: ----------Singleton Object---------
    static let shared = ApiManager()
    
    //MARK: ----------Variable----------------
    let session = URLSession(configuration: .default)
    var request : NSMutableURLRequest = NSMutableURLRequest()
    
    //MARK: ----------API----------------    
    func getApiData<T:Decodable>(urlStr: String, pageCount: Int, resultType: T.Type, completionHandler:@escaping(_ result: T?)-> Void)
       {
           let fullUrl = "\(urlStr)\(pageCount)"
           guard let requestUrl = URL(string: fullUrl) else{ return }
           URLSession.shared.dataTask(with: requestUrl) { (responseData, httpUrlResponse, error) in
               if(error == nil && responseData != nil && responseData?.count != 0)
               {
                   let decoder = JSONDecoder()
                   do {
                       let result = try decoder.decode(T.self, from: responseData!)
                       _=completionHandler(result)
                   }
                   catch let error{
                       debugPrint("error occured while decoding = \(error.localizedDescription)")
                   }
               }
               
           }.resume()
       }
    
}
