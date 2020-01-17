//
//  FlutterAlibcHandle.swift
//  flutter_alibc
//
//  Created by xing.wu on 2020/1/17.
//

import Foundation

class FlutterAlibcHandle: NSObject {
    //
    //    var _flutterAlibcChannel:FlutterMethodChannel? = nil
    //
    //
    //    init(flutterAlibcChannel : FlutterMethodChannel) {
    //        _flutterAlibcChannel = flutterAlibcChannel
    //    }
    
    //    MARK --对flutter暴露的方法
    //    MARK -- 初始化阿里百川
    public func initAlibc(call : FlutterMethodCall , result : FlutterResult){
        let version : String = getStringFromCall(key: "version", call: call);
        let appName : String = getStringFromCall(key: "appName", call: call);
//        判断是否存在
        if version != ""{
            
        }
        
    }
    
    
    private func getStringFromCall(key:String,call : FlutterMethodCall) -> String{
        guard let result = (call.arguments as? Dictionary<String, Any>)?[key] as? String else {
//            result(FlutterError(code: "参数异常", message: "参数url不能为空", details: nil))
            return ""
        }
        
        return result
    }
    
    private func isNil(){
        
    }
}
