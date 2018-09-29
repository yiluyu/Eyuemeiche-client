//
//  YLYRootButton.m
//  Eyuemeiche
//
//  Created by yu on 27/02/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "YLYRootButton.h"
#import "YLYDefine.h"

@implementation YLYRootButton

+ (YLYRootButton *)createButtonText:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont backgroundImageName:(NSString *)bgImageName target:(id)target SEL:(SEL)methodNameSEL {
    YLYRootButton *btn = [[YLYRootButton alloc] init];
    btn.backgroundColor = COLOR_CLEAR;
    btn.titleLabel.font = (titleFont==nil)?YLY6Font(0):titleFont;
    [btn setTitle:[NSString checkNullString:title] forState:UIControlStateNormal];
    [btn setTitleColor:(titleColor==nil)?COLOR_CLEAR:titleColor forState:UIControlStateNormal];
    if ([NSString checkNullString:bgImageName].length == 0) {
        [btn setBackgroundImage:[UIImage imageNamed:@"none"] forState:UIControlStateNormal];
    } else {
        [btn setBackgroundImage:[UIImage imageNamed:bgImageName] forState:UIControlStateNormal];
    }
    [btn addTarget:target action:methodNameSEL forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

@end
