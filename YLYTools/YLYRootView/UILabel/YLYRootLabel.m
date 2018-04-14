//
//  YLYRootLabel.m
//  Eyuemeiche
//
//  Created by yu on 27/02/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "YLYRootLabel.h"
#import "NSString+ExtendMethod.h"
#import "YLYDefine.h"

@implementation YLYRootLabel

+ (UILabel *)creatLabelText:(NSString *)showText font:(UIFont *)font color:(UIColor *)textColor {
    YLYRootLabel *label = [[YLYRootLabel alloc] init];
    if ([NSString checkNullString:showText].length != 0) {
        label.text = showText;
    } else {
        label.text = @"";
    }
    label.font = font;
    label.textColor = textColor;
    label.backgroundColor = COLOR_CLEAR;
    
    return label;
}

@end
