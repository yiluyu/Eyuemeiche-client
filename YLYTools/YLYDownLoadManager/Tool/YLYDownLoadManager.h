//
//  YLYDownLoadManager.h
//  TestDemo
//
//  Created by yu on 31/08/2017.
//  Copyright © 2017 yu. All rights reserved.
//

/*
 对请求类 YLYNetBox 进行统一管理, 暂时不启用
 */

#import <Foundation/Foundation.h>

@interface YLYDownLoadManager : NSObject

/** 获取 netManager */
+ (instancetype)shareDownLoadManager;



@end
