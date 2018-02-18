//
//  LoginView.m
//  Eyuemeiche
//
//  Created by yu on 09/02/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "LoginView.h"

@interface LoginView ()

@property (nonatomic, readwrite, strong)NSString *stepStatus;

@property (nonatomic, readwrite, strong)UIImageView *logoImage;//logo

//第一步模块
@property (nonatomic, readwrite, strong)UIImageView *phoneicon;//图标
@property (nonatomic, readwrite, strong)YLYRootView *phoneBack;//输入背景
@property (nonatomic, readwrite, strong)UIButton *cannotLogin;//无法登陆
@property (nonatomic, readwrite, strong)UIButton *getCodeBtn;//获取验证码按钮

//第二步模块



//计时器
@property (nonatomic, readwrite, assign)BOOL isSendingCode;//发送code中
@property (nonatomic, readwrite, strong)NSTimer *sendingTimer;//发送code的计时器

@end

@implementation LoginView



- (void)loadFirstStepView {
    self.backgroundColor = COLOR_CLEAR;
    
    UIView *backView = [[YLYRootView alloc] init];
    backView.backgroundColor = COLOR_CLEAR;
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    
    //logo
    _logoImage = [[UIImageView alloc] init];
    _logoImage.backgroundColor = [UIColor blueColor];
    _logoImage.image = [UIImage imageNamed:@"loginLogo"];
    _logoImage.frame = YLY6Rect(270, 170, 210, 66);
    [backView addSubview:_logoImage];
    [_logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(YLY6Width(270));
        make.top.mas_equalTo(YLY6Width(178));
        make.width.mas_equalTo(YLY6Width(212));
        
    }];
    
    
    //iphoneInput
    _phoneBack = [[YLYRootView alloc] init];
    _phoneBack.backgroundColor = [UIColor greenColor];
    [backView addSubview:_phoneBack];
    
    
    //phoneicon
    _phoneicon = [[UIImageView alloc] init];
    _phoneicon.backgroundColor = [UIColor yellowColor];
    _phoneicon.image = [UIImage imageNamed:@"phoneciom"];
    [backView addSubview:_phoneicon];
    
    
    //phonetext
    _phoneTextField = [[UITextField alloc] init];
    _phoneTextField.backgroundColor = [UIColor grayColor];
    _phoneTextField.textAlignment = NSTextAlignmentLeft;
    _phoneTextField.placeholder = @"请输入手机号";
    _phoneTextField.font = YLY6Font(28);
    _phoneTextField.textColor = [UIColor blackColor];
    [_phoneTextField becomeFirstResponder];
    _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    [backView addSubview:_phoneTextField];
    
    
    //无法登陆
    _cannotLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    _cannotLogin.backgroundColor = [UIColor clearColor];
    _cannotLogin.titleLabel.font = YLY6Font(26);
    [_cannotLogin setTitle:@"无法登陆?" forState:UIControlStateNormal];
    [_cannotLogin addTarget:self
                     action:@selector(cannotLoginSend)
           forControlEvents:UIControlEventTouchUpInside];
    [_cannotLogin setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [backView addSubview:_cannotLogin];
    
    
    //获取验证码按钮
    _getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _getCodeBtn.layer.cornerRadius = YLY6Width(3);
    [_getCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_getCodeBtn addTarget:self
                    action:@selector(getCodeSend)
          forControlEvents:UIControlEventTouchUpInside];
    _getCodeBtn.layer.masksToBounds = YES;
    _getCodeBtn.titleLabel.font = YLY6Font(36);
    [backView addSubview:_getCodeBtn];
    
    [self refreshSendCodeState];
    
    
    
    //在主线程中创建timer
    _sendingTimer = [[NSTimer alloc] initWithFireDate:[NSDate distantFuture]
                                             interval:1
                                               target:self
                                             selector:@selector(refreshTimer)
                                             userInfo:nil
                                              repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_sendingTimer forMode:NSRunLoopCommonModes];
    
    
    
    
    
    NSString *a = [NSString stringToMoneyFormat:@"0.00"];
    NSString *b = [NSString stringToMoneyFormat:@"0"];
    NSString *c = [NSString stringToMoneyFormat:@""];
    NSString *d = [NSString stringToMoneyFormat:@"1234567890.123"];
    NSString *e = [NSString stringToMoneyFormat:@"123456"];
    NSString *f = [NSString moneyToFloat:@"123,456,789.02"];
    NSString *g = [NSString moneyToFloat:@"123,456"];
    YLYLog(@"\na=%@\nb=%@\nc=%@\nd=%@\ne=%@\nf=%@\ng=%@",a, b, c, d, e, f, g);
    
}


#pragma -mark 初始化
/* 状态初始化 */
- (void)initFirstStepState {
    //验证码
    _isSendingCode = NO;
    //步骤
    self.stepStatus = @"0";
    
}


/* 状态修改 */
//验证码按钮状态以及定时器
- (void)refreshSendCodeState {
    if (_isSendingCode == YES) {
        _getCodeBtn.backgroundColor = [UIColor grayColor];
    } else {
        _getCodeBtn.backgroundColor = [UIColor greenColor];
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    
}






//无法登陆
- (void)cannotLoginSend {
    YLYLog(@"无法登陆");
    
    if (self.clickBtnCannotLoginBlock) {
        self.clickBtnCannotLoginBlock(self);
    }
}

//获取验证码
- (void)getCodeSend {
    _isSendingCode = YES;
    [_sendingTimer setFireDate:[NSDate date]];
    
    if (self.clickBtnGetCodeBlock) {
        self.clickBtnGetCodeBlock(self);
    }
}


//定时器刷新
static int maxTime = 60;
- (void)refreshTimer {
    if (_isSendingCode == YES) {
        _getCodeBtn.backgroundColor = [UIColor grayColor];
        
        if (maxTime > 1) {
            maxTime --;
            [_getCodeBtn setTitle:[NSString stringWithFormat:@"获取验证码(%d)", maxTime] forState:UIControlStateNormal];
        } else {
            _isSendingCode = NO;
            [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            
            maxTime = 60;
        }
        
        
    } else {
        _getCodeBtn.backgroundColor = [UIColor greenColor];
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_sendingTimer setFireDate:[NSDate distantFuture]];
    }
}


#pragma -mark 定时器
- (void)suspendTimer {
    [_sendingTimer setFireDate:[NSDate distantFuture]];
}
- (void)closeTimer {
    [_sendingTimer setFireDate:[NSDate distantFuture]];
    [_sendingTimer invalidate];
    _sendingTimer = nil;
}
- (void)continueTimer {
    //1秒之后继续定时器
    [_sendingTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:1]];
}


@end
