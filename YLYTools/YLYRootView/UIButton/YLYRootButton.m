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

+ (YLYRootButton *)creatButtonText:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont backgroundImageName:(NSString *)bgImageName target:(id)target SEL:(SEL)methodNameSEL {
    YLYRootButton *btn = [[YLYRootButton alloc] init];
    btn.backgroundColor = COLOR_CLEAR;
    btn.titleLabel.font = (titleFont==nil)?YLY6Font(0):titleFont;
    [btn setTitle:[NSString checkNullString:title] forState:UIControlStateNormal];
    [btn setTitleColor:(titleColor==nil)?COLOR_CLEAR:titleColor forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:[NSString checkNullString:bgImageName]] forState:UIControlStateNormal];
    [btn addTarget:target action:methodNameSEL forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

@end
