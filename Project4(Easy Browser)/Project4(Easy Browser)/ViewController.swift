//
//  ViewController.swift
//  Project4(Easy Browser)
//
//  Created by Alfin on 26/4/22.
//
import WebKit
import UIKit

class ViewController: UIViewController, WKNavigationDelegate /*protocol*/ {
    var webView : WKWebView!
    
    override func loadView() {
        webView = WKWebView() //web renderer
        webView.navigationDelegate = self //when any web page navigation happens, please tell me – the current view controller.
        //   When you set any delegate, you need to conform to the protocol that matches the delegate. Yes, all the navigationDelegate protocol methods are optional, but Swift doesn't know that ye
        view = webView
    }
    
    override func viewDidLoad() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        super.viewDidLoad()
        let url = URL(string: "https://www.hackingwithswift.com")! // must have https
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    @objc func openTapped() {
        let ac = UIAlertController(title: "Open Page...", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "hackingwithswift.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
         present(ac, animated: true)
    }
    func openPage(action: UIAlertAction) {
        guard let actionTitle = action.title else {return}
        guard let url = URL(string: "https://" + actionTitle) else {return}
        webView.load(URLRequest(url: url))
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    } // called when webciew finish


}

