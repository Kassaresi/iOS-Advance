//
//  ImageLoaderDelegate.swift
//  SocialMedia
//
//  Created by Alikhan Kassiman on 28.02.2025.
//

import UIKit
import Foundation

protocol ImageLoaderDelegate: AnyObject {
    func imageLoader(_ loader: ImageLoader, didLoad image: UIImage)
    func imageLoader(_ loader: ImageLoader, didFailWith error: Error)
}
