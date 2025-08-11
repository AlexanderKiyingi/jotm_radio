import Flutter
import UIKit
import AVFoundation

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    // Configure audio session for background streaming
    do {
      try AVAudioSession.sharedInstance().setCategory(
        .playback,
        mode: .default,
        options: [.allowBluetooth, .allowBluetoothA2DP, .allowAirPlay]
      )
      try AVAudioSession.sharedInstance().setActive(true)
    } catch {
      print("Failed to configure audio session: \(error)")
    }
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  override func applicationWillResignActive(_ application: UIApplication) {
    // Keep audio playing in background
    super.applicationWillResignActive(application)
  }
  
  override func applicationDidEnterBackground(_ application: UIApplication) {
    // Ensure audio continues in background
    super.applicationDidEnterBackground(application)
  }
}
