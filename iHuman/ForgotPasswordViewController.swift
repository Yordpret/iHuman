//
//  ForgotPasswordViewController.swift
//  iHuman
//
//  Created by Sarat Rachatavet on 5/22/15.
//  Copyright (c) 2015 Codian-X. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailResetPassword: UITextField!
    
    let alert = UIAlertView()
    
    @IBAction func ResetPassword(sender: UIButton) {
        var url: NSURL = NSURL(string: "http://ihuman.somee.com/api/account/ForgetPassword")!
        var request:NSMutableURLRequest = NSMutableURLRequest(URL:url)
        var bodyData = "Email=\(emailResetPassword.text)"
        
        request.HTTPMethod = "POST"
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(),completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            if let HTTPResponse = response as? NSHTTPURLResponse {
                
                let statusCode = HTTPResponse.statusCode
                if statusCode == 200 {
                    println("Signed In!")
                }
                else {
                    let results = JSON(data: data)
                    var resultsMessage = results["message"]
                    println(results["message"])
                    self.alert.title = "Error"
                    self.alert.message = "\(resultsMessage)"
                    self.alert.addButtonWithTitle("OK")
                    self.alert.show()
                }
            }
        })
    }
}

