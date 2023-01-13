# AdFinder - iOS Classified Ads App
AdFinder is a native iOS app for classified ads. Developed with Swift 5.7, the app is designed to run on iOS 14.0 and higher. The app's architecture attempts to adhere to the SOLID principles to ensure maintainability and scalability. No external dependencies are used in the project.

### Project Structure
The project is structured in a modular way, with a main workspace and project named AdFinder, and several local SPM frameworks developed and used by the project:

- **Entities**: Contains all business models, it's responsible for the core data models of the app.
- **DesignSystem**: Contains design system views and assets such as fonts, colors, etc. This framework provides a consistent look and feel throughout the app and also allows for easy updates and maintenance of visual elements.
- **WebProxy**: This framework is responsible for making web requests and handling communication with the backend.

All these frameworks are developed with SPM (Swift Package Manager) which allows for easy dependency management and integration into the main project.

### App Scenes Structure
- The app is divided into scenes, each scene containing specific features.
- Currently, the app has one scene named SearchScene, which contains two features:
    - An ads list
    - An ad details screen
- Each feature is composed of:
    - A **Domain layer** that contains the business rules.
    - An **App layer** that implements the user interfaces and handles communication with external services such as web services.

### Running the App
1. Clone the repository: `git clone https://github.com/rbapro/AdFinder.git`
2. Open the `AdFinder.xcworkspace` file in Xcode.
3. Build and run the AdFinder target

## Technical Stack
- Swift 5.7
- iOS 14.0+
- Xcode
- SPM (Swift Package Manager)
- SOLID principles
- UIKit

## License
The project is licensed under the Apache License 2.0 license. Please refer to the `LICENSE` file for more information.
