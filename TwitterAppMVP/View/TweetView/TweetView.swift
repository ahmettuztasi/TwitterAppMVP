//
//  ViewController.swift
//  TwitterAppMVP
//
//  Created by KO on 24/09/2019.
//  Copyright © 2019 Ahmet Tuztașı. All rights reserved.
//

import UIKit

class TweetView: UIViewController, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var tweetView: UICollectionView!
    
    // Activity Indicator
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    // Using for user id didselectitem, sending UserViewController
    var userId: Int?
    
    // Connection Alert
    var alert = UIAlertController(title: "Opps", message: "Internet Baglantinizi Kontrol Ediniz", preferredStyle: UIAlertControllerStyle.alert)
    
    // Tweet List
    var tweet : [Tweet]? {
        didSet {
            activityIndicator.stopAnimating()
            
            DispatchQueue.main.async {
                if self.tweetView != nil {
                    self.tweetView.reloadData()
                }
            }
            if self.tweetView != nil {
                self.tweetView.reloadData()
            }

        }
    }
    
    // Activity Indicator starter
    func activityIndicatorStarter() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    // Move to TweetPresenter
    // Get tweet's user image
    func getImage(url: URL?) -> UIImage {
        //profile image view
        let data = try? Data(contentsOf: url!)
        if(data == nil) {
            //Toast(text: "Internete bağlı değilsiniz", delay: 0, duration: 2).show()
        } else {
            return UIImage(data: data!)!
        }
        return UIImage()
    }
    
    // Hide the status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! UserView
        vc.userId = self.userId
        vc.tweetList = self.tweet
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tweetPresenter = TweetPresenter(delegate: self)
        
        // Connection Alert
        alert.addAction(UIAlertAction(title: "Reload", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            tweetPresenter.getTweets()
            //self.tweetView.reloadData()
        }))
        
        // Do any additional setup after loading the view, typically from a nib.
        tweetView?.delegate = self
        tweetView?.dataSource = self
        
        if tweet == nil {
            activityIndicatorStarter()
            tweetPresenter.getTweets()
        }
        //transition effect
        self.modalTransitionStyle = .crossDissolve
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension TweetView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweet?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let tweetCell = collectionView.dequeueReusableCell(withReuseIdentifier: "tweetCell", for: indexPath) as! TweetCell
        if(self.tweet != nil){
            
            tweetCell.tweetText.text = self.tweet![indexPath.item].tweetText
            
            tweetCell.fullName.text = self.tweet![indexPath.item].fullName
            tweetCell.userName.text = String(self.tweet![indexPath.item].profile)
            
            let url = URL(string: (tweet![indexPath.item].profileImgUrl))
            
            tweetCell.profileImage.image = getImage(url: url)
        }
        return tweetCell
    }
    
    // Segue
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.userId = self.tweet![indexPath.item].userId
        self.performSegue(withIdentifier: "userView", sender: indexPath);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }

}

extension TweetView: ITweetPresenter {
    func onTweetResolved(tweetList: [Tweet]) {
        // Fill the TweetList
        self.tweet = tweetList
    }
    
    func onError(message: Bool) {
        // Show error message to client
        if message {

        }else {
            self.present(alert, animated: true)
        }
    }
}

