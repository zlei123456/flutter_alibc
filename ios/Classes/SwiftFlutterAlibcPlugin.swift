import Flutter
import UIKit

public class SwiftFlutterAlibcPlugin: NSObject, FlutterPlugin {
    
    var alibchandler : FlutterAlibcHandle? = nil;
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_alibc", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterAlibcPlugin()
        instance.alibchandler = FlutterAlibcHandle()
        
        registrar.addMethodCallDelegate(instance, channel: channel)
        registrar.addApplicationDelegate(instance)
        let controller : FlutterViewController = UIApplication.shared.windows.last?.rootViewController as! FlutterViewController
        let eventChannel : FlutterEventChannel = FlutterEventChannel(name: "flutter_alibc_event", binaryMessenger: controller.binaryMessenger)
        //        eventChannel.setStreamHandler(<#T##handler: (FlutterStreamHandler & NSObjectProtocol)?##(FlutterStreamHandler & NSObjectProtocol)?#>)
        
    }
    
 
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "getPlatformVersion"{
            result("iOS " + UIDevice.current.systemVersion)
        } else if call.method == "initAlibc"{
            alibchandler?.initAlibc(call: call, result: result)
        }
    }
    
    //    application
    
    
    
    //    - (instancetype)initWithRegistrar:(NSObject <FlutterPluginRegistrar> *)registrar methodChannel:(FlutterMethodChannel *)flutterMethodChannel{
    //        self = [super init];
    //
    //        if (self) {
    //            self.handler = [[FlutterAlibcHandle alloc]init];
    //        }
    //
    //        return self;
    //    }
}
