//
//  Meme.swift
//  MemeMe
//
//  Created by Mikel Lizarralde Cabrejas on 26/3/15.
//  Copyright (c) 2015 TheUnit. All rights reserved.
//

import Foundation
import UIkit

class Meme: NSObject {
    var topText : NSString?
    var bottomText : NSString?
    var image : UIImage
    var memeImage : UIImage
    
    init (topText:String,bottomText:String,image:UIImage,memeImage:UIImage)
    {
        self.topText = topText
        self.bottomText = bottomText
        self.image = image
        self.memeImage = memeImage
    }
}
