//
//  Global.swift
//  InPoin
//
//  Created by Dafturn Technology on 4/19/17.
//  Copyright © 2017 Dafturn Technology. All rights reserved.
//

import UIKit

let appName: String = "InPoin"
var goingToHome: Bool = false
var goingToLogin: Bool = false

let CHECKED: Int = 1
let UNCHECKED: Int = 2

let APP_PLATFORM = "ios"
let APP_VERSION = "1.0.0"

let INPOIN_SERVER_PRODUCTION: String = "https://inpoinapi.finnet.co.id/"
let INPOIN_SERVER_DEVELOPMENT: String = "https://demos.finnet.co.id/inpoinapi/"
let INPOIN_SERVER_BTN_PRODUCTION: String = "https://inpoinbank.finnet.co.id/"
let INPOIN_SERVER_BTN_DEVELOPMENT: String = "https://demos.finnet.co.id/inpoinbank/"

let INPOIN_SERVER: String = INPOIN_SERVER_PRODUCTION
let INPOIN_SERVER_BTN: String = INPOIN_SERVER_BTN_PRODUCTION

var SESSION_ID: String = ""
var ID_eVa: String = ""
var SALDO: String = ""
var USER_NAME: String = ""
var USER_TELEPHONE: String = ""
var USER_PIN: String = ""

var FIRST_BOOT: Bool = true

var history: JSON = []
var fromFavorite: Bool = false
var favoriteItem: JSON = []

let responseMessage: [String: String] = [
	"110": "Salah inputan data",
	"213": "Maaf, nomor handphone atau PIN salah"
]

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return substring(to: toIndex)
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return substring(with: startIndex..<endIndex)
    }
    
    func condenseWhitespace() -> String {
        let components = self.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
}

struct Number {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension Integer {
    var stringSeparator: String {
        return Number.withSeparator.string(from: NSNumber(value: hashValue)) ?? ""
    }
}

func setTimeout(delay: TimeInterval, block: @escaping() -> Void) -> Timer {
    return Timer.scheduledTimer(timeInterval: delay, target: BlockOperation(block: block), selector: #selector(Operation.main), userInfo: nil, repeats: false)
}

func setInterval(delay: TimeInterval, block: @escaping() -> Void) -> Timer {
    return Timer.scheduledTimer(timeInterval: delay, target: BlockOperation(block: block), selector: #selector(Operation.main), userInfo: nil, repeats: true)
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIView {
    func makeBlur(){
        self.backgroundColor = UIColor.clear
        
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.frame
        
        self.insertSubview(blurEffectView, at: 0)
    }
    
    func makeBlur(height: CGFloat){
        self.backgroundColor = UIColor.clear
        
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.frame
        blurEffectView.frame.size.height = height
        
        self.insertSubview(blurEffectView, at: 0)
    }
    
    func makeBlur(width: CGFloat){
        self.backgroundColor = UIColor.clear
        
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.frame
        blurEffectView.frame.size.width = width
        
        self.insertSubview(blurEffectView, at: 0)
    }
    
    func makeBlur(width: CGFloat, height: CGFloat){
        self.backgroundColor = UIColor.clear
        
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.frame
        blurEffectView.frame.size.height = height
        blurEffectView.frame.size.width = width
        
        self.insertSubview(blurEffectView, at: 0)
    }
    
    func makeBlurDark(height: CGFloat){
        self.backgroundColor = UIColor.clear
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.frame
        blurEffectView.frame.size.height = height
        
        self.insertSubview(blurEffectView, at: 0)
    }
    
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
}

class TextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8);
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
}

extension UITextField {
    func makeCombo() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 1, width: 24, height: 24))
        imageView.contentMode = .right
        imageView.image = UIImage(named: "combo")
        imageView.isUserInteractionEnabled = true
        let viewRight: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        viewRight.addSubview(imageView)
        self.rightView = viewRight
        self.rightViewMode = .always
    }
    
    func setLeftPaddingPoints(_ amount: CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func setBorder(){
        self.borderStyle = .none
        self.layoutIfNeeded()
        
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = UIColor.init(red: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1).cgColor
        
        print(self.frame)
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    func setBorderLight(){
        self.borderStyle = .none
        self.layoutIfNeeded()
        
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = UIColor.white.cgColor
        border.opacity = 0.5
        
        print(self.frame)
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

extension UIButton {
    func makeChecked() {
        self.tag = CHECKED
        
        self.setImage(UIImage(named: "check"), for: .normal)
        self.layer.backgroundColor = UIColor.init(red: 34.0/255.0, green: 192.0/255.0, blue: 100.0/255.0, alpha: 1).cgColor
        self.layer.cornerRadius = 0.5 * self.bounds.height
        self.layer.borderWidth = 0
    }
    
    func makeUnchecked() {
        self.tag = UNCHECKED
        
        self.setImage(nil, for: .normal)
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.cornerRadius = 0.5 * self.bounds.height
        self.layer.borderColor = UIColor.init(red: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1).cgColor
        self.layer.borderWidth = 0.5
    }
    
    func makeTabChecked() {
        self.tag = CHECKED
        
        self.setTitleColor(UIColor.white, for: .normal)
        self.layer.backgroundColor = UIColor.init(red: 27.0/255.0, green: 154.0/255.0, blue: 247.0/255.0, alpha: 1).cgColor
        self.layer.cornerRadius = 14
        self.layer.borderWidth = 0
    }
    
    func makeTabUnchecked() {
        self.tag = UNCHECKED
        
        self.setTitleColor(UIColor.black, for: .normal)
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.cornerRadius = 14
        self.layer.borderWidth = 0
    }
    
    func makeTabCheckedAlt() {
        self.tag = CHECKED
        
        self.setTitleColor(UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.9), for: .normal)
        self.layer.backgroundColor = UIColor.black.cgColor
        self.layer.borderWidth = 0
        self.layer.cornerRadius = 13
    }
    
    func makeTabUncheckedAlt() {
        self.tag = UNCHECKED
        
        self.setTitleColor(UIColor.black, for: .normal)
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.cornerRadius = 14
        self.layer.borderWidth = 0
    }
}

extension UIScrollView {
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: true)
    }
}

