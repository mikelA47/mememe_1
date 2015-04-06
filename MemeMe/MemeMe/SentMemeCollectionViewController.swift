//
//  SentMemeCollectionViewController.swift
//  MemeMe
//
//  Created by Mikel Lizarralde Cabrejas on 25/3/15.
//  Copyright (c) 2015 TheUnit. All rights reserved.
//

import UIKit

//let reuseIdentifier = "customCell"

class SentMemeCollectionViewController: UICollectionViewController, UICollectionViewDataSource{
 
    var memes: [Meme]!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as AppDelegate
        memes = appDelegate.memes
        self.collectionView?.reloadData()
    }
    
    @IBAction func newMeme(sender: UIBarButtonItem) {
        let memeEditor = self.storyboard?.instantiateViewControllerWithIdentifier("MemeEditor") as MemeEditorViewController
        self.navigationController!.presentViewController(memeEditor, animated: true, completion: nil)
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SentMemeCollectionViewCell", forIndexPath: indexPath) as SentMemeCollectionViewCell
        let meme = self.memes[indexPath.item]
        cell.memeImage?.image = meme.memeImage
        return cell
    }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath)
    {
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("SentMemeDetailViewController")! as SentMemeDetailViewController
        detailController.meme = self.memes[indexPath.item]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
}
