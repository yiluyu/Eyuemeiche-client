//
//  YLYFunction.h
//  TestDemo
//
//  Created by yu on 31/08/2017.
//  Copyright © 2017 yu. All rights reserved.
//

/*
 该对象用来使用一些通用方法
 */

#import <UIKit/UIKit.h>

@interface YLYFunction : NSObject

//基于6宽度适配rect
+ (CGRect)autoAdjustRect:(CGRect)rect;

//基于6屏幕适配长度
+ (CGFloat)autoAdjustWidth:(CGFloat)width;

//基于6屏幕适配字体
+ (UIFont *)autoAdjustFont:(CGFloat)fontFloat;



@end
