//
//  APIManager.swift
//  MyManga
//
//  Created by shashi kumar on 17/02/17.
//  Copyright © 2017 Iluminar Media Private Limited. All rights reserved.
//

import UIKit
import Alamofire

class APIManager: NSObject {
    
    func getAccessToken(success:@escaping () -> Void, failure:@escaping (NSError?) -> Void) -> Void {
        let path = "\(baseURL)auth/access_token"
        let params = ["grant_type": grant_type,
                      "client_id": client_id,
                      "client_secret": client_secret]
        
        Alamofire.request(path, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (responseData) in
            print("responseData \(responseData)")
            var isSuccess = false
            if let val = responseData.result.value {
                let newVal = val as! Dictionary<String, AnyObject>
                if let token = newVal["access_token"] {
                    isSuccess = true
                    print("token \(token)")
                    UserDefaults.standard.setAccessToken(token: token as! String)
                }
            }
            
            if isSuccess {
                success()
            } else {
                failure(NSError.init(domain: "Error", code: 401, userInfo: nil))
            }
        }
    }
    
    func fetchAnimeListForQuery(type: String, query: String, success:@escaping () -> Void, failure:@escaping (NSError?) -> Void) -> Void {
        
        let newQuery = String(query.characters.map {
            $0 == " " ? "+" : $0
        })
        print("query \(query) - newQuery \(newQuery)")
        
        let path = "\(baseURL)\(type)/search/\(newQuery)"
        let token = UserDefaults.standard.accessToken()
        if let token = token {
            let headers = ["Authorization": "Bearer \(token)"]
            Alamofire.request(path, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (responseData) in
                var isSuccess = false
                if((responseData.result.value) != nil) {
                    isSuccess = true
                    print("anime query responseData for \(query) \(responseData)")
                }
                
                if isSuccess {
                    success()
                } else {
                    failure(NSError.init(domain: "Error", code: 401, userInfo: nil))
                }
            })
        }
    }
}
