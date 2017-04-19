//
//  ViewController.swift
//  InPoin
//
//  Created by Dafturn Technology on 4/13/17.
//  Copyright © 2017 Dafturn Technology. All rights reserved.
//

import UIKit
import Alamofire

class HomeVC: UIViewController {
    @IBOutlet weak var topBar: UIView!

    @IBOutlet weak var userPhoto: UIButton!
    @IBOutlet weak var userName: UIButton!
    
    @IBOutlet weak var userPoinLabel: UIButton!
    @IBOutlet weak var userPoin: UIButton!
    @IBOutlet weak var userSeparator: UIView!
    @IBOutlet weak var coinsLogo: UIButton!
    
    @IBOutlet weak var slideShow: ImageSlideshow!
    
    @IBOutlet weak var tabBar: UIView!
    @IBOutlet weak var logoTop: UIImageView!
    
    @IBOutlet weak var tabHome: UIView!
    @IBOutlet weak var tabHomeIcon: UIImageView!
    @IBOutlet weak var tabHomeLabel: UIButton!
    @IBOutlet weak var tabHomeButton: UIButton!
    
    @IBOutlet weak var tabKatalog: UIView!
    @IBOutlet weak var tabKatalogIcon: UIImageView!
    @IBOutlet weak var tabKatalogLabel: UIButton!
    @IBOutlet weak var tabKatalogButton: UIButton!
    
    @IBOutlet weak var tabBUMN: UIView!
    @IBOutlet weak var tabBUMNIcon: UIImageView!
    @IBOutlet weak var tabBUMNLabel: UIButton!
    @IBOutlet weak var tabBUMNButton: UIButton!
    
    @IBOutlet weak var tabHelp: UIView!
    @IBOutlet weak var tabHelpIcon: UIImageView!
    @IBOutlet weak var tabHelpLabel: UIButton!
    @IBOutlet weak var tabHelpButton: UIButton!
    
    @IBOutlet weak var bumnLabel: UIButton!
    @IBOutlet weak var bumnScrollView: UIScrollView!
    @IBOutlet weak var bumnView: UIView!
    @IBOutlet weak var bni: UIButton!
    @IBOutlet weak var bri: UIButton!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var mandiri: UIButton!
    @IBOutlet weak var garuda: UIButton!
    @IBOutlet weak var kimiaFarma: UIButton!
    @IBOutlet weak var pertamina: UIButton!
    @IBOutlet weak var telkom: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        
        let parameters: [String: [String: String]] = ["inputTransaction": [
            "MTI" : "0200",
            "bit3" : "mobileios",
            "bit4" : "0",
            "bit11": "13245",
            "bit32": "08118401296",
            "bit33": "453675468791322",
            "bit48": "242526",
            "bit61": "08118401296",
            "typetrx": "login"
        ]]
        
