//
//  GameViewController.swift
//  Poker Trial 3
//
//  Created by Ronnak Saxena on 6/13/20.
//  Copyright © 2020 Ronnak Saxena & Sam Meyerowitz. All rights reserved.
//

import FirebaseDatabase
import Firebase
import UIKit
import SpriteKit
import GameplayKit
import MessageUI

class Main: UIViewController {
    
    @IBOutlet weak var joinButton: UIButton!
    
    @IBOutlet weak var createButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        joinButton.layer.cornerRadius = 10.0
        joinButton.tintColor = UIColor.white
        joinButton.layer.borderWidth = 2.0
        joinButton.layer.borderColor = CGColor.init(srgbRed: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        createButton.layer.cornerRadius = 10.0
        createButton.tintColor = UIColor.white
        createButton.layer.borderWidth = 2.0
        createButton.layer.borderColor = CGColor.init(srgbRed: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
        
        // reference to server
        let ref = Database.database().reference()
        //deletes rooms that have been there for longer than 1 day
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let rooms = snapshot.value as? [String:Any] else{return}
            let curDate = Date().timeIntervalSince1970
            for roomId in rooms.keys {
                guard let curRoom = rooms[roomId] as? [String:Any] else{return}
                guard let timeStamp = curRoom["timeStamp"] as? TimeInterval else{return}
                if timeStamp < curDate - (60.0 * 60.0 * 24.0)  {
                    ref.child(roomId).removeValue()
                }
            }
        })
        

    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return UIInterfaceOrientationMask.portrait
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
}







