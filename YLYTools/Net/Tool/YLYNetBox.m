//
//  YLYNetBox.m
//  Eyuemeiche
//
//  Created by yu on 15/03/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "YLYNetBox.h"
#import <AFNetworking.h>
#import "URLConfig.h"
#import <AFNetworking.h>
#import <AFNetworkReachabilityManager.h>
#import "NSString+ExtendMethod.h"
#import "YLYDefine.h"

@interface YLYNetBox ()

@property (nonatomic, readwrite, strong)AFHTTPSessionManager *manager;
@property (nonatomic, readwrite, copy)NSString *requestName;//请求名称
@property (nonatomic, readwrite, copy)NSString *requestTag;//请求 number 标记

@end

@implementation YLYNetBox

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

- (AFHTTPSessionManager *)singleManager {
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        
        //常规配置
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain", nil];
        // 设置超时时间
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 5.0f;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        [manager.requestSerializer setValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
        [manager.requestSerializer setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
//        //关闭缓存
//        manager = NSURLRequestReloadIgnoringLocalCacheData;
//        [manager setSessionDidBecomeInvalidBlock:^(NSURLSession * _Nonnull session, NSError * _Nonnull error) {
//            NSLog(@"设置session失效");
//        }];
        
        /*
         以下为认证https设置
         */
        [self setupHTTPSAuthority];
        
        /*
         以下为自建https设置
         */
        //    //单向验证
        //    _manager.securityPolicy = [self customSecurityPolicy];
        //    //双向验证 - 服务器验证客户端cer是否由服务器派发
        //    [self setupHTTPSCer];
        //    //双向验证 - 客服端验证服务器是否合法 重写 setSessionDidReceiveAuthenticationChallengeBlock 方法
        //    [self setupHTTPSP12];
    });
    return manager;
}

- (void)sendRequestWithAddress:(NSString *)address parameterDict:(NSDictionary *)paramDict tag:(NSString *)urlTag name:(NSString *)urlName {
    self.manager = [self singleManager];

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
//    [_manager.requestSerializer setValue:URLString forHTTPHeaderField:@"Referer"];
    
    [_manager POST:URLString
        parameters:postDict
          progress:^(NSProgress * _Nonnull uploadProgress) {
              ;
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                  options:NSJSONReadingMutableContainers
                                                                    error:nil];//error暂不处理
             NSString *code = dict[@"err_code"];
             
             if (code.integerValue == 0) {
                 YLYLog(@"%@: 请求成功!", urlName);
                 [self success:dict];
             } else {
                 YLYLog(@"%@: 不成功!", urlName);
                 [self other:dict];
             }
             YLYLog(@"dict = %@", dict);

         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             YLYLog(@"%@", error);
             if (error.code == NSURLErrorTimedOut) {
                 YLYLog(@"%@: 请求超时!", urlName);
                 [self overTime];
             } else {
                 //请求数据失败，各种错误

             }
         }
     ];
}



#pragma -mark 处理请求回调
//请求成功
- (void)success:(NSDictionary *)retDict {
    if (self.requestSuccessBlock) {
        self.requestSuccessBlock(retDict);
    }
}
//其他code
- (void)other:(NSDictionary *)retDict {
//    NSString *code = retDict[@"err_code"];
    
    YLYLog(@"%@", retDict[@"ret_msg"]);
    [[YLYHelper shareHelper] showHudViewWithString:retDict[@"ret_msg"]];
    if (self.requestOtherBlock) {
        self.requestOtherBlock(retDict);
    }
}
//超时
- (void)overTime {
    YLYLog(@"超时");
    
    
}

#pragma -mark 购买https认证配置
- (void)setupHTTPSAuthority {
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"https" ofType:@"cer"];
    NSData *certData =[NSData dataWithContentsOfFile:cerPath];
    NSSet *certSet = [[NSSet alloc] initWithObjects:certData, nil];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // 是否允许,NO-- 不允许无效的证书
    [securityPolicy setAllowInvalidCertificates:YES];
    // 设置证书
    [securityPolicy setPinnedCertificates:certSet];
    _manager.securityPolicy = securityPolicy;
}


