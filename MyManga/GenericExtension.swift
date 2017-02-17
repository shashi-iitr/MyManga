//
//  GenericExtension.swift
//  MyManga
//
//  Created by shashi kumar on 17/02/17.
//  Copyright © 2017 Iluminar Media Private Limited. All rights reserved.
//

import Foundation

let kAccessToken = "kAccessToken"

extension UserDefaults {
    
    func accessToken() -> String? {
        return self.value(forKey: kAccessToken) as? String
    }
    
    func setAccessToken(token: String) -> Void {
        self.set(token, forKey: kAccessToken)
        self.synchronize()
    }
    
}
