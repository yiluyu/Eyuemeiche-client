//
//  LoginView.h
//  Eyuemeiche
//
//  Created by yu on 09/02/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "YLYRootView.h"

@class LoginView;

@interface LoginView : YLYRootView

/** 点击获取验证码事件 */
@property (nonatomic, readwrite, copy)void(^clickBtnGetCodeBlock)(LoginView *sender);
/** 点击发送按钮事件处理 */
@property (nonatomic, readwrite, copy)void(^clickBtnLoginBlock)(LoginView *sender);
/** 无法登陆按钮事件 */
@property (nonatomic, readwrite, copy)void(^clickBtnCannotLoginBlock)(LoginView *sender);


//当前步骤
@property (nonatomic, readonly, strong)NSString *stepStatus;// 0为获取验证码  1为登陆

@property (nonatomic, readwrite, strong)UITextField *phoneTextField;//phone输入


/** 挂起定时器 */
- (void)suspendTimer;
/** 关闭定时器 */
- (void)closeTimer;
/** 继续定时器 */
- (void)continueTimer;

@end
