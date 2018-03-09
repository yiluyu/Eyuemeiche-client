//
//  LoginViewController.m
//  EDongMeiCheDemo
//
//  Created by yu on 27/10/2017.
//  Copyright © 2017 yu. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginConfig.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic, readwrite, strong)YLYRootView *backView;//底色图

@property (nonatomic, readwrite, strong)LoginView *loginView;//登陆控制view




@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = CONSTANT_BACKGROUND_COLOR;
    
    [self loadSubviews];
    
    
}

#pragma -mark 加载
/* 加载子视图 */
- (void)loadSubviews {
    //backview
    self.backView = [[YLYRootView alloc] init];
    _backView.backgroundColor = COLOR_RED;
    [self.view addSubview:_backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    SELF_WEAK();
    //点击背景
    _backView.touchBlock = ^(YLYRootView *sender) {
        YLYLog(@"点击背景图");
        if (weakSelf.loginView.phoneTextField.isFirstResponder == YES) {
            [weakSelf.loginView.phoneTextField resignFirstResponder];
        }
        if (weakSelf.loginView.codeTextField.isFirstResponder == YES) {
            [weakSelf.loginView.codeTextField resignFirstResponder];
        }
    };
    
    //信息
    self.loginView = [[LoginView alloc] init];
    [_backView addSubview:_loginView];
    [_loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    
    //点击获取code
    _loginView.clickBtnGetCodeBlock = ^(LoginView *sender) {
        YLYLog(@"发送验证码...");
        [sender alternateStep:@"2"];
    };
    
    //点击登陆
    __weak BootUnit *tempBoot = [BootUnit shareUnit];
    _loginView.clickBtnLoginBlock = ^(LoginView *sender) {
        YLYLog(@"登陆...");
        
        YLYLog(@"登陆成功");
        [sender.phoneTextField resignFirstResponder];
        [sender.codeTextField resignFirstResponder];
        [sender.phoneTextField endEditing:YES];
        [sender.codeTextField endEditing:YES];
        [tempBoot closeLoginVC];
    };
    
    //点击无法登陆
    _loginView.clickBtnCannotLoginBlock = ^(LoginView *sender) {
        YLYLog(@"无法登陆跳转...");
    };
    

}

#pragma -mark 通知
//收回键盘时view的变化
- (void)closeKeyboard:(CGFloat)durationTime {
    YLYLog(@"收键盘其他view变化");
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:durationTime];
    [_loginView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    [_backView layoutIfNeeded];
    [UIView commitAnimations];
}
//键盘弹起时其他view变化
- (void)openKeyboard:(CGFloat)keyboardHeight time:(CGFloat)durationTime {
    YLYLog(@"弹键盘其他view变化");
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:durationTime];
    [_loginView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(-100);
    }];
    [_backView layoutIfNeeded];
    [UIView commitAnimations];
}

//注册通知
- (void)registerNotification {
    SELF_WEAK();
    //键盘
    //键盘即将显示
    [YLYHelper registerNotificationName:UIKeyboardWillShowNotification
                                 object:nil
                                  event:^(NSNotification *noti) {
                                      //获取最终键盘高度
                                      NSDictionary *userInfo = [noti userInfo];
                                      NSValue *heightValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
                                      CGRect keyboardRect = [heightValue CGRectValue];
                                      CGFloat height = keyboardRect.size.height;
                                      
                                      //获取弹出动画时间
                                      NSValue *timeValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
                                      double duration = 0.0f;
                                      [timeValue getValue:&duration];
                                      //动画
                                      [weakSelf openKeyboard:height time:duration];
                                  }
     ];
    
    //键盘即将收起
    [YLYHelper registerNotificationName:UIKeyboardWillHideNotification
                                 object:nil
                                  event:^(NSNotification *noti) {
                                      //获取弹出动画时间
                                      NSDictionary *userInfo = [noti userInfo];
                                      NSValue *timeValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
                                      double duration = 0.0f;
                                      [timeValue getValue:&duration];
                                      //动画
                                      [weakSelf closeKeyboard:duration];
                                  }
     ];
    
}
//注销通知
- (void)cancelNotification {
    //键盘
    [YLYHelper removeNotificationName:UIKeyboardWillShowNotification observer:self];
    [YLYHelper removeNotificationName:UIKeyboardWillHideNotification observer:self];
}


#pragma -mark 网络
//获取验证码
- (void)sendCodeNetRequest {
    
}
//登陆
- (void)sendLoginNetRequest {
    
}






#pragma -mark vc机制
- (void)viewWillAppear:(BOOL)animated {
    //注册通知
    [self registerNotification];
}
- (void)viewWillDisappear:(BOOL)animated {
    //注销通知
    [self cancelNotification];
}


#pragma -mark 内存
/* 释放内存 */
- (void)dealloc {
    //关掉定时器
    [self.loginView closeTimer];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
