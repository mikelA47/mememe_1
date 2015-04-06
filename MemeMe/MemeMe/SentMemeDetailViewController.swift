//
//  SentMemesDetailViewController.swift
//  MemeMe
//
//  Created by Mikel Lizarralde Cabrejas on 6/4/15.
//  Copyright (c) 2015 TheUnit. All rights reserved.
//

import UIKit

class SentMemeDetailViewController: UIViewController {

    @IBOutlet weak var memeImage: UIImageView!
    
    var meme: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.memeImage.image = meme.memeImage
    }
}
