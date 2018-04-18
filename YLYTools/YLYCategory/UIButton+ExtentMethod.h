//
//  UIButton+ExtentMethod.h
//  Eyuemeiche
//
//  Created by yu on 16/04/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ExtentMethod)

///按钮响应时间间隔, 默认 1.0f
@property (nonatomic, readwrite, assign)NSTimeInterval actionIntervalTime;

@end
