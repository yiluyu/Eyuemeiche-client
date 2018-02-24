//
//  AppDelegate.m
//  Eyuemeiche
//
//  Created by yu on 06/11/2017.
//  Copyright © 2017 yu. All rights reserved.
//

#import "AppDelegate.h"

//vendor
#import <AFNetworking.h>
#import <AFNetworkReachabilityManager.h>
#import <MAMapKit/MAMapKit.h>

//root
#import "BootUnit.h"
#import "YLYRootTabbarController.h"
#import "YLYRootNavigationController.h"

//ViewControllers
#import "MainViewController.h"
#import "LoginViewController.h"

//data
#import "UserManager.h"

@interface AppDelegate ()

@property (nonatomic, readwrite, strong)BootUnit *bootUnit;//基础配置

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /*
     基础配置
     */
    self.bootUnit = [BootUnit shareUnit];
    
    
    //window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = _bootUnit.tabbarController;
    
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










@end
