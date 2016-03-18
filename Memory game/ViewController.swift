//
//  ViewController.swift
//  Memory game
//
//  Created by admin on 3/6/16.
//  Copyright © 2016 Anya&Qusay. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var letters = ["詩", "史", "弒", "時", "市", "是", "刺", "食", "詩", "史", "弒", "時", "市", "是", "刺", "食"]
    //var letters = ["A", "B", "C", "D", "E", "F", "G", "H", "A", "B", "C", "D", "E", "F", "G", "H"]
    var cell_index = 0
    var currentCell : NSIndexPath! = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       for var index = 15; index >= 0; --index {
            let random = Int(arc4random_uniform(UInt32(index)))
            print(random)
            let temp = letters[index]
            letters[index] = letters[random]
            letters[random] = temp
        }
        print(letters)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! CollectionViewCell
        
        cell.letter?.text = letters[cell_index]
        cell.letter?.hidden = true
        cell_index++
        return cell
    }
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        <#code#>
//    }
    

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CollectionViewCell
        
        cell.letter?.hidden = false
        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            
            sleep(2)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if(self.currentCell == nil) {
                    
                    self.currentCell = indexPath
                }
                else {
                    let previousCell = collectionView.cellForItemAtIndexPath(self.currentCell) as! CollectionViewCell
                    
                    
                    
                    if(previousCell.letter?.text != cell.letter?.text) {
                        cell.letter?.hidden = true
                        previousCell.letter?.hidden = true
                    }
                    
               self.currentCell = nil
                }

            })
        }
        }

}

