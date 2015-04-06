//
//  SentMemeTableViewCell.swift
//  MemeMe
//
//  Created by Mikel Lizarralde Cabrejas on 6/4/15.
//  Copyright (c) 2015 TheUnit. All rights reserved.
//

import UIKit

class SentMemeTableViewCell: UITableViewCell {

    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var topBottomLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
