//
//  NSDictionary+ExtendMethod.h
//  Eyuemeiche
//
//  Created by yiluyu on 2018/10/16.
//  Copyright © 2018年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (ExtendMethod)

- (BOOL)isNull:(id)value;
- (id)safeObjectForKey:(id)aKey;
- (id)safeValueForKey:(NSString *)key;
- (id)safeValueForKeyPath:(NSString *)keyPath;

- (NSString *)safeStringValueForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
