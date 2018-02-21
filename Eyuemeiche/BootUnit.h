//
//  BootUnit.h
//  Eyuemeiche
//
//  Created by yu on 12/02/2018.
//  Copyright © 2018 yu. All rights reserved.
//

/*
 app基础配置
 */

#import <Foundation/Foundation.h>

@class YLYRootTabbarController;
@class YLYRootNavigationController;

@interface BootUnit : NSObject

+ (instancetype)shareUnit;

/** tabbar */
@property (nonatomic, readonly, strong)YLYRootTabbarController *tabbarController;

//navi
@property (nonatomic, readonly, strong)YLYRootNavigationController *mainNavi;//主流程navi
@property (nonatomic, readonly, strong)YLYRootNavigationController *loginNavi;//注册流程navi





/*
 方法
 */

/** 推出loginVC */
- (void)pushLoginVC;


@end
