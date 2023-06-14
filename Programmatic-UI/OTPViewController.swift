//
//  OTPViewController.swift
//  Programmatic-UI
//
//  Created by deepak-pt6306 on 19/05/23.
//

import UIKit
import MessageUI

class OTPViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call the function to generate OTP and send it to email
        generateAndSendOTP()
    }
    
    func generateOTP() -> String {
        let length = 6 // Change the length of the OTP as needed
        let base32 = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567".map { $0 }
        
        var otp = ""
        for _ in 0..<length {
            let randomIndex = Int.random(in: 0..<base32.count)
            otp += String(base32[randomIndex])
        }
        
        return otp
    }
    
    func sendOTPToEmail(otp: String, email: String) {
//        if !MFMailComposeViewController.canSendMail() {
//            print("Cannot send email")
//            return
//        }
        
        let mailComposeViewController = MFMailComposeViewController()
        mailComposeViewController.mailComposeDelegate = self
        mailComposeViewController.setToRecipients([email])
        mailComposeViewController.setSubject("OTP Verification")
        mailComposeViewController.setMessageBody("Your OTP: \(otp)", isHTML: false)
        
        present(mailComposeViewController, animated: true, completion: nil)
    }
    
    func generateAndSendOTP() {
        let otp = generateOTP()
        let email = "19eca09@karpagamtech.ac.in" // Replace with the recipient's email address
        sendOTPToEmail(otp: otp, email: email)
    }
    
    // MARK: - MFMailComposeViewControllerDelegate
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
