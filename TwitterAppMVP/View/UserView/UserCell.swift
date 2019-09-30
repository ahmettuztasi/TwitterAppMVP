//
//  UserCell.swift
//  TwitterAppMVP
//
//  Created by KO on 24/09/2019.
//  Copyright © 2019 Ahmet Tuztașı. All rights reserved.
//

import Foundation
import UIKit

class UserCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var bioText: UITextView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var coverImg: UIImageView!
    @IBOutlet weak var saveBtn: UIButton!
}