        Alamofire.request(INPOIN_SERVER, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)
                print(json)
            case .failure(_):
                let alert = UIAlertController(title: appName, message: "Maaf, koneksi internet gagal atau tidak ada koneksi internet.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                
                //self.buttonSignIn.isEnabled = true
                //self.activityLoading.stopAnimating()
            }
        }
    }
    
    func prepareUI(){
        topBar.frame.size.width = view.bounds.width
        logoTop.center.x = view.center.x
        
        coinsLogo.frame.origin.x = view.bounds.width - 46
        userPoinLabel.frame.origin.x = view.bounds.width - userPoinLabel.bounds.width - 30
        userPoin.frame.origin.x = view.bounds.width - userPoin.bounds.width - 30
        userSeparator.frame.origin.x = userPoin.frame.origin.x - 16
        
        userName.frame.size.width = view.bounds.width - userPoin.bounds.width - userName.frame.origin.x - 52
        
        slideShow.frame.origin.x = 0
        slideShow.frame.size.width = view.bounds.width
        
        
        // Slideshow
        
        if view.bounds.width >= 410 {
            slideShow.frame.size.height = view.bounds.width / 2.0
            bumnLabel.frame.origin.y = slideShow.frame.origin.y + slideShow.bounds.height + 10.0
            bumnScrollView.frame.origin.y = bumnLabel.frame.origin.y + bumnLabel.bounds.height + 3.0
        }
        
        loadSlideShow()
        
        
        // BUMN Tiles
        
        bumnTiles()
        
        
        // Tab bar
        
        loadTabBar()
    }
    
    func bumnTiles(){
        bni.frame.size.width = (view.bounds.width - 1.5) / 4.0
        bri.frame.size.width = (view.bounds.width - 1.5) / 4.0
        btn.frame.size.width = (view.bounds.width - 1.5) / 4.0
        mandiri.frame.size.width = (view.bounds.width - 3.0) / 4.0
        garuda.frame.size.width = (view.bounds.width - 1.5) / 4.0
        kimiaFarma.frame.size.width = (view.bounds.width - 1.5) / 4.0
        pertamina.frame.size.width = (view.bounds.width - 1.5) / 4.0
        telkom.frame.size.width = (view.bounds.width - 3.0) / 4.0
        
        bri.frame.origin.x = bni.frame.size.width + 0.3
        btn.frame.origin.x = (bri.frame.size.width + bri.frame.origin.x) + 0.4
        mandiri.frame.origin.x = (btn.frame.size.width + btn.frame.origin.x) + 0.4
        kimiaFarma.frame.origin.x = garuda.frame.size.width + 0.3
        pertamina.frame.origin.x = (kimiaFarma.frame.size.width + kimiaFarma.frame.origin.x) + 0.4
        telkom.frame.origin.x = (pertamina.frame.size.width + pertamina.frame.origin.x) + 0.4
        
        bni.frame.origin.y = 0.3
        bri.frame.origin.y = 0.3
        btn.frame.origin.y = 0.3
        mandiri.frame.origin.y = 0.3
        garuda.frame.origin.y = bni.frame.origin.y + bni.bounds.height + 0.5
        kimiaFarma.frame.origin.y = bni.frame.origin.y + bni.bounds.height + 0.5
        pertamina.frame.origin.y = bni.frame.origin.y + bni.bounds.height + 0.5
        telkom.frame.origin.y = bni.frame.origin.y + bni.bounds.height + 0.5
        
        bumnView.frame.size.height = 120.0 + 1.3
        bumnView.frame.size.width = view.bounds.width
        
        bumnScrollView.frame.size.width = view.bounds.width
        bumnScrollView.frame.size.height = view.bounds.height - bumnScrollView.frame.origin.y - 60.0
        
        bumnScrollView.contentSize.height = bumnView.bounds.height
    }
    
    func loadTabBar(){
        tabBar.frame.origin.x = 0
        tabBar.frame.origin.y = view.bounds.height - tabBar.bounds.height
        tabBar.frame.size.width = view.bounds.width
        
        tabHome.frame.origin.x = 0
        tabHomeIcon.frame.origin.x = 0
        tabHomeLabel.frame.origin.x = 0
        tabHome.frame.size.width = view.bounds.width / 4.0
        tabHomeIcon.frame.size.width = tabHome.bounds.width
        tabHomeLabel.frame.size.width = tabHome.bounds.width
        tabHomeButton.frame.size.width = tabHome.bounds.width
        tabHomeButton.frame.size.height = tabHome.bounds.height
        
        tabKatalog.frame.origin.x = tabHome.bounds.width
        tabKatalogIcon.frame.origin.x = 0
        tabKatalogLabel.frame.origin.x = 0
        tabKatalog.frame.size.width = view.bounds.width / 4.0
        tabKatalogIcon.frame.size.width = tabKatalog.bounds.width
        tabKatalogLabel.frame.size.width = tabKatalog.bounds.width
        tabKatalogButton.frame.size.width = tabKatalog.bounds.width
        tabKatalogButton.frame.size.height = tabKatalog.bounds.height
        
        tabBUMN.frame.origin.x = tabHome.bounds.width * 2
        tabBUMNIcon.frame.origin.x = 0
        tabBUMNLabel.frame.origin.x = 0
        tabBUMN.frame.size.width = view.bounds.width / 4.0
        tabBUMNIcon.frame.size.width = tabBUMN.bounds.width
        tabBUMNLabel.frame.size.width = tabBUMN.bounds.width
        tabBUMNButton.frame.size.width = tabBUMN.bounds.width
        tabBUMNButton.frame.size.height = tabBUMN.bounds.height
        
        tabHelp.frame.origin.x = tabHome.bounds.width * 3
        tabHelpIcon.frame.origin.x = 0
        tabHelpLabel.frame.origin.x = 0
        tabHelp.frame.size.width = view.bounds.width / 4.0
        tabHelpIcon.frame.size.width = tabHelp.bounds.width
        tabHelpLabel.frame.size.width = tabHelp.bounds.width
        tabHelpButton.frame.size.width = tabHelp.bounds.width
        tabHelpButton.frame.size.height = tabHelp.bounds.height
    }
    
    func loadSlideShow(){
        let localSource = [ImageSource(imageString: "bann1a")!, ImageSource(imageString: "bann1b")!, ImageSource(imageString: "bann1c")!, ImageSource(imageString: "bann2")!, ImageSource(imageString: "bann3")!, ImageSource(imageString: "bann4")!]
        
        slideShow.backgroundColor = UIColor.white
        slideShow.slideshowInterval = 5.0
        slideShow.pageControlPosition = PageControlPosition.insideScrollView
        slideShow.pageControl.currentPageIndicatorTintColor = UIColor.white
        slideShow.pageControl.pageIndicatorTintColor = UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.7)
        slideShow.contentScaleMode = UIViewContentMode.scaleAspectFill
        slideShow.clipsToBounds = true
        slideShow.currentPageChanged = { page in
            //print("current page:", page)
        }
        
        // try out other sources such as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
        slideShow.setImageInputs(localSource)
    }
	
    @IBAction func tabHomeTapped(_ sender: UIButton) {
        print("OK")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
}
