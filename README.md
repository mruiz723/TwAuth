# TwAuth

This repo contains an example of how to implement the Twilio Verify framework in an iOS app. The idea is to use the iOS app for two-factor verification. I mean, users authenticate on the website then they need to open the app and approve or deny the login request (comes from the website). If they approve, the website shows the profile. Otherwise, the website shows a message that indicates the login request was not approved.

### Acknowledge

Thanks a lot to Yeimi Andrea Fuquen Moreno and Maria Paula Vega for all the support during the development of the test.

## Running the Sample backend

- Clone the [repository]( https://github.com/yafuquen/twilio-verify-example). Then, install dependencies with

  ```bash
  npm install
  ```

- To run the application, you'll need to gather your Twilio account credentials and configure them in a file named .env. To create this file from an example template, do the following in your Terminal.

  ```bash
  cp .env.sample .env
  ```

  Inside the .env put the following:

  ```bash
  TWILIO_ACCOUNT_SID="AC3d69f8a953025e13298cdc5e5fc5486f"
  TWILIO_AUTH_TOKEN="797f54158e5ad39df571ce5c904955d8"
  TWILIO_VERIFY_SERVICE_SID="VAf64e4ff0a3d89a8c72b6a9cc4c4729ee"
  ```

Start the application

```bash
npm start
```

Your application should now be running at **http://localhost:5000/**.

### Register a Local User

Access **http://localhost:5000/register** on your browser, you can now register a first user.

In the default setting no device is register as a factor, a user can sign up and access the profile page.

### Initial Build Setup for iOS App

- Clone the project.

- Xcode 12 installed. 

- Carthage  v0.36.0 installed.

- Swift Lint v0.39.1 installed.

- ngrok v2.3.35 installed.

- Once our server is running `http://localhost:5000`, we need to open the terminal and run the following command:

  ``` bash
  ngrok http 5000
  ```

- Open another tab on the terminal, go to the inside TwAuth folder where Carfile is located, and run:

   ````bash
  carthage bootstrap --platform iOS --use-xcframeworks
  ````

- Open `TwAuth.xcodeproj`. Go to Constants.swift file and change the baseURL for the outcome that you received when you run `ngrok http 5000` command above.

- In Xcode,  select a device.

- Build & Run.

### Architecture

* MVVM + Coordinator pattern
* Factory Pattern
* Facade Pattern
* Delegate Pattern

### Highlights

* Created [MRCommons framework](https://github.com/mruiz723/MRCommons-iOS) that helps us with the bindable using the property observer. This framework is done with SPM and XCFramework. That allows us to avoid fat framework and finally put .zip XCFramework to offer to whatever person wants to download the framework.

* The app avoids the pyramid of doom in the authentication process using the Operation and OperationQueue. With that, we can cancel an operation and add depends operation.

* Keychain is used to save sensible data like the information required to load the challenges.

* Added Unit tests to ViewModel whenever if possible.

  

  

  ![TwoFactorTest](./TwoFactorTest.gif)

