//
//  ReCAPTCHADelegate.swift
//
//  Created by Monstarlab on 03/08/2022.
//

import Foundation

public protocol ReCAPTCHADelegate {
    func handle(token: String)
}
