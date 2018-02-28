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
#define CONSTANT_FONT_DETAIL YLY6Font(24)
/** 小号字体 */
#define CONSTANT_FONT_SMALL YLY6Font(28)
/** 中号字体 */
#define CONSTANT_FONT_MEDIAL YLY6Font(30)
/** 大号字体 */
#define CONSTANT_FONT_BIG YLY6Font(36)

//字体颜色
/** 主体文字颜色 */
#define CONSTANT_TEXT_COLOR_MAIN COLOR_RGB(255, 255, 255, 1)
/** 辅助描述性文字淡色 */
#define CONSTANT_TEXT_COLOR_DESCRIPTION COLOR_RGB(215, 215, 215, 1)


/* 本地数据 */
/** 当前启动存储 userToken */
#define CONSTANT_USERDEFAULTS_LOCALUSERTOKEN @"localUserToken"
/** 当前启动存储 deviceToken */
#define CONSTANT_USERDEFAULTS_LOCALDEVICETOKEN @"localDeviceToken"

/* 验证码发送间隔 */
#ifndef YLYTest
#define CONSTANT_TIME_GETCODE 3
#else
#define CONSTANT_TIME_GETCODE 60
#endif




/* 通知name */
#define CONSTANT_NOTIFY_SKIPLOGIN @"CONSTANT_NOTIFY_SKIPLOGIN" //跳转登陆页面



/* 动画时间参数 */
/** 动画时间短 */
#define CONSTANT_TIME_ANIMATION_SHORT 0.3f
/** 动画时间长 */
#define CONSTANT_TIME_ANIMATION_LONG 0.6f


