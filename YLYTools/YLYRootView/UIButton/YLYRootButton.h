//
//  YLYRootButton.h
//  Eyuemeiche
//
//  Created by yu on 27/02/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+ExtentMethod.h"

@class YLYRootButton;

@interface YLYRootButton : UIButton

/** 常规创建btn */
+ (YLYRootButton *)createButtonText:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont backgroundImageName:(NSString *)BGImageName target:(id)target SEL:(SEL)methodNameSEL;

@end
