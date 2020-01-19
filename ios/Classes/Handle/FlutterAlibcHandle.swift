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
    
    //    MARK: - 对flutter暴露的方法
    //    MARK:  初始化阿里百川
    public func initAlibc(call : FlutterMethodCall , result : @escaping FlutterResult){
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
            let dic = [FlutterAlibcConstKey.ErrorCode :"0",FlutterAlibcConstKey.ErrorMessage:"success"]
            result(dic);
        }, failure: { (error) in
            let dic = [FlutterAlibcConstKey.ErrorCode :String((error! as NSError).code) ,FlutterAlibcConstKey.ErrorMessage:error?.localizedDescription] as! Dictionary<String,String>
            result(dic);
        })
    }
    //    MARK:  淘宝登录
    public func loginTaoBao(call : FlutterMethodCall , result : @escaping FlutterResult){
        //        判断是否登录
        if(!(ALBBSession.sharedInstance()?.isLogin())!){
            ALBBSDK.sharedInstance()?.setAuthOption(NormalAuth)
            //            根视图
            let rootViewController : UIViewController = UIApplication.shared.windows.last!.rootViewController!
            ALBBSDK.sharedInstance()?.auth(rootViewController, successCallback: { (session) in
                let userInfo : ALBBUser = (session?.getUser())!
                result([FlutterAlibcConstKey.ErrorCode : "0",
                        FlutterAlibcConstKey.ErrorMessage:"success",
                        FlutterAlibcConstKey.Data :[
//                            昵称
                            "nick":userInfo.nick,
//                            头像地址
                            "avatarUrl":userInfo.avatarUrl,
                            "openId":userInfo.openId,
                            "openSid":userInfo.openSid,
                            "topAccessToken":userInfo.topAccessToken,
                            "topAuthCode":userInfo.topAuthCode,]
                ])
            }, failureCallback: { (session, error) in
                let dic = [FlutterAlibcConstKey.ErrorCode :String((error! as NSError).code) ,FlutterAlibcConstKey.ErrorMessage:error?.localizedDescription] as! Dictionary<String,String>
                           result(dic);
            })
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
