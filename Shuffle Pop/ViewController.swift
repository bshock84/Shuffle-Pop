//
//  ViewController.swift
//  Shuffle Pop
//
//  Created by Ben Shockley on 6/11/16.
//  Copyright © 2016 Ben Shockley. All rights reserved.
//

import Cocoa
import Foundation
import AppKit
import GameKit

class ViewController: NSViewController {
    
    @IBOutlet weak var collectionView: NSCollectionView!
    var previouslyUsedNumbers: [Int] = []
    let imageBox = NSImageView()
    
   // required init?(coder aDecoder: NSCoder) {
    //    super.init(coder: aDecoder)
    //}
    
    var imageArray: [String] = []
    
    func configureImageBox() {
        
        view.addSubview(imageBox)
        imageBox.translatesAutoresizingMaskIntoConstraints = false
        
        imageBox.topAnchor.constraintEqualToAnchor(view.topAnchor)
        imageBox.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        imageBox.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        imageBox.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor)
        
        imageBox.imageAlignment = NSImageAlignment.AlignCenter
        imageBox.imageScaling = NSImageScaling.ScaleAxesIndependently
        
        
    }
    
    func getRandomInt() -> Int {
        var foundNumber = false
        var randomIndex: Int = 0
        
        while foundNumber == false {
            randomIndex = GKRandomSource.sharedRandom().nextIntWithUpperBound(imageArray.count - 1)
        
            if previouslyUsedNumbers.contains(randomIndex) {
                foundNumber = false
            } else {
                foundNumber = true
                previouslyUsedNumbers.append(randomIndex)
            }
            
        }
        return randomIndex
    }
    
    func displayRandomImage() {
     
        let randomIndex = getRandomInt()
        imageBox.image = NSImage(named: imageArray[randomIndex])
        
    }
    
    
    func createImageArray() {
        let fm = NSFileManager.defaultManager()
        let path = NSBundle.mainBundle().resourcePath!
        let items = try! fm.contentsOfDirectoryAtPath(path)
        
        for image in items {
            if image.containsString(".jpg") {
                imageArray.append(image)
            }
        }
        
        print(imageArray)
    }
    private func configureCollectionView() {
        let flowLayout = NSCollectionViewFlowLayout()
        
            flowLayout.itemSize = NSSize(width: 25.0, height: 50.0)
            flowLayout.minimumInteritemSpacing = 20.0
            flowLayout.minimumLineSpacing = 20.0
            flowLayout.sectionInset = NSEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        
            collectionView.collectionViewLayout = flowLayout
            view.wantsLayer = true
            collectionView.layer?.backgroundColor = NSColor.blackColor().CGColor
            print("It Ran")
    }
    
    
    func createCollectionView(imageArray: [String]) {
        
        
        
    }
    
    override func viewWillLayout() {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createImageArray()
        configureImageBox()
        displayRandomImage()
        NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: Selector("displayRandomImage"), userInfo: nil, repeats: true)
        
        

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

