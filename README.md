# ios-bullion

## Minimum Deployments
iOS 17.0

## Build With
- UIKit Programatically
- Clean architecture with MVVM
- Combine Framework
- Keychain
- UserDefaults
- CryptoKit
- UICollectionViewCompositionalLayout 
- CAGradientLayer

## Features
- Pagination (Scroll to bottom)
- Alert message
- Loading Indicator
- Custom Dialog

## Project Structure
    .
    └── ios-bullion
        ├── App                   # App and Scene Delegate files
        ├── Core                  # Core functionalities of the app
        │   ├── Data              # Contains data-related implementations such as repositories and remote data sources
        │   │   ├── Remote
        │   │   └── Response
        │   ├── DI                # Dependency injection setup for the application
        │   ├── Domain            # Contains domain models and use cases
        │   │   ├── Model
        │   │   └── Use Case
        │   └── Utils             # Utility files such as networking helpers, extensions, view components, and mappers
        ├── Module                
        │   └── Feature           # Contains views and viewmodels for the edit feature
        │       ├── ViewModels    
        │       └── Views         
        └── Supporting Files      # Contains files such as assets, .plist, font, etc

## Demo
https://github.com/user-attachments/assets/1ca4f9f3-56df-4477-b62d-148cd191107d

