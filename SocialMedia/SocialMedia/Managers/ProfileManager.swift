//
//  ProfileManager.swift
//  SocialMedia
//
//  Created by Alikhan Kassiman on 28.02.2025.
//

import Foundation
import UIKit

class ProfileManager {
    private var activeProfiles: [UUID: UserProfile] = [:]
    
    weak var delegate: ProfileUpdateDelegate?
    
    var onProfileUpdate: ((UserProfile) -> Void)?
    
    init(delegate: ProfileUpdateDelegate? = nil) {
        self.delegate = delegate
    }
    
    func getActiveProfiles() -> [UUID: UserProfile] {
        return activeProfiles
    }
    
    func loadProfile(id: UUID, completion: @escaping (Result<UserProfile, Error>) -> Void) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            
            let profile = UserProfile(
                id: id,
                username: "guest_\(id.uuidString.prefix(4))",
                imageUrl: URL(string: "https://picsum.photos/\(Int.random(in: 1...100))")!,
                bio: "Info",
                followers: Int.random(in: 100...1000)
            )
            
            DispatchQueue.main.async {
                self.activeProfiles[id] = profile
                completion(.success(profile))
                self.delegate?.profileDidUpdate(profile)
            }
        }
    }
}

