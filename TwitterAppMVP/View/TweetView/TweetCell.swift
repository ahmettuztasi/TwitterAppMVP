//
//  TweetCell.swift
//  TwitterAppMVP
//
//  Created by KO on 24/09/2019.
//  Copyright © 2019 Ahmet Tuztașı. All rights reserved.
//

import Foundation
import UIKit

class TweetCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var tweetText: UITextView!
}
