//
//  ViewController.swift
//  MyWebBrowser
//
//  Created by Randy on 2021/02/11.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var btnBack: UIBarButtonItem!
    @IBOutlet weak var btnRefresh: UIBarButtonItem!
    @IBOutlet weak var btnForward: UIBarButtonItem!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBAction func pressedBack(_ sender: UIBarButtonItem) {
        self.webView.goBack()
    }
    
    @IBAction func pressedRefresh(_ sender: UIBarButtonItem) {
        self.webView.reload()
    }
    
    @IBAction func pressedForward(_ sender: UIBarButtonItem) {
        self.webView.goForward()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.webView.navigationDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let firstURL: URL?
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let url = appDelegate.lastURL{
            firstURL = url
        }else{
            firstURL = URL(string: "https://www.apple.com")
        }
        
        guard let url = firstURL else {
            //invalid URL
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        self.webView.load(urlRequest)
        
        
    }
    
    func setNetworkIndicatorVisible(_ isFinishedNavigator : Bool){
        self.loadingIndicator.isHidden = isFinishedNavigator
        isFinishedNavigator ? self.loadingIndicator.stopAnimating() : self.loadingIndicator.startAnimating()
        // isNetworkActivityIndicatorVisible is Deprecated in iOS 13
        if #available(iOS 13.0, *){}else{
            UIApplication.shared.isNetworkActivityIndicatorVisible = isFinishedNavigator
        }
    }
}



extension ViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.setNetworkIndicatorVisible(true)
        
        webView.evaluateJavaScript("document.title"){(value: Any?, error: Error?) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            guard let title = value as? String else{
                return
            }
                
            self.navigationItem.title = title
        }
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.lastURL = webView.url
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.setNetworkIndicatorVisible(false)
    }
}

