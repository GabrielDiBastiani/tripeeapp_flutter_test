import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyDtyAVRl-ECKm4ACegOMGaGae3Ciwtclxk")
    GMSPlacesClient.provideAPIKey("AIzaSyDtyAVRl-ECKm4ACegOMGaGae3Ciwtclxk")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

AIzaSyDQKXcux01DmITDGdpyL8ZdGIcjPbX045M
