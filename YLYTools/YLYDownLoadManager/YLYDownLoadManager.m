//
//  YLYDownLoadManager.m
//  TestDemo
//
//  Created by yu on 31/08/2017.
//  Copyright © 2017 yu. All rights reserved.
//

#import "YLYDownLoadManager.h"

@interface YLYDownLoadManager ()

@property (nonatomic, readwrite, strong)NSMutableDictionary *controllerDict;//总操作字典

@end

@implementation YLYDownLoadManager

+ (instancetype)shareDownLoadManager {
    static YLYDownLoadManager *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[super allocWithZone:NULL] init];
    });
    return shareInstance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self shareDownLoadManager];
}


#pragma -mark 具体请求




@end
