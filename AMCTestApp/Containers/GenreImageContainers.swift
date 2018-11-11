//
//  GenreImageContainers.swift
//  AMCTestApp
//
//  Created by Brian Glatt on 10/20/18.
//  Copyright © 2018 VUII. All rights reserved.
//

import UIKit

class GenreImageContainers : NSObject
{
    var genre : String;
    var images : [UIImage] = [];
    var maxImages : Int;
    
    init(genre : String, maxImages : Int)
    {
        self.genre=genre;
        self.maxImages=maxImages;
    }
    func loadImages()
    {
        let url = URL(string: urlPart1+apiKey+urlPart2+String(100)+urlPart3+genre)
        URLSession.shared.dataTask(with: url!)
        {
            data, response, error in completionHandler:
                    
            if(error==nil)
            {
                DispatchQueue.main.async()
                {
                    do
                    {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
                        print(json);
                        let photos=json["photos"]!["photo"] as! [AnyObject]
                        
                        for i in 0 ... self.maxImages-1
                        {
                            do
                            {
                                if(i>photos.count-1)
                                {
                                    self.images.append(placeHolderImage)
                                    continue
                                }
                                let image=self.formImageURL(data:(photos[i] as! [String: AnyObject]))
                                
                                URLSession.shared.dataTask(with: image)
                                {
                                    data, response, error in completionHandler:
                                        
                                    if(error==nil)
                                    {
                                        
                                        let downloadImage = UIImage(data: data!)!
                                        DispatchQueue.main.async()
                                        {
                                            self.images.append(downloadImage);
                                        }
                                    }
                                    else
                                    {
                                        print(error)
                                    }
                                }.resume()
                            }
                            catch
                            {
                                print(error)
                            }
                        }
                    }
                    catch
                    {
                        print(error)
                    }
                }
            }
            else
            {
                if((error! as NSError).domain==NSURLErrorDomain)
                {
                    let alert = UIAlertController(title: "An Error Has Occurred", message: "The Internet connection appers to be offline", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                    
                    controller!.present(alert, animated: true)
                    
                    for _ in 0 ... self.maxImages-1
                    {
                        self.images.append(placeHolderImage)
                    }
                }
            }
        }.resume();
    }
    func doneLoading() -> Bool
    {
        if(images.count<maxImages)
        {
            return false;
        }
        return true;
    }
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
