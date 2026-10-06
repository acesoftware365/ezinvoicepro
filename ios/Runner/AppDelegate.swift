import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  private var pendingPluginRegistry: FlutterPluginRegistry?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    pendingPluginRegistry = engineBridge.pluginRegistry
    registerPluginsWhenWindowIsReady()
  }

  func registerPluginsWhenWindowIsReady() {
    guard window?.rootViewController != nil, let registry = pendingPluginRegistry else { return }
    pendingPluginRegistry = nil
    GeneratedPluginRegistrant.register(with: registry)
  }
}

@objc class SceneDelegate: FlutterSceneDelegate {
  override func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    super.scene(scene, willConnectTo: session, options: connectionOptions)
    // Legacy contacts plugin uses the application delegate's window at registration.
    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
      appDelegate.window = window
      appDelegate.registerPluginsWhenWindowIsReady()
    }
  }
}
