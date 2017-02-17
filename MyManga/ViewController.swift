//
//  ViewController.swift
//  MyManga
//
//  Created by shashi kumar on 17/02/17.
//  Copyright © 2017 Iluminar Media Private Limited. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    lazy var manager: APIManager = {
        return APIManager()
    }()

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        fetchAccessToken()
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.textColor = UIColor.black
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        fetchAnimeForSearchQuery(query: textField.text!)
        return true
    }
    
    //MARK: HELPERS
    
    func fetchAccessToken() -> Void {
        manager.getAccessToken(success: {
            print("got access token")
        }) { (error) in
            
        }
    }
    
    func fetchAnimeForSearchQuery(query: String) -> Void {
        manager.fetchAnimeListForQuery(type: "manga", query: query, success: { (seriesList) in
            
        }) { (error) in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

