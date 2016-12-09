//
//  WebViewController.swift
//  DeBias
//
//  Created by Elizabeth Brouckman on 12/1/16.
//  Copyright © 2016 debias. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {

    var url: String?
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        
        let transform = CGAffineTransformMakeScale(CGFloat(2.0), CGFloat(2.0))
        activity.transform = transform
        
        
        if let urlToLoad = url {
            if let nsurl = NSURL (string: "http://www." + urlToLoad)
            {
                let requestObj = NSURLRequest(URL: nsurl)
                webView.loadRequest(requestObj)
            }
        }

        // Do any additional setup after loading the view.
    }

    func webViewDidStartLoad(webView: UIWebView)
    {
        activity.startAnimating()
    }
    // here show your indicator
    func webViewDidFinishLoad(webView: UIWebView) // here hide it
    {
        activity.stopAnimating()
        
    }
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) // here hide it
    {
        activity.stopAnimating()
        label?.text = "Could not load page"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
