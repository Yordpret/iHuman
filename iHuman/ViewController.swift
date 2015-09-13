//
//  ViewController.swift
//  iHuman
//
//  Created by Sarat Rachatavet on 5/22/15.
//  Copyright (c) 2015 Codian-X. All rights reserved.
//

import UIKit

class RoundedUITableView: UITableView {
    override func drawRect(rect: CGRect) {
        updateLayerProperties()
    }
    func updateLayerProperties() {
        layer.cornerRadius = 6.0
    }
}

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    let alert = UIAlertView()
    
    @IBAction func Login(sender: UIButton) {
        var url: NSURL = NSURL(string: "http://ihuman.somee.com/oauth/token")!
        var request:NSMutableURLRequest = NSMutableURLRequest(URL:url)
        var bodyData = "grant_type=password&username=\(username.text)&password=\(password.text)"
        
        request.HTTPMethod = "POST"
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(),completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            if let HTTPResponse = response as? NSHTTPURLResponse {
                
                let statusCode = HTTPResponse.statusCode
                if statusCode == 200 {
                    self.performSegueWithIdentifier("LoginSegue",sender: self)
                    println("Signed In!")
                }
                else {
                    let results = JSON(data: data)
                    var resultsMessage = results["error_description"]
                    println(results["error_description"])
                    self.alert.title = "Incorrect Password"
                    self.alert.message = "\(resultsMessage)"
                    self.alert.addButtonWithTitle("OK")
                    self.alert.show()
                }
            }
        })
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    //Calls this function when the tap is recognized.
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.username.delegate = self
        self.password.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        //Looks for single or multiple taps.
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

