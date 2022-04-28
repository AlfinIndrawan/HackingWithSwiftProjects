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
    var progressView : UIProgressView!
    var websites = ["apple.com", "hackingwithswift.com"]
    override func loadView() {
        webView = WKWebView() //web renderer
        webView.navigationDelegate = self //when any web page navigation happens, please tell me – the current view controller.
        //   When you set any delegate, you need to conform to the protocol that matches the delegate. Yes, all the navigationDelegate protocol methods are optional, but Swift doesn't know that ye
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView) //customview will make smaller
        
        toolbarItems = [progressButton,spacer,refresh]
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress),options: .new, context: nil)
        
        let url = URL(string: "https://" + websites[0])! // must have https
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }

    @objc func openTapped() {
        let ac = UIAlertController(title: "Open Page...", message: nil, preferredStyle: .actionSheet)
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
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
    } // called when webview finish
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        } //kvo implementation
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) /* escaping for the clousre might be used later on */ {
        let url = navigationAction.request.url
        if let host = url?.host {
            for website in websites {
                if host.contains(website) {
                    decisionHandler(.allow) //if website found closure allow loading
                    return
                }
            }
        }
        decisionHandler(.cancel) // if url dont have host
    }
}