class ComboTextField: UITextField {
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(paste(_:)) {
            return false
        }
        
        return true
    }
}

extension JSON {
    mutating func append(json: JSON) {
        if var arr = self.array {
            arr.insert(json, at: 0)
            self = JSON(arr)
        }
    }
    
    mutating func reverse() {
        if var arr = self.array {
            arr = arr.reversed()
            self = JSON(arr)
        }
    }
    
    mutating func remove(index: Int) {
        if var arr = self.array {
            arr.remove(at: index)
            self = JSON(arr)
        }
    }
}

func loadHistory() {
    var str = readDataFromFile(file: "history-" + USER_TELEPHONE)
    
    if str.isEmpty || str == "null" {
        str = "{\"history\": [], \"favorite\": []}"
    }
    
    let dataFromString = str.data(using: .utf8)
    history = JSON(dataFromString!)
    
    //    addHistory(item: [
    //        "type": "pln",
    //        "title": "PLN Postpaid",
    //        "detail": getCurrentDateTime() + " | " + "16777865777" + " | Rp. " + "450000" + ",- ",
    //        "jenisLayanan": "PLN Postpaid",
    //        "nomorPelanggan": "16777865777",
    //        "namaPelanggan": "Sulaiman",
    //        "standMeter": "47000000000 - 47000001234",
    //        "tarifDaya": "R1/450",
    //        "periode": "Maret 2017",
    //        "tagihan": "450000",
    //        "biayaAdministrasi": "0",
    //        "totalTagihan": "450000",
    //        "time": getCurrentTime(),
    //        "date": getCurrentFullDate()
    //        ])
    
    //    addFavorite(item: [
    //        "type": "pln",
    //        "title": "PLN Postpaid",
    //        "detail": "675768767867",
    //        "jenisLayanan": "PLN Postpaid",
    //        "nomorPelanggan": "675768767867"
    //        ])
    
    //    addFavorite(item: [
    //        "type": "top-up-pulsa",
    //        "title": "Top Up Pulsa",
    //        "detail": "THREE" + " | Rp. " + "25.000" + ",- ",
    //        "opr": "THREE",
    //        "notel": "089898979695",
    //        "denom": "25.000 / 24.850"
    //        ])
    //
    //    addHistory(item: [
    //        "type": "bpjs-kesehatan",
    //        "title": "BPJS Kesehatan",
    //        "detail": getCurrentDateTime() + " | " + "88888989898998" + " | Rp. " + "76000" + ",- ",
    //        "jenisLayanan": "BPJS Kesehatan",
    //        "nomorPelanggan": "88888989898998",
    //        "jumlahAnggota": "3",
    //        "jumlahBulan": "3 Bulan",
    //        "totalSaldo": "76000",
    //        "totalPremi": "76000",
    //        "time": getCurrentTime(),
    //        "date": getCurrentFullDate()
    //        ])
    
    //    addFavorite(item: [
    //        "type": "bpjs-kesehatan",
    //        "title": "BPJS Kesehatan",
    //        "detail": "67867867867",
    //        "jenisLayanan": "BPJS Kesehatan",
    //        "nomorPelanggan": "678678678678",
    //        "jumlahBulan": "3" + " Bulan"
    //        ])
}

