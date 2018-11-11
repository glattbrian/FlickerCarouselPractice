//
//  ScreenCollectionView.swift
//  AMCTestApp
//
//  Created by Brian Glatt on 10/20/18.
//  Copyright © 2018 VUII. All rights reserved.
//
import UIKit


class ScreenCollectionView : UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    @IBOutlet weak var carouselContainers: UICollectionView!
    
    var insets : NSMutableArray = NSMutableArray.init();
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        insets.removeAllObjects();
        for _ in 0 ... carouselCells.count-1
        {
            insets.add(CGPoint.init(x: 0, y: 0))
        }
        return carouselCells.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let identifier=carouselCellsTitles[indexPath.item]
        var cell : UICollectionViewCell;
        if(identifier=="Blank")
        {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopCarousel", for: indexPath as IndexPath) as! TopCarouselCell
        }
        else
        {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RegularCarousel", for: indexPath as IndexPath) as! RegularCarouselCell
            (cell as! RegularCarouselCell).title.text=identifier;
            (cell as! RegularCarouselCell).collectionView.collectionView.setContentOffset(insets.object(at: indexPath.item) as! CGPoint, animated: false)
            (cell as! RegularCarouselCell).collectionView.imageSetNumber=movieImages[indexPath.item].maxImages-1
            (cell as! RegularCarouselCell).collectionView.cellPath=indexPath.item
            (cell as! RegularCarouselCell).collectionView.collectionView.reloadData();
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let identifier=carouselCellsTitles[indexPath.item]
        if(identifier=="Blank")
        {
            return CGSize(width: screenWidth, height: screenHeight/1.8)
        }
        else
        {
            return CGSize(width: screenWidth, height: screenHeight/3)
        }
    }
}
