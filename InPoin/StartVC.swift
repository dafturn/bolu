//
//  StartVC.swift
//  InPoin
//
//  Created by Dafturn Technology on 4/19/17.
//  Copyright © 2017 Dafturn Technology. All rights reserved.
//

import UIKit

class StartVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if FIRST_BOOT || goingToHome || goingToLogin {
            //activityLoading.startAnimating()
            //viewFrame.isHidden = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
        
        if FIRST_BOOT {
//            if let save_session = UserDefaults.standard.string(forKey: "mc_session") {
//                SESSION_ID = save_session
//            }
//            if let save_session = UserDefaults.standard.string(forKey: "mc_ideva") {
//                ID_eVa = save_session
//            }
//            if let save_session = UserDefaults.standard.string(forKey: "mc_saldo") {
//                SALDO = save_session
//            }
//            if let save_session = UserDefaults.standard.string(forKey: "mc_username") {
//                USER_NAME = save_session
//            }
//            if let save_session = UserDefaults.standard.string(forKey: "mc_usertelephone") {
//                USER_TELEPHONE = save_session
//            }
//            if let save_session = UserDefaults.standard.string(forKey: "mc_userpin") {
//                USER_PIN = save_session
//            }
//            
//            if SESSION_ID != "" {
//                goingToHome = true
//            }
        }
        
        if goingToHome {
            //activityLoading.startAnimating()
            //viewFrame.isHidden = true
            
            FIRST_BOOT = false
            goingToHome = false
            //refreshBalance = true
            
            performSegue(withIdentifier: "startToHome", sender: nil)
            return
        } else if goingToLogin {
            //activityLoading.startAnimating()
            //viewFrame.isHidden = true
            
            goingToLogin = false
            
            performSegue(withIdentifier: "startToLogin", sender: nil)
            return
        } else {
            //activityLoading.stopAnimating()
            //viewFrame.isHidden = false
        }
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
}
