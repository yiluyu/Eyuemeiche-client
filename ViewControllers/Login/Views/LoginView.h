//
//  LoginView.h
//  Eyuemeiche
//
//  Created by yu on 09/02/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "YLYRootView.h"
#import "YLYBaseViewHeader.h"

@class LoginView;

@interface LoginView : YLYRootView

/** 点击获取验证码事件 */
@property (nonatomic, readwrite, copy)void(^clickBtnGetCodeBlock)(NSDictionary *sendDict);
/** 点击登陆按钮事件处理 */
@property (nonatomic, readwrite, copy)void(^clickBtnLoginBlock)(NSDictionary *sendDict);
/** 无法登陆按钮事件 */
@property (nonatomic, readwrite, copy)void(^clickBtnCannotLoginBlock)(LoginView *sender);


//当前步骤
@property (nonatomic, readonly, strong)NSString *stepStatus;// 0为获取验证码  1为登陆

@property (nonatomic, readonly, strong)YLYRootTextField *phoneTextField;//phone输入
@property (nonatomic, readonly, strong)YLYRootTextField *codeTextField;//code输入

/** 跳转步骤 */
- (void)alternateStep:(NSString *)step;// @"1"获取验证码; @"2"登陆

/** 挂起定时器 */
- (void)suspendTimer;
/** 关闭定时器 */
- (void)closeTimer;
/** 继续定时器 */
- (void)continueTimer;

@end
