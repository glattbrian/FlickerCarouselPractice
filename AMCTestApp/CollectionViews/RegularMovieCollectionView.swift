//
//  RegularMovieCollectionView.swift
//  AMCTestApp
//
//  Created by Brian Glatt on 10/20/18.
//  Copyright © 2018 VUII. All rights reserved.
//

import UIKit


class RegularMovieCollectionView : UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    @IBOutlet weak var collectionView: UICollectionView!
    var imageSetNumber=0;
    var cellPath=0;
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return imageSetNumber;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let identifier=indexPath.item
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RegularMovieCell", for: indexPath as IndexPath) as! RegularMovieCell
        if(movieImages[cellPath].doneLoading())
        {
            (cell as RegularMovieCell).image.image = movieImages[cellPath].images[imageSetNumber-1-indexPath.item]
        }
        else
        {
            Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(reloadData), userInfo: nil, repeats: false)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: screenWidth/3.2, height: self.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        controller?.screenContainer.insets.replaceObject(at: cellPath, with: collectionView.contentOffset)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    {
        controller?.screenContainer.insets.replaceObject(at: cellPath, with: collectionView.contentOffset)
    }
    @objc func reloadData()
    {
        collectionView.reloadData()
    }
}
