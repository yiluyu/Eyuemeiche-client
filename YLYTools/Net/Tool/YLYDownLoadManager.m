//
//  YLYDownLoadManager.m
//  TestDemo
//
//  Created by yu on 31/08/2017.
//  Copyright © 2017 yu. All rights reserved.
//

#import "YLYDownLoadManager.h"
#import "URLConfig.h"
#import <AFNetworking.h>
#import "YLYDefine.h"

@interface YLYDownLoadManager ()
{
    /*
     netsDict结构: {
     senderKey1:{{netBoxKey1:netBox1}, {netBoxKey2:netBox2}, ...}
     senderKey2:{{netBoxKey1:netBox1}, {netBoxKey2:netBox2}, ...}
     ...
     }
     */
    NSMutableDictionary *netsDict;//管理字典
}

@property (nonatomic, readwrite, strong)AFHTTPSessionManager *manager;

@end

@implementation YLYDownLoadManager

+ (instancetype)shareManager {
    static YLYDownLoadManager *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[super allocWithZone:NULL] init];
        shareInstance->netsDict = [[NSMutableDictionary alloc] initWithCapacity:0];
        shareInstance->_manager = [shareInstance setUpAFNet];
    });
    return shareInstance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self shareManager];
}

#pragma -mark 配置 AFNetWorking
- (AFHTTPSessionManager *)setUpAFNet {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BaseURLString]];
    //常规配置
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain", nil];
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.0f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manager.requestSerializer setValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
//        //关闭缓存
//        _manager = NSURLRequestReloadIgnoringLocalCacheData;
//        [_manager setSessionDidBecomeInvalidBlock:^(NSURLSession * _Nonnull session, NSError * _Nonnull error) {
//            NSLog(@"设置session失效");
//        }];
    
    /* 以下为认证https设置 */
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"https" ofType:@"cer"];
    NSData *certData =[NSData dataWithContentsOfFile:cerPath];
    NSSet *certSet = [[NSSet alloc] initWithObjects:certData, nil];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    // 是否允许,NO-- 不允许无效的证书
    [securityPolicy setAllowInvalidCertificates:NO];
//    [securityPolicy setValidatesDomainName:NO];
    // 设置证书
    [securityPolicy setPinnedCertificates:certSet];
    manager.securityPolicy = securityPolicy;
    
    /* 以下为自建https设置 */
//    //单向验证
//    _manager.securityPolicy = [self customSecurityPolicy];
//    //双向验证 - 服务器验证客户端cer是否由服务器派发
//    [self setupHTTPSCer];
//    //双向验证 - 客服端验证服务器是否合法 重写 setSessionDidReceiveAuthenticationChallengeBlock 方法
//    [self setupHTTPSP12];
    return manager;
}

#pragma -mark 获取 netBox 对象
//创建netBox对象
- (YLYNetBox *)createNetBoxWithSender:(id)sender {
    YLYNetBox *netBox = [[YLYNetBox alloc] init];
    netBox.manager = self.manager;
    netBox.viewController = sender;
    
    //加入管理字典
    [self addNetBoxToDict:sender netBox:netBox];
    
    SELF_WEAK();
    //回调清除管理字典
    netBox.requestDown = ^(id sender, YLYNetBox *netBox) {
        [weakSelf removeNetBoxFromDict:sender netBox:netBox];
    };
    
    return netBox;
}

//加入管理字典
- (void)addNetBoxToDict:(id)sender netBox:(YLYNetBox *)netBox {
    /*
     YLYLog(@"%x", &_mainView);//指针地址
     YLYLog(@"%p", _mainView);//指针指向的地址
     */
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    //加入字典
    NSString *senderKey = [NSString stringWithFormat:@"%p", sender];
    NSString *netBoxKey = [NSString stringWithFormat:@"%p", netBox];
    NSMutableDictionary *netBoxDict = netsDict[senderKey];
    if (netBoxDict == nil) {
        netBoxDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    [netBoxDict setObject:netBox forKey:netBoxKey];
    [netsDict setObject:netBoxDict forKey:senderKey];
    
    dispatch_semaphore_signal(semaphore);
}

//删除管理字典
- (void)removeNetBoxFromDict:(id)sender netBox:(YLYNetBox *)netBox {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    //检查字典
    NSString *senderKey = [NSString stringWithFormat:@"%p", sender];
    NSMutableDictionary *netBoxDict = netsDict[senderKey];
    if (netBoxDict != nil) {
        NSString *netBoxKey = [NSString stringWithFormat:@"%p", netBox];
        [netBoxDict removeObjectForKey:netBoxKey];
        
        if (netBoxDict.allKeys.count == 0) {
            [netsDict removeObjectForKey:senderKey];
        }
    }
    
    dispatch_semaphore_signal(semaphore);
}

//清空指定 sender 下的所有请求
- (void)clearNetBoxInSender:(id)sender {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    //查询字典
    NSString *senderKey = [NSString stringWithFormat:@"%p", sender];
    NSMutableDictionary *netBoxDict = netsDict[senderKey];
    if (netBoxDict != nil) {
        //遍历dict下的所有netbox
        NSArray *objects = netBoxDict.allValues;
        for (YLYNetBox *netBox in objects) {
            [netBox cancelRequest];
        }
        //清空 senderKey
        [netsDict removeObjectForKey:senderKey];
    }
    
    dispatch_semaphore_signal(semaphore);
}


#pragma -mark 购买https认证配置
- (void)setupHTTPSAuthority {
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"https" ofType:@"cer"];
    NSData *certData =[NSData dataWithContentsOfFile:cerPath];
    NSSet *certSet = [[NSSet alloc] initWithObjects:certData, nil];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // 是否允许,NO-- 不允许无效的证书
    [securityPolicy setAllowInvalidCertificates:NO];
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
