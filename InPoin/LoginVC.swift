//
//  LoginVC.swift
//  InPoin
//
//  Created by Dafturn Technology on 4/19/17.
//  Copyright © 2017 Dafturn Technology. All rights reserved.
//

import UIKit
import Alamofire

class LoginVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var viewFrame: UIView!

    @IBOutlet weak var textNomorHP: TextField!
    @IBOutlet weak var textPIN: TextField!
    
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var buttonLupaPIN: UIButton!
    
    @IBOutlet weak var activityLoading: UIActivityIndicatorView!
    
    var activeField: UITextField!
    var originY: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        prepareUI()
        
        registerForKeyboardNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        deregisterFromKeyboardNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    func registerForKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func deregisterFromKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWasShown(notification: NSNotification){
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        
        if let activeField = self.activeField {
            if activeField == textPIN {
                viewFrame.center.y = view.center.y - (keyboardSize?.height)! / 1.5
            } else if activeField == textNomorHP {
                viewFrame.center.y = view.center.y - (keyboardSize?.height)! / 1.5
            }
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification){
        viewFrame.frame.origin.y = originY
    }

    @IBAction func textNomorHPDidBegin(_ sender: Any) {
        activeField = textNomorHP
    }
    
    @IBAction func textNomorHPEnd(_ sender: TextField) {
        activeField = nil
    }
    
    @IBAction func textPINDidBegin(_ sender: TextField) {
        activeField = textPIN
    }
    
    @IBAction func textPINEnd(_ sender: TextField) {
        activeField = nil
    }
    
    func prepareUI(){
        // View
        
        viewFrame.center = view.center
        originY = viewFrame.frame.origin.y
        
        // Text fields
        
        textNomorHP.layer.cornerRadius = 6
        textPIN.layer.cornerRadius = 6
        
        
        // Button
        
        buttonLogin.layer.cornerRadius = 6
        buttonLogin.setTitle("", for: .disabled)
        buttonLogin.setTitle("LOGIN", for: .normal)
        
        
        // Acitivity loading
        
        activityLoading.stopAnimating()
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doLogin(_ sender: UIButton) {
        if textNomorHP.text == "" {
            let alert = UIAlertController(title: appName, message: "Maaf, Anda belum memasukkan nomor handphone", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if textPIN.text == "" {
            let alert = UIAlertController(title: appName, message: "Maaf, Anda belum memasukkan PIN", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        buttonLogin.isEnabled = false
        activityLoading.startAnimating()
        
        let phone: String = textNomorHP.text!
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        
        let parameters: [String: [String: String]] = ["inputTransaction": [
            "MTI" : "0200",
            "bit3" : "mobileios",
            "bit4" : "0",
            "bit11": "12345",
            "bit32": phone,
            "bit33": deviceID,
            "bit48": textPIN.text!,
            "bit61": phone,
            "typetrx": "login"
            ]]
        
        Alamofire.request(INPOIN_SERVER, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)["outputTransaction"]
                
                print(json)
                
                if json["bit39"].string == "00" {
//                    SESSION_ID = json["sessionid"].string!
//                    ID_eVa = json["ideva"].string!
//                    SALDO = json["saldo"].string!
//                    USER_NAME = (json["name"].string!).capitalized
//                    USER_TELEPHONE = phone
//                    USER_PIN = self.textPIN.text!
//                    
                    self.dismiss(animated: false, completion: nil)
                    goingToHome = true
                } else {
                    let alert = UIAlertController(title: appName, message: responseMessage[json["bit39"].string!]!, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)
                    
                    self.buttonLogin.isEnabled = true
                    self.activityLoading.stopAnimating()
                }
            case .failure(_):
                let alert = UIAlertController(title: appName, message: "Maaf, koneksi internet gagal atau tidak ada koneksi internet.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                
                self.buttonLogin.isEnabled = true
                self.activityLoading.stopAnimating()
            }
        }
    }
    
    @IBAction func doViewPIN(_ sender: UIButton) {
        if textPIN.isSecureTextEntry {
            textPIN.isSecureTextEntry = false
        } else {
            textPIN.isSecureTextEntry = true
        }
    }
    
    @IBAction func doLupaPIN(_ sender: UIButton) {
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 6
    }
}
