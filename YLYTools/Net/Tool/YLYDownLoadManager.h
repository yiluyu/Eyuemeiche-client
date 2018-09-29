//
//  YLYDownLoadManager.h
//  TestDemo
//
//  Created by yu on 31/08/2017.
//  Copyright © 2017 yu. All rights reserved.
//

/*
 对请求类 YLYNetBox 进行统一管理
 */

#import <Foundation/Foundation.h>
#import "YLYNetBox.h"

@interface YLYDownLoadManager : NSObject

///获取 netManager
+ (instancetype)shareManager;

/* 返回一个YLYNetBox对象, 放在 manager 中进行管理. 需要传入 sender */
///创建 netBox
- (YLYNetBox *)createNetBoxWithSender:(id)sender;

///清空 sender 下所有请求
- (void)clearNetBoxInSender:(id)sender;

@end
