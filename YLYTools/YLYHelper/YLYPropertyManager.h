//
//  YLYPropertyManager.h
//  TestDemo
//
//  Created by yu on 31/08/2017.
//  Copyright © 2017 yu. All rights reserved.
//

/*
 该对象用来暂时存放每一次启动后的临时数据
 */

#import <Foundation/Foundation.h>

@interface YLYPropertyManager : NSObject

+ (instancetype)sharePropertyManager;

/* 临时属性 */
@property (nonatomic, readwrite, assign)BOOL loginVCShowing;//正在展示loginVC


/* 持久属性 */
@property (nonatomic, readwrite, strong)NSString *localUserToken;//本地存储用户token
@property (nonatomic, readwrite, strong)NSString *deviceToken;//推送token



@end
