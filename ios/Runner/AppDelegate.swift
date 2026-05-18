import Flutter
import UIKit
import FamilyControls

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let bridgeChannel = FlutterMethodChannel(name: "com.saifeai.guardian/platform_bridge",
                                              binaryMessenger: controller.binaryMessenger)
    
    bridgeChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      switch call.method {
      case "checkPermissionStatuses":
        if #available(iOS 15.0, *) {
            // Check Family Controls status
            let familyControlsGranted = FamilyControls.AuthorizationCenter.shared.authorizationStatus == .approved
            result([
                "vpn": false, // iOS DNS settings don't require traditional VPN permission prompt via Flutter in the same way, but let's say false for parity.
                "accessibility": false,
                "familyControls": familyControlsGranted
            ])
        } else {
            result(["vpn": false, "accessibility": false, "familyControls": false])
        }
      case "requestNativePermissions":
        if let args = call.arguments as? [String: Any], let type = args["type"] as? String {
            if type == "familyControls" {
                AppShieldController.shared.requestAuthorization { success in
                    result(success)
                }
            } else {
                result(false)
            }
        } else {
            result(false)
        }
      case "startDigitalSafeguard":
        DNSBlockingService.shared.enableDNS()
        AppShieldController.shared.enableShield()
        result(true)
      case "stopDigitalSafeguard":
        DNSBlockingService.shared.disableDNS()
        AppShieldController.shared.disableShield()
        result(true)
      default:
        result(FlutterMethodNotImplemented)
      }
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