#pragma -mark 单向验证
//服务器验证客户端合法
- (void)setupHTTPSCer {
    NSString *certFilePath = [[NSBundle mainBundle] pathForResource:BaseHTTPSCerPath ofType:@"cer"];
    NSData *certData = [NSData dataWithContentsOfFile:certFilePath];
    // AFSSLPinningModeCertificate 使用证书验证模式
    NSSet *certSet = [NSSet setWithObject:certData];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:certSet];
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    [_manager setSecurityPolicy:securityPolicy];
}

#pragma -mark 双向验证 - 服务器验证客户端 .cer
//客户端验证服务器合法
- (void)setupHTTPSP12 {
    //客服端请求验证 重写 setSessionDidReceiveAuthenticationChallengeBlock 方法
    SELF_WEAK();
    [_manager setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition(NSURLSession*session, NSURLAuthenticationChallenge *challenge, NSURLCredential *__autoreleasing*_credential) {
        NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        __autoreleasing NSURLCredential *credential =nil;
        if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
            if([weakSelf.manager.securityPolicy evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:challenge.protectionSpace.host]) {
                credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
                if(credential) {
                    disposition =NSURLSessionAuthChallengeUseCredential;
                } else {
                    disposition =NSURLSessionAuthChallengePerformDefaultHandling;
                }
            } else {
                disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
            }
        } else {
            // client authentication
            SecIdentityRef identity = NULL;
            SecTrustRef trust = NULL;
            NSString *p12 = [[NSBundle mainBundle] pathForResource:BaseHTTPSP12Path ofType:@"p12"];
            NSFileManager *fileManager =[NSFileManager defaultManager];
            
            if(![fileManager fileExistsAtPath:p12]) {
                NSLog(@"client.p12:not exist");
            } else {
                NSData *PKCS12Data = [NSData dataWithContentsOfFile:p12];
                
                if ([[weakSelf class]extractIdentity:&identity andTrust:&trust fromPKCS12Data:PKCS12Data])
                {
                    SecCertificateRef certificate = NULL;
                    SecIdentityCopyCertificate(identity, &certificate);
                    const void*certs[] = {certificate};
                    CFArrayRef certArray =CFArrayCreate(kCFAllocatorDefault, certs,1,NULL);
                    credential =[NSURLCredential credentialWithIdentity:identity certificates:(__bridge  NSArray*)certArray persistence:NSURLCredentialPersistencePermanent];
                    disposition =NSURLSessionAuthChallengeUseCredential;
                }
            }
        }
        *_credential = credential;
        return disposition;
    }];
}

+ (BOOL)extractIdentity:(SecIdentityRef*)outIdentity andTrust:(SecTrustRef *)outTrust fromPKCS12Data:(NSData *)inPKCS12Data {
    OSStatus securityError = errSecSuccess;
    //client certificate password
    NSDictionary *optionsDictionary = [NSDictionary dictionaryWithObject:@"你的p12密码"
                                                                  forKey:(__bridge id)kSecImportExportPassphrase];
    
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import((__bridge CFDataRef)inPKCS12Data,(__bridge CFDictionaryRef)optionsDictionary,&items);
    
    if(securityError == 0) {
        CFDictionaryRef myIdentityAndTrust =CFArrayGetValueAtIndex(items,0);
        const void*tempIdentity =NULL;
        tempIdentity= CFDictionaryGetValue (myIdentityAndTrust,kSecImportItemIdentity);
        *outIdentity = (SecIdentityRef)tempIdentity;
        const void*tempTrust =NULL;
        tempTrust = CFDictionaryGetValue(myIdentityAndTrust,kSecImportItemTrust);
        *outTrust = (SecTrustRef)tempTrust;
    } else {
        NSLog(@"Failedwith error code %d",(int)securityError);
        return NO;
    }
    return YES;
}

#pragma -mark 双向验证 - 客户端验证服务器 .p12
/**** SSL Pinning ****/
- (AFSecurityPolicy*)customSecurityPolicy {
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:BaseHTTPSCerPath ofType:@"cer"];
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    [securityPolicy setAllowInvalidCertificates:YES];
    NSSet *set = [NSSet setWithObjects:certData, nil];
    [securityPolicy setPinnedCertificates:set];
    /**** SSL Pinning ****/
    return securityPolicy;
}

@end
