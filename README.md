# TwAuth

This repo contains an example of how to implement the Twilio Verify framework in an iOS app. The idea is to use the iOS app for two-factor verification. I mean, users authenticate on the website then they need to open the app and approve or deny the login request (comes from the website). If they approve, the website shows the profile. Otherwise, the website shows a message that indicates the login request was not approved.

### Acknowledge

Thanks a lot to Yeimi Andrea Fuquen Moreno and Maria Paula Vega for all the support during the development of the test.

### Initial Build Setup

- Clone the project.
- Xcode 12 installed. 
- Carthage  v0.36.0 installed.
- Swift Lint v0.39.1 installed.
- Open the terminal, go to inside TwAuth folder where Carfile is located and run `carthage bootstrap --platform iOS --use-xcframeworks`.
- Open `TwAuth.xcodeproj`.
- In Xcode,  select a device with IOS 14.
- Build & Run.

### Architecture

* MVVM + Coordinator pattern
* Factory Pattern
* Facade Pattern
* Delegate Pattern

### Highlights

* MRCommons framework helps us with the bindable using the property observer. This framework is done with SPM and XCFramework. That allows us to avoid fat framework and finally put .zip XCFramework to offer to whatever person wants to download the framework.

* The app avoids the pyramid of doom in the authentication process using the Operation and OperationQueue. With that, we can cancel an operation and add depends operation.

* Keychain is used to save sensible data like the information required to load the challenges.

* Added Unit tests to ViewModel whenever if possible.

  

  

  ![TwoFactorTest](./TwoFactorTest.gif)

