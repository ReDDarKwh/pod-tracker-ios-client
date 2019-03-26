//
//  PodcastInfoViewController.swift
//  pod-tracker-ios-client
//
//  Created by will on 2019-03-04.
//  Copyright © 2019 will. All rights reserved.
//

import UIKit
import WebKit


class PodcastInfoViewController: UIViewController, WKUIDelegate {

    var webView: WKWebView!
    
    var podcast: ItuneSearchResultItem?
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = podcast?.trackName
        
        let url = "https://pod-tracker-client.herokuapp.com/podcast/" +
            
            ((podcast?.feedUrl ?? "").addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")
        
        let myURL = URL(string: url)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }

}
