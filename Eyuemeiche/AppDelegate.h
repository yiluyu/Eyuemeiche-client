//
//  AppDelegate.h
//  Eyuemeiche
//
//  Created by yu on 06/11/2017.
//  Copyright © 2017 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, readwrite, strong)UINavigationController *mainNavi;//主流程navi
@property (nonatomic, readwrite, strong)UINavigationController *loginNavi;//注册流程navi


@end

