//
//  YLYRootTextField.m
//  Eyuemeiche
//
//  Created by yu on 07/03/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "YLYRootTextField.h"

@implementation YLYRootTextField

/*
 iOS11后textField新增属性provider指向自己, 引起循环引用.
 解决无法释放问题
 */
- (void)didMoveToWindow {
    [super didMoveToWindow];
    if (@available(iOS 11.2, *)) {
        NSString *keyPath = @"textContentView.provider";
        @try {
            if (self.window) {
                //KVC获取对象属性
                id provider = [self valueForKeyPath:keyPath];
                if (!provider && self) {
                    //如果provider没有就设成self, 遵循iOS11系统设计
                    [self setValue:self
                        forKeyPath:keyPath];
                }
            } else {
                //如果从window移除了, 这个provider属性就置为空避免循环引用
                [self setValue:nil forKeyPath:keyPath];
            }
        } @catch (NSException *exception) {
            NSLog(@"%@", exception);
        } @finally {
            ;
        }
    }
}

@end
