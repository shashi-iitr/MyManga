//
//  MangaSeriesModel.swift
//  MyManga
//
//  Created by shashi kumar on 17/02/17.
//  Copyright © 2017 Iluminar Media Private Limited. All rights reserved.
//

import UIKit
import ObjectMapper

class MangaSeriesModel: NSObject, Mappable {

    var identifier: String?
    var title: String?
    var seriesType: String?
    var desc: String?
    var isAdult: String?
    var imageURLLarge: String?
    var imageURLBanner: String?
    var imageURLMedium: String?
    var imageURLSmall: String?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        identifier      <- map["id"]
        title           <- map["title_english"]
        seriesType      <- map["series_type"]
        desc            <- map["description"]
        isAdult         <- map["adult"]
        imageURLLarge   <- map["image_url_lge"]
        imageURLBanner  <- map["image_url_banner"]
        imageURLMedium  <- map["image_url_med"]
        imageURLSmall   <- map["image_url_sml"]
    }
}
