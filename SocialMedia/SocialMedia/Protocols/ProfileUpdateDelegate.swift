//
//  ProfileUpdateDelegate.swift
//  SocialMedia
//
//  Created by Alikhan Kassiman on 28.02.2025.
//

import UIKit

protocol ProfileUpdateDelegate: AnyObject {
    func profileDidUpdate(_ profile: UserProfile)
    func profileLoadingError(_ error: Error)
}
