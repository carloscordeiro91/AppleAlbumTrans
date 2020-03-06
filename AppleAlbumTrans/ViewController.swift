//
//  ViewController.swift
//  AppleAlbumTrans
//
//  Created by itsector on 06/03/2020.
//  Copyright © 2020 itsector. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
 
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let dataCount = 12
    
    var selectedCell = UICollectionViewCell()
    
    var offSet: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView.delegate = self
        
        collectionView.dataSource = self
        
        offSet = self.navigationController!.navigationBar.frame.height + (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 20)
   
        self.navigationController?.delegate = self
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.selectedCell = collectionView.cellForItem(at: indexPath)!
        
        performSegue(withIdentifier: "NewVCSegue", sender: nil)
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataCount
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerRow: CGFloat = 3.0
        
        let hardCodedPadding: CGFloat = 2.0
        
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        
        let itemHeight = itemWidth
        
        return CGSize(width: itemWidth, height: itemHeight)
    }


}

extension ViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        switch operation {
            
        case .pop:
            
            let animator = DismissAnimator()
            
            animator.originFrame = selectedCell.frame
            animator.offSet = offSet
            return animator
            
        case .push:
            
            let animator = PresentAnimator()
            animator.originFrame = selectedCell.frame
            animator.offSet = offSet
            return animator
            
        default:
            return nil
        }
        
        
    }
}
