# Receiving Voice and Text Communications on a Local Network

Provide voice and text communication on a local network isolated from Apple Push Notification service by adopting Local Push Connectivity.

## Overview

- Note: This sample code project is associated with WWDC 2020 session [10113: Build Local Push Connectivity for Constrained Networks](http://developer.apple.com/wwdc20/10113).

This sample app shows how to implement and use Local Push Connectivity within a messaging app. The sample workspace contains two app components:

- `SimplePush` — An iOS app that uses Local Push Connectivity to provide text messaging and VoIP services.
- `SimplePushServer` — A lightweight Swift server that simulates the functions of a messaging server by routing messages and calls between clients.

The `SimplePush` app maintains two connections to the server:

- Notification Channel — A TCP connection maintained by the [`NEAppPushProvider`](https://developer.apple.com/documentation/networkextension/neapppushprovider) that provides functionality similar to Apple Push Notification service (APNs) when on a local Wi-Fi network.
- Control Channel — A TCP connection maintained by the iOS app and used to send app control data to the server.

To run the sample, you will need a macOS device to operate as the server, and two iOS devices to communicate with each other, all on the same Wi-Fi network.

## Configure the Sample Code Project

Apps that use Local Push Connectivity require the [App Push Provider entitlement](https://developer.apple.com/contact/request/local-push-connectivity) entitlement.

After you receive the entitlement:

1. Open SimplePush.xcworkspace and set the Development Team in the build settings of all five targets across the three projects. Once you've set the team, Xcode automatically creates unique bundle identifiers that you use in the following steps.
2. Sign into your account on the Apple Developer website and register a new App Group and two App IDs: one for the SimplePush app and one for the SimplePushProvider extension. Configure each App ID with the App Groups and Network Extensions capabilities. Once you register the IDs, create two provisioning profiles (one for each identifier) that include the App Push Provider entitlement.
3. Import the newly created provisioning profiles into Xcode.
4. In the SimplePush project, configure the `SimplePush` and `SimplePushProvider` targets with the imported provisioning profiles, uncheck the existing App Group, and select the new App Group identifier created in step 2.
5. Update the `pushProviderBundleIdentifier` in `PushConfigurationManager.swift` with the bundle identifier set on the `SimplePushProvider` target.

## Build and Run the Sample Server

Select the `SimplePushServer` build scheme and your macOS machine as the run destination then run the project to start the server.

## Build, Run, and Configure the Sample App

With the server running, select the `SimplePush` iOS build scheme and run the project on your iOS device. When `SimplePush` starts, update the app’s settings to connect to the server.

1. Tap the Settings button and enter the following information:
2. Enter the Server Address, which is the IP address or hostname of the macOS computer where `SimplePushServer` is running.
3. Enter the SSID of your local Wi-Fi network. The `NEAppPushProvider` will only run when your device is joined to the Wi-Fi network with the SSID you've specified.

After configuring those settings, the “Local Push Connectivity - Active” setting displays “Yes” when `NEAppPushProvider` is running. You should perform the steps above on at least two iOS devices so you can test and observe message exchanges between clients.
