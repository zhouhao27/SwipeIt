//
//  LoginViewController.swift
//  Reddit
//
//  Created by Ivan Bruel on 25/04/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

// MARK: Properties and Lifecycle
class LoginViewController: WebViewController, CloseableViewController {

  var viewModel: LoginViewModel!

  override func viewDidLoad() {
    super.viewDidLoad()

    setupViews()
  }

}

// MARK: Setup
extension LoginViewController {

  private func setupViews() {
    setupWebView()
    setupCloseButton()
  }

  private func setupWebView() {
    loadURL(viewModel.oauthURLString)
  }

}

// MARK: WKNavigationDelegate
extension LoginViewController {

  func webView(webView: WKWebView,
               decidePolicyForNavigationAction navigationAction: WKNavigationAction,
                                               decisionHandler: WKNavigationActionPolicy -> Void) {
    let URLString = navigationAction.request.URLString
    if viewModel.isRedirectURL(URLString) {
      decisionHandler(WKNavigationActionPolicy.Cancel)
      dismissViewControllerAnimated(true) {
        self.viewModel.loginWithRedirectURL(URLString)
      }
      return
    }
    decisionHandler(WKNavigationActionPolicy.Allow)
  }

}
