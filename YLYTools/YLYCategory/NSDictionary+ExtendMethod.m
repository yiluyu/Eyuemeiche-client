//
//  NSDictionary+ExtendMethod.m
//  Eyuemeiche
//
//  Created by yiluyu on 2018/10/16.
//  Copyright © 2018年 yu. All rights reserved.
//

#import "NSDictionary+ExtendMethod.h"

@implementation NSDictionary (ExtendMethod)

- (BOOL)isNull:(id)value
{
    if([NSNull null] == (NSNull *)value)
    {
        return YES;
    }
    
    return NO;
}

- (id)safeObjectForKey:(id)aKey
{
    if ([self isNull:[self objectForKey:aKey]])
    {
        return nil;
    }
    return [self objectForKey:aKey];
}

- (id)safeValueForKey:(NSString *)key
{
    if ([self isNull:[self valueForKey:key]])
    {
        return nil;
    }
    return [self valueForKey:key];
}

- (NSString *)safeStringValueForKey:(NSString *)key
{
    if ([self valueForKey:key] == nil || [self isNull:[self valueForKey:key]])
    {
        return @"";
    }
    return [NSString stringWithFormat:@"%@", [self valueForKey:key]];
}

- (id)safeValueForKeyPath:(NSString *)keyPath
{
    if ([self isNull:[self valueForKeyPath:keyPath]])
    {
        return nil;
    }
    return [self valueForKeyPath:keyPath];
}

@end
