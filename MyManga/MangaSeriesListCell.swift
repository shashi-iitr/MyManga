//
//  MangaSeriesListCell.swift
//  MyManga
//
//  Created by shashi kumar on 17/02/17.
//  Copyright © 2017 Iluminar Media Private Limited. All rights reserved.
//

import UIKit

class MangaSeriesListCell: UITableViewCell {

    @IBOutlet weak var seriesNameLabel: UILabel!
    @IBOutlet weak var seriesImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCellWith(title: String, imageURL: String?) -> Void {
        seriesNameLabel.text = title
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    class func cellHeight() -> CGFloat {
        return 60.0
    }

    class func reusedIdentifier() -> String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
}
