//
//  YLYNetBox.m
//  Eyuemeiche
//
//  Created by yu on 15/03/2018.
//  Copyright © 2018 yu. All rights reserved.
//

/*
 ------- code 代码 --------
 
 OK = 0 # 成功返回
 SYSTEM_BUSY = 10000
 PARAMETERS_ERROR = 10001
 REQUIRE_POST_METHOD = 10002
 VALIDATE_CODE_ERROR = 10003
 MOBILE_FORMAT_ERROR = 10004
 OPERATION_FAILED = 10005
 FREQUENT_OPERATION = 10006
 
 USER_NOT_EXIST = 10100
 USER_NOT_LOGIN = 10101
 
 CAR_NOT_EXIST = 10200
 CAR_LICENSE_EXIST = 10201
 CAR_LICENSE_ILLIGAL = 10202
 
 WALLET_NOT_ENOUGH = 10300
 CUPON_ILLEGAL = 10301
 NOT_TOPUP_RECORD = 10302
 REFUND_FAILED = 10303
 ORDER_NOT_EXIST = 10304
 COMMENT_NOT_EXIST = 10305
 
 UNKOWN_CHANNEL = 10900
 FILE_NOT_SPECIFY = 10901
 FILE_OPERATION_ERROR = 10902
 
 ErrorInfo = {
 OK: 'OK',
 SYSTEM_BUSY:'系统繁忙',
 REQUIRE_POST_METHOD:"请求格式错误",
 PARAMETERS_ERROR:"参数错误",
 VALIDATE_CODE_ERROR:"验证码错误",
 MOBILE_FORMAT_ERROR: '手机号格式不对',
 OPERATION_FAILED:'操作失败，请重新操作',
 FREQUENT_OPERATION:"操作太频繁",
 
 USER_NOT_LOGIN:"请重新登录",
 USER_NOT_EXIST:"非法用户",
 
 CAR_NOT_EXIST:"车辆不存在",
 CAR_LICENSE_EXIST:"车牌号码已注册",
 CAR_LICENSE_ILLIGAL:"车牌号码非法",
 
 WALLET_NOT_ENOUGH:"钱包余额不足，请充值",
 CUPON_ILLEGAL:"优惠券已使用或已过期",
 NOT_TOPUP_RECORD:"用户无充值记录",
 REFUND_FAILED:"退款失败",
 ORDER_NOT_EXIST:"订单不存在",
 COMMENT_NOT_EXIST:"评论不存在",
 
 UNKOWN_CHANNEL:"不支持此平台",
 FILE_NOT_SPECIFY:"未指定文件",
 FILE_OPERATION_ERROR:"文件操作失败"
 }
 */

#import "YLYNetBox.h"
#import "URLConfig.h"
#import <AFNetworking.h>
#import <AFNetworkReachabilityManager.h>
#import "NSString+ExtendMethod.h"
#import "YLYDefine.h"

@interface YLYNetBox ()

@property (nonatomic, readwrite, copy)NSString *requestName;//请求名称
@property (nonatomic, readwrite, copy)NSString *requestTag;//请求 number 标记
@property (nonatomic, readwrite, strong)NSURLSessionDataTask *task;//发起请求的任务

@end

@implementation YLYNetBox

- (void)sendRequestWithAddress:(NSString *)address parameterDict:(NSDictionary *)paramDict tag:(NSString *)urlTag name:(NSString *)urlName {
    //补全地址
    NSString *URLString = [NSString stringWithFormat:@"%@%@", BaseURLString, address];

    //检查自定义名称
    self.requestName = @"未命名的name";
    if ([NSString checkNullString:urlName].length != 0) {
        _requestName = [urlName copy];
    } else {
        ;
    }
    
    //tag
    self.requestTag = @"未命名的tag";
    if ([NSString checkNullString:urlTag].length != 0) {
        _requestTag = [urlTag copy];
    } else {
        ;
    }
    
    //参数
    NSMutableDictionary *postDict = [NSMutableDictionary dictionaryWithDictionary:paramDict];
    
    self.task = [_manager POST:URLString
                    parameters:postDict
                      progress:^(NSProgress * _Nonnull uploadProgress) {
                          ;
                      }
                       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                           NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];//error暂不处理
                           NSString *code = dict[@"err_code"];
                           
                           if (code.integerValue == 0) {
                               YLYLog(@"%@: 请求成功!", urlName);
                               [self success:dict];
                           } else {
                               YLYLog(@"%@: 不成功!", urlName);
                               [self other:dict];
                           }
                           YLYLog(@"dict = %@", dict);
                           self.requestDown(self.viewController, self);
                       }
                       failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                           YLYLog(@"%@", error);
                           if (error.code == NSURLErrorTimedOut) {
                               YLYLog(@"%@: 请求超时!", urlName);
                               [self overTime];
                           } else if (error.code == NSURLErrorCancelled) {
                               YLYLog(@"%@: 取消了请求", urlName);
                               [self failed];
                           } else {
                               //请求数据失败，各种错误
                               [self failed];
                           }
                           self.requestDown(self.viewController, self);
                       }
                 ];
}


#pragma -mark 对外接口
//取消请求
- (void)cancelRequest {
    YLYLog(@"取消请求了");
    [self.task cancel];
}


#pragma -mark 处理请求回调
//请求成功
- (void)success:(NSDictionary *)retDict {
    if (self.requestSuccessBlock && self.requestDown) {
        self.requestSuccessBlock(retDict);
    }
}
//其他code
- (void)other:(NSDictionary *)retDict {
//    NSString *code = retDict[@"err_code"];
    YLYLog(@"%@", retDict[@"ret_msg"]);
    [[YLYHelper shareHelper] showHudViewWithString:retDict[@"ret_msg"]];
    if (self.requestOtherBlock && self.requestDown) {
        self.requestOtherBlock(retDict);
    }
}
//超时
- (void)overTime {
    YLYLog(@"超时");
    [[YLYHelper shareHelper] showHudViewWithString:@"请求超时!"];
    if (self.requestDown) {
    }
}
//失败
- (void)failed {
    [[YLYHelper shareHelper] showHudViewWithString:@"请求失败!"];
    if (self.requestFailedBlock && self.requestDown) {
        self.requestFailedBlock();
    }
}

@end
