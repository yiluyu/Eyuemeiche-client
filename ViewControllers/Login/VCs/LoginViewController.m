//
//  LoginViewController.m
//  EDongMeiCheDemo
//
//  Created by yu on 27/10/2017.
//  Copyright © 2017 yu. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic, readwrite, strong)YLYRootView *backView;//底色图

@property (nonatomic, readwrite, strong)LoginView *loginView;//登陆控制view




@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    };
    
    //信息
    self.loginView = [[LoginView alloc] init];
    [_backView addSubview:_loginView];
    [_loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    
    //点击获取code
    
    
    
    //点击登陆
    
    
    //点击无法登陆
    
    
    
//    UIView *a = [[UIView alloc] init];
//    a.backgroundColor = COLOR_BLACK;
//    [self.view addSubview:a];
//
//    [a mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(YLY6Width(510));
//        make.right.mas_equalTo(-YLY6Width(20));
//        make.bottom.mas_equalTo(-YLY6Width(20));
//        make.height.mas_equalTo(YLY6Width(70));
//    }];
//
//    YLYLog(@"%@", a);
}


#pragma -mark 事件处理
/* 事件 */

//收回键盘时view的变化
- (void)closeKeyboard:(CGFloat)durationTime {
    YLYLog(@"收键盘其他view变化");
}
//键盘弹起时其他view变化
- (void)openKeyboard:(CGFloat)keyboardHeight time:(CGFloat)durationTime {
    YLYLog(@"弹键盘其他view变化");
}

//注册通知
- (void)registerNotification {
    SELF_WEAK();
    //键盘
    //键盘即将显示
    [YLYHelper registerNotificationName:UIKeyboardWillShowNotification
                               observer:self
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
                                      
                                      YLYLog(@"keyboardHeight = %f, time = %f", height, duration);
                                      
                                      //动画
                                      [weakSelf openKeyboard:height time:duration];
                                  }
     ];

    //键盘即将收起
    [YLYHelper registerNotificationName:UIKeyboardWillHideNotification
                               observer:self
                                  event:^(NSNotification *noti) {
                                      //获取弹出动画时间
                                      NSDictionary *userInfo = [noti userInfo];
                                      NSValue *timeValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
                                      double duration = 0.0f;
                                      [timeValue getValue:&duration];
                                      
                                      YLYLog(@"time = %f", duration);
                                      
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




#pragma -mark UITextFieldDelegate
/* UITextFieldDelegate */
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [textField becomeFirstResponder];
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
    [self.loginView closeTimer];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
