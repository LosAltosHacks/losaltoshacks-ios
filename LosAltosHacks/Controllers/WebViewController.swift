//
//  WebViewController.swift
//  LosAltosHacks
//
//  Created by Justin Yu on 1/4/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

import UIKit

class WebViewController: BaseViewController {

    @IBOutlet weak var webView: UIWebView!
    var request: NSURLRequest?

    override func viewDidLoad() {
        super.viewDidLoad()

        webView.delegate = self

        if let request = request {
            webView.loadRequest(request)
        }
    }

    override func setupConstraints() {
        webView.snp_makeConstraints { make in
            make.top.equalTo(view.snp_top)
            make.bottom.equalTo(view.snp_bottom)
            make.left.equalTo(view.snp_left)
            make.right.equalTo(view.snp_right)
        }
    }

}

extension WebViewController: UIWebViewDelegate {
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }

    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        print(error)
    }
}