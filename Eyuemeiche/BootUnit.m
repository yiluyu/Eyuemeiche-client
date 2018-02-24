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
#import "YLYDefine.h"

#import "YLYPropertyManager.h"

@interface BootUnit ()

@property (nonatomic, readwrite, strong)YLYRootTabbarController *tabbarController;
@property (nonatomic, readwrite, strong)YLYRootNavigationController *mainNavi;//主流程navi
@property (nonatomic, readwrite, strong)YLYRootNavigationController *loginNavi;//注册流程navi

@property (nonatomic, readwrite, assign)double rate;//宽度比例

@end

@implementation BootUnit

+ (instancetype)shareUnit {
    static BootUnit *unit = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        unit = [[super allocWithZone:NULL] init];
        
        [unit creatTabbar];
        [unit creatNotifications];
        [unit systemInit];
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
    
    //Navi
    self.mainNavi = [[YLYRootNavigationController alloc] initWithRootViewController:mainVC];
    _mainNavi.navigationBar.translucent = NO;
    _mainNavi.navigationBar.hidden = YES;
    
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
//    SELF_WEAK();
    //网络状态监听
    
}


#pragma -mark 事件处理
//联网状态
- (void)checkNetStatus {
    
}



#pragma -mark 获取系统一些属性
//一次性获取属性, 其他判断直接取值
- (void)systemInit {
    //获取宽度比例
    //倍率 按照设计的6屏幕宽度为标准,高度有偏差
    double rate = 0.0f;
    
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
    self.rate = rate;
    
    
    
}


#pragma -mark 页面跳转
//推出loginVC
- (void)pushLoginVC {\
    if (_loginNavi == nil) {
        //登录页
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        self.loginNavi = [[YLYRootNavigationController alloc] initWithRootViewController:loginVC];
        _loginNavi.navigationBar.translucent = NO;
        _loginNavi.navigationBar.hidden = YES;
    }
    
    __block __weak YLYPropertyManager *propertyManager = [YLYPropertyManager sharePropertyManager];
    [_mainNavi presentViewController:_loginNavi animated:YES completion:^{
        propertyManager.loginVCShowing = YES;
        _tabbarController.selectedIndex = 0;
        [_mainNavi popToRootViewControllerAnimated:NO];
    }];
}
//收回
- (void)closeLoginVC {
    __block __weak YLYPropertyManager *propertyManager = [YLYPropertyManager sharePropertyManager];
    [_loginNavi dismissViewControllerAnimated:YES completion:^{
        propertyManager.loginVCShowing = NO;
        _tabbarController.selectedIndex = 0;
        [_mainNavi popToRootViewControllerAnimated:NO];
        
        _loginNavi = nil;
    }];
}





@end
