//
//  BootUnit.m
//  Eyuemeiche
//
//  Created by yu on 12/02/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "BootUnit.h"

#import "YLYRootTabbarController.h"
#import "YLYRootNavigationController.h"

#import "MainViewController.h"
#import "LoginViewController.h"

#import "UserManager.h"

#import "YLYPropertyManager.h"

@interface BootUnit ()

@property (nonatomic, readwrite, strong)YLYRootTabbarController *tabbarController;
@property (nonatomic, readwrite, strong)YLYRootNavigationController *mainNavi;//主流程navi
@property (nonatomic, readwrite, strong)YLYRootNavigationController *loginNavi;//注册流程navi

@end

@implementation BootUnit

+ (instancetype)shareUnit {
    static BootUnit *unit = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        unit = [[super allocWithZone:NULL] init];
        
        [unit creatTabbar];
        [unit creatNotifications];
        
    });
    
    return unit;
}
+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self shareUnit];
}

//创建tabbar
- (void)creatTabbar {
    self.tabbarController = [[YLYRootTabbarController alloc] init];
    _tabbarController.selectedIndex = 0;
    _tabbarController.tabBar.hidden = YES;
    
    //主页
    MainViewController *mainVC = [[MainViewController alloc] init];
    //登录页
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    
    //Navi
    self.mainNavi = [[YLYRootNavigationController alloc] initWithRootViewController:mainVC];
    _mainNavi.navigationBar.translucent = NO;
    _mainNavi.navigationBar.hidden = YES;
    
    //Navi
    self.loginNavi = [[YLYRootNavigationController alloc] initWithRootViewController:loginVC];
    _loginNavi.navigationBar.translucent = NO;
    _loginNavi.navigationBar.hidden = YES;
    
    _tabbarController.viewControllers = @[_mainNavi];
}


//通知
- (void)creatNotifications {
    //加载本地用户数据
    [UserManager shareInstanceUserInfo];
    //检查网络状态
    [self checkNetStatus];
    //检测是否登录失效
}


#pragma -mark 注册通知
- (void)registerNotification {
    SELF_WEAK();
    //网络状态监听
    
}


#pragma -mark 事件处理
//联网状态
- (void)checkNetStatus {
    
}

//推出loginVC
- (void)pushLoginVC {
    YLYPropertyManager *propertyManager = [YLYPropertyManager sharePropertyManager];
    
    [_mainNavi presentViewController:_loginNavi animated:YES completion:^{
        propertyManager.loginVCShowing = YES;
        [_mainNavi popToRootViewControllerAnimated:NO];
    }];
}


@end
