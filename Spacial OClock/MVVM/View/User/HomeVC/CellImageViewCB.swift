//
//  CellImageViewCB.swift
//  Spacial OClock
//
//  Created by cql211 on 27/06/23.
//

import UIKit

class CellImageViewCB: UICollectionViewCell {
    
    //MARK: Outlet
    @IBOutlet weak var img : UIImageView!

    func parallaxTheImageViewScrollOffset(offsetPoint:CGPoint, scrollDirection:UICollectionView.ScrollDirection) {
          // Horizontal? If not, it's vertical
        let isHorizontal = .horizontal == scrollDirection
          
          // Choose the amount of parallax, one might say the distance from the viewer
          // 1 would mean the image wont move at all ie. very far away, 0.1 it moves a little i.e. very close
          let factor: CGFloat = 0.5
          let parallaxFactorX: CGFloat = isHorizontal ? factor : 0.0
          let parallaxFactorY: CGFloat = isHorizontal ? 0.0 : factor
          
          // Calculate the image position and apply the parallax factor
          let finalX = (offsetPoint.x - self.frame.origin.x) * parallaxFactorX
          let finalY = (offsetPoint.y - self.frame.origin.y) * parallaxFactorY
          
          // Now we have final position, set the offset of the frame of the background iamge
          let frame = img.bounds
          let offsetFame = CGRectOffset(frame, CGFloat(finalX), CGFloat(finalY))
        img.frame = offsetFame
      }
}
