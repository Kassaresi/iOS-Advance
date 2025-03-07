# iOS-Advance
Course of iOS Advance

# MyProfile App

## Overview
MyProfile is a personal profile iOS application built with SwiftUI. It showcases personal information, hobbies, and future goals in a tabbed interface, allowing users to navigate between different sections of the profile.

## Features
- **Profile Tab**: Displays personal information including name, age, and educational background
- **Hobby Tab**: Shows a list of hobbies with images and descriptions
- **Dream Tab**: Presents life goals and future plans

## Project Structure
The app consists of the following Swift files:

- **MyProfileApp.swift**: The main entry point of the application
- **ContentView.swift**: Sets up the tab-based navigation interface
- **PersonView.swift**: Displays personal information and a profile picture
- **HobbyView.swift**: Shows a list of hobbies with images and descriptions
- **DreamView.swift**: Presents future goals and plans

## Screenshots
*[Screenshots would be added here]*

## Requirements
- iOS 15.0+
- Xcode 14.0+
- Swift 5.5+

## Installation
1. Clone the repository
2. Open `MyProfile.xcodeproj` in Xcode
3. Build and run the application on your device or simulator

## Customization
To customize the app with your own information:
- Replace the profile information in `PersonView.swift`
- Update the hobbies list in `HobbyView.swift`
- Modify the dreams and goals in `DreamView.swift`
- Add your own images to the Assets catalog (required images: "Portret", "Vostok", "Sleep", "Goal")

# SocialMedia - iOS Feed Application

A modern iOS social media application with a posts feed system, user profiles, hashtag filtering, and post creation capabilities.

## Overview

SocialMedia is a lightweight iOS application demonstrating key social media features:

- Feed system with post display
- User profiles with followers count
- Hashtag-based filtering
- Post creation with user selection
- Image caching and loading
- Modern iOS UI with animations

## Architecture

The application follows a Model-View-Controller (MVC) architecture with some ViewModel patterns:

### Core Components

- **FeedSystem**: Main coordinator managing posts, users, and hashtag filtering
- **ProfileManager**: Handles user profile loading and caching
- **ImageLoader**: Asynchronously loads and caches images from URLs

### Models

- **Post**: Represents a social media post with content, likes, and hashtags
- **UserProfile**: Contains user information including username, bio, and follower count

### Views & Controllers

- **FeedViewController**: Main feed display with hashtag filtering
- **PostCell**: Custom cell for rendering posts in the feed
- **HashtagFilterView**: Horizontal collection view for hashtag selection
- **UserProfileViewController**: Profile details display
- **PostMakeViewController**: Interface for creating new posts

## Features

### Feed System

The `FeedSystem` class serves as the central coordinator, handling:
- Post management (adding, removing, filtering)
- User profile caching
- Hashtag collection and filtering

```swift
func filterPosts(byHashtag hashtag: String?) {
    currentHashtagFilter = hashtag
    updateFilteredPosts()
}
```

### Hashtag Filtering

Users can filter posts by clicking on hashtag chips:

- Horizontal scrollable collection of hashtags
- Visual indication of selected hashtag
- Smooth transition animations when changing filters

### Post Creation

The post creation flow allows users to:
- Select a user identity from available profiles
- Write post content
- Add hashtags
- Submit the post to the feed

### Profile Viewing

User profiles include:
- Profile image
- Username
- Bio information
- Followers count
- Clean, modern UI styling

### Image Loading & Caching

The `ImageLoader` class efficiently manages image loading:
- URL-based image fetching
- Memory-based caching system
- Delegate pattern for loading events

```swift
func loadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
    if let cachedImage = cache.object(forKey: url as NSURL) {
        completion(cachedImage)
        return
    }
    
    URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
        // Image loading and caching logic
    }.resume()
}
```

## UI Implementation Details

### Modern Interface

- Custom cell animations for smooth scrolling experience
- Shadow effects for depth
- Rounded corners and subtle borders
- Color scheme based on blue tones

### Interactive Elements

- Pull-to-refresh for feed updates
- Long-press gesture for post deletion
- Haptic feedback on interactions
- Smooth transitions between views

## Setup and Mock Data

The application initializes with mock data for demonstration:
- Random user profiles
- Posts with randomized content and hashtags
- Simulated follower counts

## How to Run

1. Open the project in Xcode
2. Select an iOS simulator or device
3. Build and run the application

## File Structure

- **Models**: `Post.swift`, `UserProfile.swift`
- **Core Systems**: `FeedSystem.swift`, `ProfileManager.swift`, `ImageLoader.swift`
- **View Controllers**: `FeedViewController.swift`, `UserProfileViewController.swift`, `PostMakeViewController.swift`
- **UI Components**: `PostCell.swift`, `HashtagCell.swift`, `HashtagFilterView.swift`
- **Delegates**: `ImageLoaderDelegate.swift`, `ProfileUpdateDelegate.swift`
- **App Setup**: `AppDelegate.swift`, `SceneDelegate.swift`

## Design Patterns Used

- **Delegate Pattern**: For callback communications between components
- **Completion Handlers**: For asynchronous operations
- **Memory Caching**: For efficient image loading
- **Dependency Injection**: Through initializers
- **Observer Pattern**: Using closures for updates

## Future Enhancements

Potential areas for expansion:
- Data persistence with Core Data
- User authentication system
- Comments and sharing functionality
- Improved media support (video, multiple images)
- Real-time notifications
  
## License
*[Add license information here]*

## Author
Created by Alikhan Kassiman
