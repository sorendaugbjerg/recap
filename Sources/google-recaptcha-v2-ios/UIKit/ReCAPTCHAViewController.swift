//
//  ReCAPTCHAViewController.swift
//
//  Created by Monstarlab on 01/08/2022.
//

import UIKit
import WebKit

public class ReCAPTCHAViewController: UIViewController {
    private var webView: WKWebView!
    private var viewModel: ReCAPTCHAViewModel
    
    /// Creates a ReCAPTCHAWebView
    ///  - Parameters:
    ///    - viewModel: ReCAPTCHAViewModel
    public init(viewModel: ReCAPTCHAViewModel) {
        self.viewModel = viewModel
        
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
        
        webView.loadHTMLString(viewModel.html, baseURL: viewModel.domainURL)
    }
}

// MARK: - WKScriptMessageHandler
extension ReCAPTCHAViewController: WKScriptMessageHandler {
    public func userContentController(
        _ userContentController: WKUserContentController,
        didReceive message: WKScriptMessage
    ) {
        guard let message = message.body as? String else {
            assertionFailure("Expected a String")
            return
        }
        
        viewModel.handle(message: message)
    }
}
