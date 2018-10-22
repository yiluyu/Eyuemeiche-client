//
//  NSMutableDictionary+ExtendMethod.h
//  Eyuemeiche
//
//  Created by yiluyu on 2018/10/16.
//  Copyright © 2018年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableDictionary (ExtendMethod)

- (void)safeSetObject:(id)object forKey:(id)key;

@end

NS_ASSUME_NONNULL_END
