//
//  NSMutableDictionary+ExtendMethod.m
//  Eyuemeiche
//
//  Created by yiluyu on 2018/10/16.
//  Copyright © 2018年 yu. All rights reserved.
//

#import "NSMutableDictionary+ExtendMethod.h"
#import "YLYDefine.h"

@implementation NSMutableDictionary (ExtendMethod)

- (void)safeSetObject:(id)object forKey:(id)key {
    if ([key isKindOfClass:[NSNull class]]
        || key == nil
        || ![key isKindOfClass:[NSString class]]) {
        YLYLog(@"mutableDictionary配置key非法!");
    } else {
        [self setObject:object forKey:key];
    }
}

@end
