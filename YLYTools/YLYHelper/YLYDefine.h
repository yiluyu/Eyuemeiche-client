//
//  YLYDefine.h
//  TestDemo
//
//  Created by yu on 31/08/2017.
//  Copyright © 2017 yu. All rights reserved.
//

#import "YLYHelper.h"
#import "YLYConstantDefine.h"
#import "YLYRegular.h"
#import "YLYConstantString.h"

/*
 该对象用定义宏
 */

/* debug总开关 */
#define YLYTest    //开发状态,注释掉则为发布状态

//#define YLYUIDemo 1   //纯 UI 展示模式

/* 自定义log输出,替换系统NSLog
 NSLog does 2 things:
 
 It writes log messages to the Apple System Logging (asl) facility. This allows log messages to show up in Console.app.
 It also checks to see if the application's stderr stream is going to a terminal (such as when the application is being run via Xcode). If so it writes the log message to stderr (so that it shows up in the Xcode console).
 To send a log message to the ASL facility, you basically open a client connection to the ASL daemon and send the message. BUT - each thread must use a separate client connection. So, to be thread safe, every time NSLog is called it opens a new asl client connection, sends the message, and then closes the connection.
 属于系统级别标准错误输出使用,属于高级封装。
 
 而fprintf()是c级别的函数,文件输出流。速度快很多。
 */
#ifndef YLYTest
#define YLYLog(FORMAT, ...)
#else
#define YLYLog(FORMAT, ...) fprintf(stderr, "[%s:%d行] %s\n", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
#endif


/* 屏幕适配 */
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
/// 获取当前屏幕尺寸与6屏幕适配比例
#define SCREEN_SCALE (SCREEN_WIDTH/375.0)
///下方安全区高度
#define SAFETY_AREA_HEIGHT (iPhoneX?34.0:0)
/// tabbar高度
#define TABBAR_HEIGHT 49.0
/// 状态栏高度
#define STATUSBAR_HEIGHT [UIApplication sharedApplication].statusBarFrame.size.height
/// 导航栏高度
#define NAVIGATIONBAR_HEIGHT 44.0
///iPhoneX安全高度
#define NAVI_FIT_HEIGHT NAVIGATIONBAR_HEIGHT+STATUSBAR_HEIGHT

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? ((CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size)) ||  (CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size))): NO)
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

//#define iPhone6P ((SCREEN_WIDTH == 414)?YES:NO)//414.000000, 736.000000
//#define iPhone6 ((SCREEN_WIDTH == 375)?YES:NO)//375.000000, 667.000000
//#define iPhone5 ((SCREEN_WIDTH == 320)?YES:NO)//320.000000, 568.000000
//#define iPhoneX ((SCREEN_WIDTH == 375) && (SCREEN_HEIGHT == 812)?YES:NO)//375.000000, 812.000000

//安全SafeArea间隙
//#define SafeAreaTopHeight iPhoneX?88:64
//#define SafeAreaBottomHeight (iPhoneX?34:0)
/// 以iPhone6屏幕为基准rect
#define YLY6Rect(x, y, width, height) [YLYHelper autoAdjustRect:CGRectMake(x, y, width, height)]

//基于6屏幕适配font
#define YLY6Font(a) [YLYHelper autoAdjustFont:a]

//基于6屏幕适配width
#define YLY6Width(w) [YLYHelper autoAdjustWidth:w]

//masonry中使用
#define FIT(w) YLY6Width(w)

/* 系统判断 */
#define SYSTEM_VERSION [[UIDevice currentDevice].systemVersion intValue]
/// iOS 10系统判断
#define iOS10 (SYSTEM_VERSION>=10)?YES:NO
/// iOS 11系统判断
#define iOS11 (SYSTEM_VERSION>=11)?YES:NO


/* 数据存储 */
///NSUserDefaults
#define USERDEFAULTS_GET(keyName) [[NSUserDefaults standardUserDefaults] objectForKey:keyName]
///设置 NSUserDefaults
#define USERDEFAULTS_SET(object, keyName) [[NSUserDefaults standardUserDefaults] setObject:object forKey:keyName]
#define USERDEFAULTS_SYNC() [[NSUserDefaults standardUserDefaults] synchronize]
///直接获取用户token
#define USERTOKEN USERDEFAULTS_GET(CONSTANT_USERDEFAULTS_ACCESSTOKEN)

/* 颜色 */
/// RGB设置颜色
#define COLOR_RGB(RED, GREEN, BLUE, ALPHA) [UIColor colorWithRed:RED/255.0 green:GREEN/255.0 blue:BLUE/255.0 alpha:ALPHA]
/// 16进制颜色
#define COLOR_HEX(a) [UIColor colorWithHexString:a]

#define COLOR_CLEAR [UIColor clearColor]
#define COLOR_RED [UIColor redColor]
#define COLOR_YELLOW [UIColor yellowColor]
#define COLOR_BLUE [UIColor blueColor]
#define COLOR_GREEN [UIColor greenColor]
#define COLOR_WHITE [UIColor whiteColor]
#define COLOR_BLACK [UIColor blackColor]
#define COLOR_GRAY [UIColor grayColor]

///主背景颜色
#define COLOR_VC_BG COLOR_HEX(@"#F6F6F6")

/// 获取weakSelf
#define SELF_WEAK() __weak typeof(&*self) weakSelf = self
/// 获取strongSelf
#define SELF_STRONG() __strong typeof(&*self) strongSelf = weakSelf

