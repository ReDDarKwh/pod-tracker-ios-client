//
//  podcastWebViewController.swift
//  pod-tracker-ios-client
//
//  Created by will on 2019-03-04.
//  Copyright © 2019 will. All rights reserved.
//

import UIKit
import WebKit

class podcastWebViewController: UIViewController, WKUIDelegate {

    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:"https://pod-tracker-client.herokuapp.com/browse")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}
