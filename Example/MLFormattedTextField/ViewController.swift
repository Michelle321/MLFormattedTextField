//
//  ViewController.swift
//  MLFormattedTextField
//
//  Created by Michelle on 12/07/2017.
//  Copyright (c) 2017 Michelle. All rights reserved.
//

import UIKit
import MLFormattedTextField

class ViewController: UIViewController, UITextFieldDelegate {

    var currentTextField: UITextField? = nil
    
    @IBOutlet weak var phoneNumber: MLFormattedTextField!
    @IBOutlet weak var phoneNumberNoPrefix: MLFormattedTextField!
    @IBOutlet weak var creditCard: MLFormattedTextField!
    @IBOutlet weak var modelNumber: MLFormattedTextField!
    @IBOutlet weak var HealthCardNumber: MLFormattedTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneNumber.prefix = "(416) "
        phoneNumber.format = "XXX-XXXX"
        
        phoneNumberNoPrefix.format = "(XXX) XXX XXXX"
        creditCard.format = "XXXX XXXX XXXX XXXX"
        modelNumber.format = "MCXXXXX"
        HealthCardNumber.format = "XXXX-XXXX-XXXXL"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }

    @objc func keyboardWasShown(notification : Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            if let textFieldFrame = self.currentTextField?.frame {
                var visiableRect = self.view.frame
                visiableRect.size.height -= keyboardRectangle.size.height
                if !visiableRect.contains(textFieldFrame){
                    let scrollPoint = textFieldFrame.origin.y - visiableRect.size.height + textFieldFrame.size.height + 20
                    self.view.frame.origin.y -= scrollPoint
                }
            }
        }
    }
    @IBAction func tapOutside(_ sender: Any) {
        self.currentTextField?.resignFirstResponder()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.currentTextField = textField;
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.currentTextField = nil
        textField.resignFirstResponder()
        return true
    }
    
    @objc func keyboardWillHide(notification : Notification) {
        self.view.frame.origin.y = 0
    }
}

