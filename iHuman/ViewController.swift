//
//  ViewController.swift
//  iHuman
//
//  Created by Sarat Rachatavet on 5/22/15.
//  Copyright (c) 2015 Codian-X. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func Login(sender: UIButton) {
        var url: NSURL = NSURL(string: "http://ihuman.somee.com/oauth/token")!
        var request:NSMutableURLRequest = NSMutableURLRequest(URL:url)
        var bodyData = "grant_type=password&username=&password="
        
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
                    let results = NSString(data: data, encoding:NSUTF8StringEncoding)
                    println("API Response: \(results)")
                }
            }
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}