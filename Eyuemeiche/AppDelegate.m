//
//  AppDelegate.m
//  Eyuemeiche
//
//  Created by yu on 06/11/2017.
//  Copyright © 2017 yu. All rights reserved.
//

#import "AppDelegate.h"

//vendor
#import <Reachability/Reachability.h>

//root
#import "BootUnit.h"
#import "YLYRootTabbarController.h"

//ViewControllers
#import "MainViewController.h"
#import "LoginViewController.h"

//data
#import "UserManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //加载本地用户数据
    [UserManager shareInstanceUserInfo];
    //检查网络状态
    [self checkNetStatus];
    //检测是否登录失效
    
    
    
    //加载VC
    //主页
    MainViewController *mainVC = [[MainViewController alloc] init];
    
    //Navi
    self.mainNavi = [[UINavigationController alloc] initWithRootViewController:mainVC];
    _mainNavi.navigationBar.translucent = NO;
    _mainNavi.navigationBar.hidden = YES;
    
    //window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = self.mainNavi;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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







@end
