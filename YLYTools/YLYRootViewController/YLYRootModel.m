//
//  YLYRootModel.m
//  Eyuemeiche
//
//  Created by yu on 07/02/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "YLYRootModel.h"
#import <objc/runtime.h>

@implementation YLYRootModel

/*
 序列化NSCoding
 */
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        unsigned int outCount;
        Ivar *ivarList = class_copyIvarList([self class], &outCount);
        for (unsigned int i = 0; i < outCount; i ++) {
            Ivar ivar = ivarList[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            [self setValue:[aDecoder decodeObjectForKey:key] forKey:key];
        }
        free(ivarList);
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int outCount;
    Ivar *ivarList = class_copyIvarList([self class], &outCount);
    for (unsigned int i = 0; i < outCount; i ++) {
        Ivar ivar = ivarList[i];
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
    free(ivarList);
}

@end
