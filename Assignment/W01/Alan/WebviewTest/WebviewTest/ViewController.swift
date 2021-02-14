//
//  ViewController.swift
//  WebviewTest
//
//  Created by Alan on 2021/02/14.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    func goWeb(address: String) -> () {
        let url = URL(string: address)
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.allowsBackForwardNavigationGestures = true
        indicator.hidesWhenStopped = true

        if let defaultURL = UserDefaults.standard.value(forKey: "url") {
            goWeb(address: defaultURL as! String)
        } else {
            goWeb(address: "https://www.google.co.kr")
        }
    }

    @IBAction func goBack(_ sender: UIBarButtonItem) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func goForward(_ sender: UIBarButtonItem) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @IBAction func Refresh(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        indicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicator.stopAnimating()
        
        UserDefaults.standard.set(webView.url?.absoluteString, forKey: "url")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!) {
        
    }
}

