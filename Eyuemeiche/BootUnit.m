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
    [self getRate];
    //验证是否第一次启动
    [self getFirstStatus];
    //获取提供第三方服务器的id
    [self getIDForVendor];
    //适配iOS 11
    [self adaptSystem];
}


#pragma -mark 页面跳转
//推出loginVC
- (void)pushLoginVC {
    YLYPropertyManager *propertyManager = [YLYPropertyManager sharePropertyManager];
    if (propertyManager.loginVCShowing == YES) {
        return;
    }
    
    if (_loginNavi == nil) {
        //登录页
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        self.loginNavi = [[YLYRootNavigationController alloc] initWithRootViewController:loginVC];
        _loginNavi.navigationBar.translucent = NO;
        _loginNavi.navigationBar.hidden = YES;
    }
    
    __weak typeof (YLYRootTabbarController *)weakTabbar = _tabbarController;
    __weak typeof (YLYRootNavigationController *)weakMainNavi = _mainNavi;
    [_mainNavi presentViewController:_loginNavi animated:YES completion:^{
        weakTabbar.selectedIndex = 0;
        [weakMainNavi popToRootViewControllerAnimated:NO];
    }];
}
//收回
- (void)closeLoginVC {
    __block __weak YLYPropertyManager *propertyManager = [YLYPropertyManager sharePropertyManager];
    __weak typeof (YLYRootTabbarController *)weakTabbar = _tabbarController;
    __weak typeof (YLYRootNavigationController *)weakMainNavi = _mainNavi;
    [_loginNavi dismissViewControllerAnimated:YES completion:^{
        propertyManager.loginVCShowing = NO;
        weakTabbar.selectedIndex = 0;
        [weakMainNavi popToRootViewControllerAnimated:NO];
    }];
    
    _loginNavi = nil;
}


#pragma -mark 功能方法
- (void)getRate {
    //倍率 按照设计的6屏幕宽度为标准,高度有偏差
    double rate = 0.0f;

    //#define iPhone6P ((SCREEN_WIDTH == 414)?YES:NO)//414.000000, 736.000000
    //#define iPhone6 ((SCREEN_WIDTH == 375)?YES:NO)//375.000000, 667.000000
    //#define iPhone5 ((SCREEN_WIDTH == 320)?YES:NO)//320.000000, 568.000000
    //#define iPhoneX ((SCREEN_WIDTH == 375) && (SCREEN_HEIGHT == 812)?YES:NO)//375.000000, 812.000000
    if (iPhoneX) {
        rate = 1.0f;
    } else if (iPhone6P) {
        rate = 414.0f/375.0f;
    } else if (iPhone6) {
        rate = 1.0f;
    } else {
        rate = 320.0f/375.0f;
    }
    
    self.rate = rate;
}

- (void)getFirstStatus {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:CONSTANT_USERDEFAULTS_APPFIRSTLAUNCH] == NO) {
        YLYLog(@"第一次启动app");
        //默认空token
        USERDEFAULTS_SET(@"", CONSTANT_USERDEFAULTS_LOCALUSERTOKEN);
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:CONSTANT_USERDEFAULTS_APPFIRSTLAUNCH];
    } else {
        ;
    }
}

- (void)getIDForVendor {
    NSString *UUID = [[UIDevice currentDevice].identifierForVendor UUIDString];
    YLYLog(@"UUID = %@", UUID);
    USERDEFAULTS_SET([NSString checkNullString:UUID], CONSTANT_USERDEFAULTS_LOCALUUID);
}

- (void)adaptSystem {
    if (@available (iOS 11, *)) {
        //tableView安全区适配问题
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        [UITableView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        //自动估算行高问题
        [UITableView appearance].estimatedRowHeight = 0;
        [UITableView appearance].estimatedSectionHeaderHeight = 0;
        [UITableView appearance].estimatedSectionFooterHeight = 0;
        //webView下移
        [UIWebView appearance].scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

@end
