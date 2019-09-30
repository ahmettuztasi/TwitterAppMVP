//
//  UserView.swift
//  TwitterAppMVP
//
//  Created by KO on 24/09/2019.
//  Copyright © 2019 Ahmet Tuztașı. All rights reserved.
//

import UIKit

class UserView: UIViewController, UICollectionViewDelegateFlowLayout {
    
    var fullName: String? = nil
    var userName: String? = nil
    var tweetList : [Tweet]?
    
    // User Collection View
    @IBOutlet var userView: UICollectionView!

    // Activity Indicator
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    // Connection Alert
    var alert = UIAlertController(title: "Opps", message: "Internet Baglantinizi Kontrol Ediniz", preferredStyle: UIAlertControllerStyle.alert)
    
    // User Cell
    var userCell: UserCell? = nil
    
    // User Presenter Delegate
    var userPresenter: UserPresenter? = nil
    
    // User model
    var user: User? {
        didSet {
            activityIndicator.stopAnimating()
            
            DispatchQueue.main.async {
                self.userView.reloadData()
            }
            userView.reloadData()
        }
    }
    
    // User id
    var userId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        userView?.delegate = self
        userView?.dataSource = self
        
        userPresenter = UserPresenter(delegate: self)
        userPresenter?.getUserById(userId: userId!)
        
        // Activity Indicator Start
        activityIndicatorStarter()
        
        // Connection Alert
        alert.addAction(UIAlertAction(title: "Reload", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            self.userPresenter?.getUserById(userId: self.userId!)
        }))
        
        // Transition Effect
        self.modalTransitionStyle = .crossDissolve
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Hide the status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // Activity Indicator Function
    func activityIndicatorStarter() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    // Back to tweetView
    @IBAction func tweetView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // Save edit
    @IBAction func saveUser(_ sender: Any) {
        
        //segue to tweetview
        self.performSegue(withIdentifier: "tweetView", sender: Any?.self);
    }
    
    // Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        userPresenter?.saveUserInfo(userId: userId!, userName: (userCell?.fullName.text)!, fullName: (userCell?.userName.text)!)
        for i in 0...(tweetList!.count - 1) {
            if tweetList![i].userId == userId {
                tweetList![i].fullName = (userCell?.fullName.text)!
                tweetList![i].profile = (userCell?.userName.text)!
            }
        }
        
        let vc = segue.destination as! TweetView
        vc.tweet = self.tweetList
    }
}

extension UserView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        userCell = collectionView.dequeueReusableCell(withReuseIdentifier: "userCell", for: indexPath) as? UserCell
        if userCell?.isHidden == true {
            userCell?.isHidden = false
        }else {
            userCell?.isHidden = true
        }
        
        if user?.fullName != nil {
            userCell?.fullName.text = user?.fullName
        }
        if user?.age != nil{
            userCell?.bioText.text = "I am \(user!.age) years old"
        }
        if user?.profile != nil {
            userCell?.userName.text = user?.profile
        }
        if user?.profileImgUrl != nil { // Move to UserPresenter
            let url = URL(string: (user?.profileImgUrl)!)
            let data = try? Data(contentsOf: url!)
            if(data != nil) {
                userCell?.profileImg.image = UIImage(data: data!)
            }
        }
        return userCell!
    }
}

extension UserView: IUserPresenter {
    func onUserResolved(user: User) {
        self.user = user
    }
    
    func onError(message: Bool) {
        if message {
            
        }else {
            self.present(alert, animated: true)
        }
    }
}
