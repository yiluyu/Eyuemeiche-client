//
//  YLYHelper.h
//  TestDemo
//
//  Created by yu on 31/08/2017.
//  Copyright © 2017 yu. All rights reserved.
//

/*
 该对象包括所有辅助类
 */

#import <Foundation/Foundation.h>

/*
 基础tool类
 */
#import "YLYFunction.h"
#import "YLYPropertyManager.h"
#import "YLYDownLoadManager.h"
#import "YLYDefine.h"

/*
 扩展类别
 */
#import "NSString+ExtendMethod.h"
#import "UIColor+ExtendMethod.h"


typedef void (^notificationBlock)(NSNotification *noti);


@interface YLYHelper : NSObject

//通知
/** 添加通知 */
+ (void)registerNotificationName:(NSString *)notiName observer:(id)observer event:(notificationBlock)block;
/** 注销通知 */
+ (void)removeNotificationName:(NSString *)notiName observer:(id)observer;


@end
