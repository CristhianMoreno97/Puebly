# puebly

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Environment Variables Configuration

The project uses the flutter_dotenv package for the configuration of environment variables. To set up the environment variables, follow these steps:

**1.** Create a .env file at the project root

**2.** Add the following environment variables

```
URL_BASE="https://puebly.com"
PUEBLY_WHATSAPP_NUMBER="+573990009999"
```

Where **URL_BASE** is the base URL of the API, and **PUEBLY_WHATSAPP_NUMBER** is the project's WhatsApp number.

## Firebase Configuration
This application leverages Google Analytics to garner insights from user interactions. In order to integrate this functionality, the app needs to be configured to utilize Firebase. Begin by adhering to [this comprehensive guide](https://firebase.google.com/docs/flutter/setup?platform=android) which will walk you through installing the Firebase CLI and initiating a new project within Firebase. After signing into your Google account using the `firebase login` command, proceed by executing the commands listed below:

```bash
dart pub global activate flutterfire_cli
```

```bash
flutterfire configure --project=your-project-id
```

### Utilizing Firebase DebugView

To effectively debug and monitor events sent to Google Analytics in real-time, Firebase offers a tool known as DebugView. This powerful feature aids in the troubleshooting and fine-tuning of your analytics implementation. Below are the essential commands to activate DebugView for your application:

1. **Enable Debug Mode on Your Device**: Start by enabling Debug mode on your development device to start streaming analytics events in real-time. Execute the following command, replacing `com.yourapp.package` with your application's unique package name:

    ```bash
    adb shell setprop debug.firebase.analytics.app com.yourapp.package
    ```
    This command sets your application into Debug mode, ensuring that every event is sent to Firebase Analytics immediately, allowing you to view those events in Firebase DebugView in real-time.

2. **Run Your Application**: Launch your Flutter application as you normally would:

    ```bash
    flutter run
    ```

3. **Disable Debug Mode**: Once you've completed your debugging session, it's a prudent practice to disable Debug mode to prevent an overflow of debug data in your analytics reports. Disable Debug mode by executing the following command:

    ```bash
    adb shell setprop debug.firebase.analytics.app .none.
    ```

By following these steps and utilizing the commands as outlined, you can seamlessly enable, use, and disable Firebase DebugView, thereby enhancing your ability to debug and optimize your application's analytics implementations with precision and efficiency.

# Build and release Android app

Below, we outline some essential configurations that must be completed before building and launching the Android application. For a more comprehensive understanding, please refer to the configurations detailed in [Flutter's official documentation](https://docs.flutter.dev/deployment/android#adding-a-launcher-icon).

## Change package name

To define a custom package name, execute the following command, replacing `com.yourapp.package` with your application's unique package name:

```
flutter pub run change_app_package_name:main com.yourapp.package
```

## Customize the application icon

follow the configuration guide of the [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) package, and finally, execute the following command:

```
flutter pub run flutter_launcher_icons
```

## Building the app for release
### Build an app bundle
To build an app bundle, run the following command:
```
flutter build appbundle
```


