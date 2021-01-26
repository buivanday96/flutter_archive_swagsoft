import UIKit
import Flutter
import SSZipArchive

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let zipChannel = FlutterMethodChannel(name: "my_zip_decoder", binaryMessenger: controller.binaryMessenger)
    
    zipChannel.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
          // Note: this method is invoked on the UI thread.
          // Handle battery messages.
        guard call.method == "unzip" else{
            result(FlutterMethodNotImplemented)
            return
        }
        self.myUnZip(call: call, result: result)
        })
         return super.application(application, didFinishLaunchingWithOptions: launchOptions)
}

public func myUnZip(call : FlutterMethodCall, result : @escaping FlutterResult){
    DispatchQueue.global(qos: .userInitiated).async {
        
        guard let args = call.arguments as? [String: Any] else {
            result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil))
            return
        }
        
        guard let zipFile = args["zipPath"] as? String else {
            result(FlutterError(code: "INVALID_ARGUMENTS", message: "Argument 'zipPath' is missing",details: nil))
            return
        }
        
        
        guard let destinationDir = args["extractPath"] as? String else {
            result(FlutterError(code: "INVALID_ARGUMENTS", message: "Argument 'extractPath' is missing", details: nil))
            return
        }
        
        print("starting...")
        let success = SSZipArchive.unzipFile(atPath: zipFile, toDestination: destinationDir)
    
        if(success){
            print("success")
        }else{
            print("fail")
        }
        print("Ended");
        result(success)
    }
}

}
