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
            AlibcTradeSDK.sharedInstance()?.setIsvVersion(version)//设置三方App版本,可用于标识App版本
        }
        if appName != ""{
            AlibcTradeSDK.sharedInstance()?.setIsvAppName(appName)//设置三方App名称,可用于标识App
        }
        //        开发阶段打开日志开关
        AlibcTradeSDK.sharedInstance()?.setDebugLogOpen(true)
        //        线上环境
        AlibcTradeSDK.sharedInstance()?.setEnv(AlibcEnvironment.release)
        
        //        初始化
        AlibcTradeSDK.sharedInstance()?.asyncInit(success: {
            let dic = [FlutterAlibcConstKey.ErrorCode :"0",FlutterAlibcConstKey.ErrorMessage:"success"] as! Dictionary<String,String>
//            result(dic)
        }, failure: { (error) in
//             result(@{FlutterAlibcConstKey_ErrorCode:[NSString stringWithFormat: @"%ld", (long)error.code],FlutterAlibcConstKey_ErrorMessage:error.description});
        })
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
