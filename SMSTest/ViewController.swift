//
//  ViewController.swift
//  SMSTest
//
//  Created by Сергей Полозов on 29.03.17.
//  Copyright © 2017 Сергей Полозов. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    
    // MARK: IBOutlets

    @IBOutlet weak var phoneNumber: UITextField!
    
    // MARK: IBActions
    
    @IBAction func tappedButton(_ sender: Any) {
        sendSMSText(phoneNumber: phoneNumber.text!)
    }
    
    // MARK: Private helpers
    
    private func sendSMSText(phoneNumber: String) {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "privet :)"
            controller.recipients = [phoneNumber]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        } else {
            if #available(iOS 9, *) {
                let alertController = UIAlertController(title: "Error", message: "can't send a message", preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
                    // ...
                }
                alertController.addAction(cancelAction)
                
                let OKAction = UIAlertAction(title: "OK", style: .default) { action in
                    // ...
                }
                alertController.addAction(OKAction)
                
                self.present(alertController, animated: true) {
                    // ...
                }
            } else {
                let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Your device is not able to send text messages.", delegate: self, cancelButtonTitle: "OK")
                errorAlert.show()
            }
        }
    }
    
    // MARK: Internal helpers
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        //... handle sms screen actions
        self.dismiss(animated: true, completion: nil)
        print("result = ")
        print(result)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
}

