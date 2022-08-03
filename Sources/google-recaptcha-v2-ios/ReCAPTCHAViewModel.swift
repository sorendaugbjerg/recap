//
//  ReCAPTCHAViewModel.swift
//
//  Created by Monstarlab on 01/08/2022.
//

import Foundation

public class ReCAPTCHAViewModel: NSObject {
    private let siteKey: String
    public var html: String {
        htmlString.replacingOccurrences(of: "${siteKey}", with: siteKey)
    }
    public let domainURL: URL
    private let delegate: ReCAPTCHADelegate
    
    /// Creates a ReCAPTCHARViewModel
    ///  - Parameters:
    ///    - siteKey: key for communication with the Google ReCAPTCHA service
    ///    - domainURL: the domain registred with the Google ReCAPTCHA service
    ///    - delegate: class taking the result of the ReCAPTCHA challenge
    public init(
        siteKey: String,
        domainURL: URL,
        delegate: ReCAPTCHADelegate
    ) {
        self.siteKey = siteKey
        self.domainURL = domainURL
        self.delegate = delegate
    }
    
    public func handle(token: String) {
        delegate.handle(token: token)
    }
}
