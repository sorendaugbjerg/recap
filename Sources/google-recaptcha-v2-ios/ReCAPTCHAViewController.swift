//
//  ReCAPTCHAViewController.swift
//
//  Created by Monstarlab on 01/08/2022.
//

import UIKit
import WebKit

public protocol ReCAPTCHADelegate {
    func handle(token: String)
}

public class ReCAPTCHAViewController: UIViewController {
    private var webView: WKWebView!
    private let siteKey: String
    private var html: String {
        htmlString.replacingOccurrences(of: "${siteKey}", with: siteKey)
    }
    private let domainURL: URL
    private let delegate: ReCAPTCHADelegate
    
    /// Creartes a ReCAPTCHAViewController
    /// Instantiates a ViewController to handle a ReCAPTCHA challenge, and sets it's delegate.
    ///
    ///  - parameter siteKey: key for communication with the Google ReCAPTCHA service
    ///  - parameter domainURL: the domain registred with the Google ReCAPTCHA service
    ///  - parameter delegate: class handling the result of the ReCAPTCHA challenge
    public init(
        siteKey: String,
        domainURL: URL,
        delegate: ReCAPTCHADelegate
    ) {
        self.siteKey = siteKey
        self.domainURL = domainURL
        self.delegate = delegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        let userContentController = WKUserContentController()
        
        userContentController.add(self, name: "recaptcha")
        webConfiguration.userContentController = userContentController
        
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        view = webView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.loadHTMLString(html, baseURL: domainURL)
    }
}

// MARK: - WKScriptMessageHandler
extension ReCAPTCHAViewController: WKScriptMessageHandler {
    public func userContentController(
        _ userContentController: WKUserContentController,
        didReceive message: WKScriptMessage
    ) {
        guard let token = message.body as? String else {
            assertionFailure("Expected a String")
            return
        }
        
        delegate.handle(token: token)
    }
}


// MARK: - HTML String
public let htmlString = #"""
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <script src="https://www.google.com/recaptcha/api.js?onload=onLoad&render=explicit" async defer></script>
    <title></title>
    <script type="text/javascript">
      const post = function(message) {
          window.webkit.messageHandlers.recaptcha.postMessage(message);
      };

      var onLoad = function() {
          grecaptcha.render(
            "recaptcha",
            {
              sitekey: "${siteKey}",
              callback: function(message) {
                  post(message);
              },
              size: "normal"
            }
          );
      };
    </script>
  </head>
  <body>
      <div id="recaptcha"></div>
  </body>
</html>
"""#
