//
//  SentMemeTableViewController.swift
//  MemeMe
//
//  Created by Mikel Lizarralde Cabrejas on 31/3/15.
//  Copyright (c) 2015 TheUnit. All rights reserved.
//

import UIKit

class SentMemeTableViewController: UITableViewController,UITableViewDelegate, UITableViewDataSource{

    var memes: [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(Bool())
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as AppDelegate
        memes = appDelegate.memes
        if memes.count == 0 {
            let memeEditor = self.storyboard?.instantiateViewControllerWithIdentifier("MemeEditor") as MemeEditorViewController
            self.navigationController!.presentViewController(memeEditor, animated: true, completion: nil)
        }
    }

    // MARK: - Table view data source
    @IBAction func newMeme(sender: UIBarButtonItem) {
        let memeEditor = self.storyboard?.instantiateViewControllerWithIdentifier("MemeEditor") as MemeEditorViewController
        self.navigationController!.presentViewController(memeEditor, animated: true, completion: nil)
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SentMemeTableViewCell", forIndexPath: indexPath) as SentMemeTableViewCell
        let meme = self.memes[indexPath.row]
        cell.memeImage.image = meme.memeImage
        cell.topBottomLabel.text = meme.topText! + "-" + meme.bottomText!
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("SentMemeDetailViewController")! as SentMemeDetailViewController
        detailController.meme = self.memes[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
}
