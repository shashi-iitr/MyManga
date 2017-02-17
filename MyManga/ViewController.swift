//
//  ViewController.swift
//  MyManga
//
//  Created by shashi kumar on 17/02/17.
//  Copyright © 2017 Iluminar Media Private Limited. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    lazy var manager: APIManager = {
        return APIManager()
    }()
    
    var seriesList = [MangaSeriesModel]()

    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        tableView.register(UINib.init(nibName: "MangaSeriesListCell", bundle: nil), forCellReuseIdentifier: MangaSeriesListCell.reusedIdentifier())
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.alpha = 0
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
        if textField.canResignFirstResponder {
            textField.resignFirstResponder()
        }
        fetchAnimeForSearchQuery(query: textField.text!)
        
        return true
    }
    
    //MARK: UITableViewDelegate, UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seriesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MangaSeriesListCell = tableView.dequeueReusableCell(withIdentifier: MangaSeriesListCell.reusedIdentifier(), for: indexPath) as! MangaSeriesListCell
        if seriesList.count > 0 {
            let series = seriesList[indexPath.row]
            cell.configureCellWith(title: series.title!, imageURL: series.imageURLMedium)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if seriesList.count > 0 {
            let series = seriesList[indexPath.row]
            print("series \(series.title)")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MangaSeriesListCell.cellHeight()
    }
    
    //MARK: HELPERS
    
    func fetchAccessToken() -> Void {
        manager.getAccessToken(success: {
            print("got access token")
        }) { (error) in
            
        }
    }
    
    func fetchAnimeForSearchQuery(query: String) -> Void {
        indicatorView.startAnimating()
        tableView.alpha = 0
        manager.fetchAnimeListForQuery(type: "manga", query: query, success: { [weak self] (seriesList) in
            self?.tableView.alpha = 1
            self?.indicatorView.stopAnimating()
            self?.seriesList = seriesList
            self?.tableView.reloadData()
        }) { [weak self] (error) in
            self?.indicatorView.stopAnimating()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