func saveHistory() {
    _ = writeDataToFile(data: history.description, file: "history-" + USER_TELEPHONE)
}

func addHistory(item: JSON) {
    history["history"].append(json: item)
    saveHistory()
}

func addFavorite(item: JSON) {
    history["favorite"].append(json: item)
    saveHistory()
}

func removeFavorite(index: Int) {
    if history["favorite"].count == 1 {
        let hist = history["history"].description
        let str = "{\"history\": \(hist), \"favorite\": []}"
        
        _ = writeDataToFile(data: str, file: "history-" + USER_TELEPHONE)
        
        let dataFromString = str.data(using: .utf8)
        history = JSON(dataFromString!)
    } else {
        history["favorite"].remove(index: index)
        saveHistory()
    }
}

func readDataFromFile(file: String) -> String {
    let documentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    let fileURL = documentDirURL.appendingPathComponent(file).appendingPathExtension("json")
    
    do {
        let contents = try String(contentsOf: fileURL, encoding: String.Encoding.utf8)
        print("Sukses read")
        return contents
    } catch let error as NSError {
        print("File Read Error for file \(fileURL)" + error.localizedDescription)
        return ""
    }
}

func writeDataToFile(data: String, file: String) -> Bool {
    let documentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    let fileURL = documentDirURL.appendingPathComponent(file).appendingPathExtension("json")
    
    do {
        try data.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        print("Sukses write")
        return true
    } catch let error as NSError {
        print("File Write Error for file \(fileURL)" + error.localizedDescription)
        return false
    }
}

func getCurrentDateTime() -> String {
    let date = Date()
    let formatter = DateFormatter()
    
    formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
    
    return formatter.string(from: date)
}

func getCurrentTime() -> String {
    let date = Date()
    let formatter = DateFormatter()
    
    formatter.dateFormat = "HH:mm:ss"
    
    return formatter.string(from: date)
}

func getCurrentFullDate() -> String {
    let date = Date()
    let formatter = DateFormatter()
    
    formatter.dateFormat = "d MMMM yyyy"
    
    return formatter.string(from: date)
}

func readImage() -> UIImage? {
    let documentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    let fileURL = documentDirURL.appendingPathComponent(USER_TELEPHONE).appendingPathExtension("jpg")
    
    let imageData = NSData(contentsOf: fileURL)
    
    if imageData != nil {
        let img = UIImage(data: imageData as! Data)
        
        if img != nil {
            return img
        } else {
            return nil
        }
    } else{
        return nil
    }
}

func saveImage(image: UIImage) {
    let imageData = UIImageJPEGRepresentation(image, 1)
    
    let documentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    let fileURL = documentDirURL.appendingPathComponent(USER_TELEPHONE).appendingPathExtension("jpg")
    
    do {
        try imageData?.write(to: fileURL, options: .atomic)
        print("Sukses image write")
    } catch let error as NSError {
        print("Image Write Error for file \(fileURL)" + error.localizedDescription)
    }
}

func removeImage() {
    removeFile(itemName: USER_TELEPHONE, fileExtension: "jpg")
}

func removeFile(itemName: String, fileExtension: String) {
    let fileManager = FileManager.default
    let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
    let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
    let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
    guard let dirPath = paths.first else {
        return
    }
    let filePath = "\(dirPath)/\(itemName).\(fileExtension)"
    do {
        try fileManager.removeItem(atPath: filePath)
    } catch let error as NSError {
        print(error.debugDescription)
    }
}
