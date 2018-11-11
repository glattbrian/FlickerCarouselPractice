//
//  MasterController.swift
//  AMCTestApp
//
//  Created by Brian Glatt on 10/19/18.
//  Copyright © 2018 VUII. All rights reserved.
//

import UIKit
import CoreLocation

//Can be loaded from external source
var carouselCellsTitles = ["Blank","Newly Added","Curator's Choice","A Shudder Halloween","The Master of Suspense","Vengeance is Hers","Black Magick","Haunts","Binge This"]
var carouselCells = ["Title","Horror","Curator","Halloween","Suspense","Vengeance","Magic","Haunting","Binge"]

var movieImages : [GenreImageContainers] = [];

let minImages=25;
let maxImages=30;

var screenWidth : CGFloat = 0.0
var screenHeight : CGFloat = 0.0
var lineScaleX : CGFloat = 0.0
var lineScaleY : CGFloat = 0.0

let urlPart1 = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=";
let urlPart2 = "&per_page=";
let urlPart3 = "&format=json&nojsoncallback=1&text="
let apiKey = "57078afe3fd13c26a7e19531533cda19";

var keyboardScrollBuffer : CGFloat = 0.0

let placeHolderImage = UIImage(named:"placeholder.jpeg")!

var controller : ViewController? = nil;

var prefs : UserDefaults = UserDefaults.standard


class MasterController: NSObject
{
    
}
