//
//  ReCAPTCHAViewModel.swift
//
//  Created by Monstarlab on 01/08/2022.
//

import Foundation

public class ReCAPTCHAViewModel: NSObject {
    private let siteKey: String
    private let completion: (String) -> Void
    
    /// Creates a ReCAPTCHARViewModel
    ///  - Parameters:
    ///    - siteKey: key for communication with the Google ReCAPTCHA service
    ///    - completion: returns a ReCAPTCHA token to be send to and verified by the apps backend API
    public init(siteKey: String, completion: @escaping (String) -> Void) {
        self.siteKey = siteKey
        self.completion = completion
    }
    
    public var html: String {
        htmlString.replacingOccurrences(of: "${siteKey}", with: siteKey)
    }
    
    public func handle(message: String) {
        completion(message)
    }
}
