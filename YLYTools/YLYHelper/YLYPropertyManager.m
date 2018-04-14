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



@end
