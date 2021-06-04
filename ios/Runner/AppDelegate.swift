import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // TODO: Add your API key
        GMSServices.provideAPIKey("AIzaSyDp_zzXNo0dUNuOvbY5yAlCHZq9_h02Ul4")


    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
