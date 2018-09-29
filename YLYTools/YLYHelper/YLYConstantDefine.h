//
//  YLYConstantDefine.h
//  TestDemo
//
//  Created by yu on 06/09/2017.
//  Copyright © 2017 yu. All rights reserved.
//

/*
 该对象用定义固定字符串
 */
//颜色
/** 统一背景色 */
#define CONSTANT_BACKGROUND_COLOR COLOR_RGB(241, 241, 241, 1)
/** 分割线颜色 */
#define CONSTANT_LINE_COLOR COLOR_RGB(215, 215, 215, 1)

//字体
/** 超小描述字体 */
#define CONSTANT_FONT_DETAIL YLY6Font(12)
/** 小号字体 */
#define CONSTANT_FONT_SMALL YLY6Font(14)
/** 中号字体 */
#define CONSTANT_FONT_MEDIAL YLY6Font(15)
/** 大号字体 */
#define CONSTANT_FONT_BIG YLY6Font(18)

//字体颜色
/** 主体文字颜色 */
#define CONSTANT_TEXT_COLOR_MAIN COLOR_RGB(255, 255, 255, 1)
/** 辅助描述性文字淡色 */
#define CONSTANT_TEXT_COLOR_DESCRIPTION COLOR_RGB(215, 215, 215, 1)


/* 本地数据 */
///当前启动存储 access_token
#define CONSTANT_USERDEFAULTS_ACCESSTOKEN @"access_token"
///当前启动存储 推送 deviceToken
#define CONSTANT_USERDEFAULTS_LOCALDEVICETOKEN @"localDeviceToken"
///当前启动存储 UUID
#define CONSTANT_USERDEFAULTS_LOCALUUID @"localUUID"
///是否第一次启动
#define CONSTANT_USERDEFAULTS_APPFIRSTLAUNCH @"localFirstLaunchApp" //1:第一次启动, 0:非第一次启动

/* 验证码发送间隔 */
#ifndef YLYTest
#define CONSTANT_TIME_GETCODE 3
#else
#define CONSTANT_TIME_GETCODE 60
#endif




/* 通知name */
///跳转登陆页面
#define CONSTANT_NOTIFY_SKIPLOGIN @"CONSTANT_NOTIFY_SKIPLOGIN"



/* 动画时间参数 */
/** 动画时间短 */
#define CONSTANT_TIME_ANIMATION_SHORT 0.3f
/** 动画时间长 */
#define CONSTANT_TIME_ANIMATION_LONG 0.6f


