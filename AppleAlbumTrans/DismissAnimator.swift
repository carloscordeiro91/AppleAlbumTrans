//
//  DismissAnimator.swift
//  AppleAlbumTrans
//
//  Created by itsector on 06/03/2020.
//  Copyright © 2020 itsector. All rights reserved.
//

import Foundation
import UIKit

class DismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var offSet: CGFloat = 0
    
    var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        let detailView = transitionContext.view(forKey: .from)!
        
        let thumbnailView = transitionContext.view(forKey: .to)!
        
        let finalFrame = originFrame
        
        let initialFrame = detailView.frame
        
        let scaleFactor = initialFrame.width / finalFrame.width
        
        let growScaleFactor = scaleFactor
        
        let shrinkScaleFactor = 1 / growScaleFactor
        
        detailView.clipsToBounds = true
        
        containerView.addSubview(thumbnailView)
        
        containerView.bringSubviewToFront(detailView)
        
        detailView.backgroundColor = UIColor.clear
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            
            detailView.transform = CGAffineTransform(scaleX: shrinkScaleFactor, y: shrinkScaleFactor)
            
            detailView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY + self.offSet)
            
        }) { (success) in
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        
        
    }
}
