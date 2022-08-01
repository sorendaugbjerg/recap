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
    
    private let completion: (String) -> Void
    
    /// Creates a ReCAPTCHARViewModel
    ///  - Parameters:
    ///    - siteKey: key for communication with the Google ReCAPTCHA service
    ///    - domainURL: the domain registred with the Google ReCAPTCHA service
    ///    - completion: returns a ReCAPTCHA token to be send to and verified by the apps backend API
    public init(siteKey: String, domainURL: URL, completion: @escaping (String) -> Void) {
        self.siteKey = siteKey
        self.domainURL = domainURL
        self.completion = completion
    }
    
    public func handle(message: String) {
        completion(message)
    }
}
