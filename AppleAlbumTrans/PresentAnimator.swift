//
//  PresentAnimator.swift
//  AppleAlbumTrans
//
//  Created by itsector on 06/03/2020.
//  Copyright © 2020 itsector. All rights reserved.
//

import Foundation
import UIKit

class PresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var originFrame:CGRect = CGRect.zero
    
    var offSet: CGFloat = 0
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5

    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
        let containerView = transitionContext.containerView
        
        let detailView = transitionContext.view(forKey: .to)!
        
        let finalFrame = detailView.frame
        
        var initialFrame = originFrame
        
        let detailAspectRatio = finalFrame.width / finalFrame.height
        
        initialFrame.size = CGSize(width: initialFrame.width, height: initialFrame.width * detailAspectRatio)
        
        let scaleFactor = finalFrame.width / initialFrame.width
        
        let growScaleFactor = scaleFactor
        
        let shrinkScaleFactor = 1 / growScaleFactor
        
        detailView.transform = CGAffineTransform(scaleX: shrinkScaleFactor, y: shrinkScaleFactor)
        
        detailView.center = CGPoint(x: originFrame.midX, y: originFrame.midY + offSet)
        
        detailView.clipsToBounds = true
        
        containerView.addSubview(detailView)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            detailView.transform = CGAffineTransform.identity
            
            detailView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
        }) { (success) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }
}
