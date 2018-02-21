//
//  YLYHelper.m
//  TestDemo
//
//  Created by yu on 31/08/2017.
//  Copyright © 2017 yu. All rights reserved.
//

#import "YLYHelper.h"
#import <Reachability/Reachability.h>
#import "YLYDefine.h"

@implementation YLYHelper

+ (void)registerNotificationName:(NSString *)notiName observer:(id)observer event:(notificationBlock)block {
    [[NSNotificationCenter defaultCenter] addObserverForName:notiName
                                                      object:observer
                                                       queue:[NSOperationQueue mainQueue] /*暂时放在主线程*/ usingBlock:^(NSNotification * _Nonnull note) {
                                                           if (block != nil) {
                                                               block(note);
                                                           }
                                                       }
     ];
}

+ (void)removeNotificationName:(NSString *)notiName observer:(id)observer {
    [[NSNotificationCenter defaultCenter] removeObserver:observer
                                                    name:notiName
                                                  object:nil];
}

//自动适配Rect
+ (CGRect)autoAdjustRect:(CGRect)rect {
    CGRect retRect = CGRectMake(0, 0, 0, 0);
    
    //倍率 按照设计的6屏幕宽度为标准,高度有偏差
    CGFloat rate = 0.0f;
    
    
    if (iPhone6P) {
        rate = 1242.0f/750.0f;
        rate = rate/3.0f;
    } else if (iPhone6) {
        rate = 1.0f;
        rate = rate/2.0f;
    } else if (iPhoneX) {
        rate = 1125.0f/750.0f;
        rate = rate/3.0f;
    } else if (iPhone5) {
        rate = 640.0f/750.0f;
        rate = rate/2.0f;
    }
    
    retRect = CGRectMake(rect.origin.x*rate, rect.origin.y*rate, rect.size.width*rate, rect.size.height*rate);
    
    
    return retRect;
}





//自动适配长度
+ (CGFloat)autoAdjustWidth:(CGFloat)width {
    CGFloat retFloat = 0.0f;
    
    //倍率 按照设计的6屏幕宽度为标准,高度有偏差
    CGFloat rate = 0.0f;
    
    if (iPhone6P) {
        rate = 1242.0f/750.0f;
        rate = rate/3.0f;
    } else if (iPhone6) {
        rate = 1.0f;
        rate = rate/2.0f;
    } else if (iPhoneX) {
        rate = 1125.0f/750.0f;
        rate = rate/3.0f;
    } else {
        rate = 640.0f/750.0f;
        rate = rate/2.0f;
    }
    
    retFloat = width*rate;
    
    
    return retFloat;
}

//自动适配Font
+ (UIFont *)autoAdjustFont:(CGFloat)fontFloat {
    UIFont *retFont = [UIFont systemFontOfSize:0];
    
    //倍率 按照设计的6屏幕宽度为标准,高度有偏差
    CGFloat rate = 0.0f;
    
    if (iPhone6P) {
        rate = 1242.0f/750.0f;
        rate = rate/3.0f;
    } else if (iPhone6) {
        rate = 1.0f;
        rate = rate/2.0f;
    } else if (iPhoneX) {
        rate = 1125.0f/750.0f;
        rate = rate/3.0f;
    } else {
        rate = 640.0f/750.0f;
        rate = rate/2.0f;
    }
    
    retFont = [UIFont systemFontOfSize:fontFloat*rate];
    
    
    return retFont;
}

@end
