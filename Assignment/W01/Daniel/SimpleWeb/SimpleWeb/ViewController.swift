//
//  ViewController.swift
//  SimpleWeb
//
//  Created by 김성환 on 2021/02/14.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var titleView: UINavigationItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var backwardBtn: UIBarButtonItem!
    @IBOutlet weak var forwardBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        var urlStr = "https://www.google.com/"
        if let savedURL = UserDefaults.standard.string(forKey:"lastURL") {
            urlStr = savedURL
        }
        let myURL = URL(string: urlStr)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }

    @IBAction func backwardClick(_ sender: Any) {
        webView.goBack()
    }
    
    @IBAction func forwardClick(_ sender: Any) {
        webView.goForward()
    }
    
    @IBAction func reloadClick(_ sender: Any) {
        webView.reload()
    }
    
    // Delegates
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        titleView.title = webView.title
        backwardBtn.isEnabled = webView.canGoBack
        forwardBtn.isEnabled = webView.canGoForward
        
        if let currentURL = webView.url {
            UserDefaults.standard.set(currentURL.absoluteString, forKey: "lastURL")
        }
    }
}

