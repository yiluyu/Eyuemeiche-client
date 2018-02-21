//
//  YLYPropertyManager.m
//  TestDemo
//
//  Created by yu on 31/08/2017.
//  Copyright © 2017 yu. All rights reserved.
//

#import "YLYPropertyManager.h"
#import "YLYDefine.h"

@implementation YLYPropertyManager

+ (instancetype)sharePropertyManager {
    static YLYPropertyManager *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[super allocWithZone:NULL] init];
    });
    
    return shareInstance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self sharePropertyManager];
}





//获取userToken
- (NSString *)getLocalUserToken {
    if (![_localUserToken isKindOfClass:[NSNull class]] && _localUserToken != nil && _localUserToken.length != 0) {
        //非第一次获取
        return _localUserToken;
    } else {
        //第一次获取从存储读
        NSString *ret = [USERDEFAULTS objectForKey:@"localUserToken"];
        if (![ret isKindOfClass:[NSNull class]] && ret != nil && ret.length != 0) {
            return ret;
        } else {
            return @"";
        }
    }

    return nil;
}
- (void)setLocalUserToken:(NSString *)localUserToken {
    if (_localUserToken != localUserToken) {
        _localUserToken = localUserToken;
    }
}

//获取deviceToken
- (NSString *)getDeviceToken {
    if (![_deviceToken isKindOfClass:[NSNull class]] && _deviceToken != nil && _deviceToken.length != 0) {
        //非第一次获取
        return _deviceToken;
    } else {
        //第一次获取从存储读
        NSString *ret = [USERDEFAULTS objectForKey:@"deviceToken"];
        if (![ret isKindOfClass:[NSNull class]] && ret != nil && ret.length != 0) {
            return ret;
        } else {
            return @"";
        }
    }
    
    return nil;
}
- (void)setDeviceToken:(NSString *)deviceToken {
    if (_deviceToken != deviceToken) {
        _deviceToken = deviceToken;
    }
}










@end
