//
//  UserManager.m
//  Eyuemeiche
//
//  Created by yu on 14/11/2017.
//  Copyright © 2017 yu. All rights reserved.
//

#import "UserManager.h"
#import "YLYDefine.h"

@implementation UserManager

+ (instancetype)shareInstanceUserInfo {
    static dispatch_once_t predicateManagerOnceToken;
    static UserManager *_singleton = nil;
    dispatch_once(&predicateManagerOnceToken, ^{
        _singleton = [[super allocWithZone:NULL] init];
        //每次启动只可初始化一次
        [_singleton initialUserInfoModel];
    });
    
    return _singleton;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self shareInstanceUserInfo];
}

//user数据路径
- (NSString *)path {
    NSString *userDataPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dataName = @"userData.eyuemeiche";
    userDataPath = [userDataPath stringByAppendingPathComponent:dataName];
    return userDataPath;
}

//初始化本地user数据
- (void)initialUserInfoModel {
    NSString *userDataPath = [self path];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 数据是否存在
    if ([fileManager fileExistsAtPath:userDataPath]) {
        //读取该数据
        self.userModel = [NSKeyedUnarchiver unarchiveObjectWithData:[NSData dataWithContentsOfFile:userDataPath]];
    } else {
        //创建该数据
        self.userModel = [[UserInfoModel alloc] init];
        [self.userModel renewUserData];
    }
}


//存储user信息
- (void)saveUserData {
    [NSKeyedArchiver archiveRootObject:self.userModel toFile:[self path]];
}


@end
