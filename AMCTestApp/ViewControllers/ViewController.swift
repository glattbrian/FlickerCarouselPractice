//
//  ViewController.swift
//  AMCTestApp
//
//  Created by Brian Glatt on 10/19/18.
//  Copyright © 2018 VUII. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var screenContainer: ScreenCollectionView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        controller=self;
        
        loadImages();
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func loadImages()
    {
        
        for i in 0 ... carouselCells.count-1
        {
            let gic=GenreImageContainers.init(genre: carouselCells[i], maxImages: Int.random(in: minImages ... maxImages))
            movieImages.append(gic);
            gic.loadImages();
        }
    }
    /*
    private func performFlickrSearch(_ searchURL: URL) {
        
        // Perform the request
        let session = URLSession.shared
        let request = URLRequest(url: searchURL)
        let task = session.dataTask(with: request){
            (data, response, error) in
            if (error == nil)
            {
                // Check response code
                let status = (response as! HTTPURLResponse).statusCode
                if (status < 200 || status > 300)
                {
                    self.displayAlert("Server returned an error")
                    return;
                }
                
                /* Check data returned? */
                guard let data = data else {
                    self.displayAlert("No data was returned by the request!")
                    return
                }
                
                // Parse the data
                let parsedResult: [String:AnyObject]!
                do {
                    parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject]
                } catch {
                    self.displayAlert("Could not parse the data as JSON: '\(data)'")
                    return
                }
                print("Result: \(parsedResult)")
                
                // Check for "photos" key in our result
                guard let photosDictionary = parsedResult["photos"] as? [String:AnyObject] else {
                    self.displayAlert("Key 'photos' not in \(parsedResult)")
                    return
                }
                //print("Result: \(photosDictionary)")
                
                /* GUARD: Is the "photo" key in photosDictionary? */
                guard let photosArray = photosDictionary["photo"] as? [[String: AnyObject]] else {
                    self.displayAlert("Cannot find key 'photo' in \(photosDictionary)")
                    return
                }
                
                // Check number of ophotos
                if photosArray.count == 0 {
                    self.displayAlert("No Photos Found. Search Again.")
                    return
                } else {
                    // Get the first image
                    let photoDictionary = photosArray[0] as [String: AnyObject]
                    
                    /* GUARD: Does our photo have a key for 'url_m'? */
                    guard let imageUrlString = photoDictionary["url_m"] as? String else {
                        self.displayAlert("Cannot find key 'url_m' in \(photoDictionary)")
                        return
                    }
                    
                    // Fetch the image
                    self.fetchImage(imageUrlString);
                }
                
            }
            else{
                self.displayAlert((error?.localizedDescription)!)
            }
        }
        task.resume()
    }
*/
    func formImageURL(data : [String:AnyObject]) -> URL
    {
        let farm = data["farm"]!
        let server = data["server"]!
        let secret = data["secret"]!
        let id = data["id"]!
        let url = "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg"
        
        
        return URL(string: url)!;
        
    }
}

