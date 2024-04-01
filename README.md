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

# Build and release Android app

Below, we outline some essential configurations that must be completed before building and launching the Android application. For a more comprehensive understanding, please refer to the configurations detailed in [Flutter's official documentation](https://docs.flutter.dev/deployment/android#adding-a-launcher-icon).

## Change package name

To define a custom package name, execute the following command:

```
flutter pub run change_app_package_name:main com.yourcustomdomain.yourappname
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


