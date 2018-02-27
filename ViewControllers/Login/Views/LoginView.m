//
//  LoginView.m
//  Eyuemeiche
//
//  Created by yu on 09/02/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "LoginView.h"
#import "LoginConfig.h"

@interface LoginView () <UITextFieldDelegate>

@property (nonatomic, readwrite, strong)NSString *stepStatus;

@property (nonatomic, readwrite, strong)UIImageView *logoImage;//logo

@property (nonatomic, readwrite, strong)YLYRootView *backView;//背景色

//第一步模块
@property (nonatomic, readwrite, strong)UIImageView *phoneicon;//图标
@property (nonatomic, readwrite, strong)YLYRootView *phoneBack;//输入背景
@property (nonatomic, readwrite, strong)UITextField *phoneTextField;//phone输入
@property (nonatomic, readwrite, strong)YLYRootButton *cannotLogin;//无法登陆
@property (nonatomic, readwrite, strong)YLYRootButton *getCodeBtn;//获取验证码按钮

//第二步模块
@property (nonatomic, readwrite, strong)YLYRootLabel *phoneLabel;//手机号展示
@property (nonatomic, readwrite, strong)UIImageView *codeicon;//图标
@property (nonatomic, readwrite, strong)UITextField *codeTextField;//code输入
@property (nonatomic, readwrite, strong)YLYRootButton *changePhoneBtn;//重新输入手机号
@property (nonatomic, readwrite, strong)YLYRootButton *loginBtn;//登陆


//计时器
@property (nonatomic, readwrite, assign)BOOL isSendingCode;//发送code中
@property (nonatomic, readwrite, strong)NSTimer *sendingTimer;//发送code的计时器

@end

@implementation LoginView

- (void)drawRect:(CGRect)rect {
    [self loadFirstStepView];
    [self loadSecondStepView];
}

- (void)loadFirstStepView {
    self.backgroundColor = COLOR_CLEAR;
    
    self.backView = [[YLYRootView alloc] init];
    _backView.backgroundColor = COLOR_WHITE;
    [self addSubview:_backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    
    //logo
    _logoImage = [[UIImageView alloc] init];
    _logoImage.backgroundColor = COLOR_GREEN;
    _logoImage.image = [UIImage imageNamed:@"loginLogo"];
    [_backView addSubview:_logoImage];
    [_logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(YLY6Width(212), YLY6Width(64)));
        make.left.mas_equalTo(_backView).with.offset(YLY6Width(268));
        make.top.mas_equalTo(_backView).with.offset(YLY6Width(170));
    }];
    
    
    //iphoneInput
    _phoneBack = [[YLYRootView alloc] init];
    _phoneBack.backgroundColor = COLOR_GRAY;
    [_backView addSubview:_phoneBack];
    [_phoneBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(YLY6Width(56));
        make.size.mas_equalTo(CGSizeMake(YLY6Width(630), YLY6Width(126)));
        make.top.mas_equalTo(YLY6Width(374));
    }];
    
    
    //phoneicon
    _phoneicon = [[UIImageView alloc] init];
    _phoneicon.backgroundColor = COLOR_YELLOW;
    _phoneicon.image = [UIImage imageNamed:@"phonecion"];
    [_backView addSubview:_phoneicon];
    [_phoneicon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(YLY6Width(100));
        make.size.mas_equalTo(CGSizeMake(YLY6Width(28), YLY6Width(28)));
        make.top.mas_equalTo(YLY6Width(422));
    }];
    _phoneicon.alpha = 1.0f;
    
    
    //phonetext
    _phoneTextField = [[UITextField alloc] init];
    _phoneTextField.backgroundColor = COLOR_GRAY;
    _phoneTextField.textAlignment = NSTextAlignmentLeft;
    _phoneTextField.placeholder = @"请输入手机号";
    _phoneTextField.font = CONSTANT_FONT_SMALL;
    _phoneTextField.textColor = CONSTANT_TEXT_COLOR_DESCRIPTION;
    [_phoneTextField becomeFirstResponder];
    _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    _phoneTextField.delegate = self;
    [_backView addSubview:_phoneTextField];
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(YLY6Width(164));
        make.size.mas_equalTo(CGSizeMake(YLY6Width(500), YLY6Width(126)));
        make.top.mas_equalTo(YLY6Width(374));
    }];
    _phoneTextField.alpha = 1.0f;
    
    [_phoneTextField addTarget:self
                        action:@selector(textChange:)
              forControlEvents:UIControlEventEditingChanged];
    
    
    //无法登陆
    _cannotLogin = [YLYRootButton buttonWithType:UIButtonTypeCustom];
    _cannotLogin.backgroundColor = COLOR_CLEAR;
    _cannotLogin.titleLabel.font = CONSTANT_FONT_SMALL;
    [_cannotLogin setTitle:@"无法登陆?" forState:UIControlStateNormal];
    [_cannotLogin addTarget:self
                     action:@selector(cannotLoginSend)
           forControlEvents:UIControlEventTouchUpInside];
    [_cannotLogin setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_backView addSubview:_cannotLogin];
    [_cannotLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(YLY6Width(540));
        make.size.mas_equalTo(CGSizeMake(YLY6Width(138), YLY6Width(33)));
        make.top.mas_equalTo(YLY6Width(515));
    }];
    _cannotLogin.alpha = 1.0f;
    
    
    //获取验证码按钮
    _getCodeBtn = [YLYRootButton buttonWithType:UIButtonTypeCustom];
    [_getCodeBtn setTitleColor:COLOR_WHITE forState:UIControlStateNormal];
    [_getCodeBtn addTarget:self
                    action:@selector(getCodeSend)
          forControlEvents:UIControlEventTouchUpInside];
    _getCodeBtn.layer.masksToBounds = YES;
    _getCodeBtn.titleLabel.font = YLY6Font(36);
    [_backView addSubview:_getCodeBtn];
    [_getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(YLY6Width(630), YLY6Width(98)));
        make.left.mas_equalTo(YLY6Width(56));
        make.top.mas_equalTo(YLY6Width(570));
    }];
    _getCodeBtn.alpha = 1.0f;
    
    
    [self initState];
    
    [self refreshSendCodeState];
    
    //在主线程中创建timer
    _sendingTimer = [[NSTimer alloc] initWithFireDate:[NSDate distantFuture]
                                             interval:1
                                               target:self
                                             selector:@selector(refreshTimer)
                                             userInfo:nil
                                              repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_sendingTimer forMode:NSRunLoopCommonModes];
}


- (void)loadSecondStepView {
    //codeicon
    self.codeicon = [[UIImageView alloc] init];
    _codeicon.backgroundColor = COLOR_RED;
    _codeicon.image = [UIImage imageNamed:@"codeicon"];
    [_backView addSubview:_codeicon];
    [_codeicon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(YLY6Width(100));
        make.size.mas_equalTo(CGSizeMake(YLY6Width(28), YLY6Width(28)));
        make.top.mas_equalTo(YLY6Width(442+100));
    }];
    _codeicon.alpha = 0.0f;
    
    //phoneLabel
    self.phoneLabel = [[YLYRootLabel alloc] init];
    _phoneLabel.textColor = COLOR_WHITE;
    _phoneLabel.font = CONSTANT_FONT_SMALL;
    _phoneLabel.backgroundColor = COLOR_BLUE;
    [_backView addSubview:_phoneLabel];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(YLY6Width(56));
        make.size.mas_equalTo(CGSizeMake(YLY6Width(630), YLY6Width(46)));
        make.top.mas_equalTo(YLY6Width(328+100));
    }];
    _phoneLabel.alpha = 0.0f;
    
    //codetext
    self.codeTextField = [[UITextField alloc] init];
    _codeTextField.backgroundColor = COLOR_GRAY;
    _codeTextField.textAlignment = NSTextAlignmentLeft;
    _codeTextField.placeholder = @"请输入验证码";
    _codeTextField.font = CONSTANT_FONT_SMALL;
    _codeTextField.textColor = CONSTANT_TEXT_COLOR_DESCRIPTION;
    [_codeTextField becomeFirstResponder];
    _codeTextField.keyboardType = UIKeyboardTypePhonePad;
    _codeTextField.delegate = self;
    [_backView addSubview:_codeTextField];
    [_codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(YLY6Width(164));
        make.size.mas_equalTo(CGSizeMake(YLY6Width(500), YLY6Width(126)));
        make.top.mas_equalTo(YLY6Width(394+100));
    }];
    
    [_codeTextField addTarget:self
                        action:@selector(textChange:)
              forControlEvents:UIControlEventEditingChanged];
    _codeTextField.alpha = 0.0f;
    
    //更换手机号
    self.changePhoneBtn = [YLYRootButton buttonWithType:UIButtonTypeCustom];
    _changePhoneBtn.backgroundColor = COLOR_CLEAR;
    _changePhoneBtn.titleLabel.font = CONSTANT_FONT_SMALL;
    [_changePhoneBtn setTitle:@"重新输入手机号" forState:UIControlStateNormal];
    [_changePhoneBtn addTarget:self
                     action:@selector(changePhonePress)
           forControlEvents:UIControlEventTouchUpInside];
    [_changePhoneBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_backView addSubview:_changePhoneBtn];
    [_changePhoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(YLY6Width(488));
        make.size.mas_equalTo(CGSizeMake(YLY6Width(202), YLY6Width(33)));
        make.top.mas_equalTo(YLY6Width(556+100));
    }];
    _changePhoneBtn.alpha = 0.0f;
    
    //获取验证码按钮
    self.loginBtn = [YLYRootButton buttonWithType:UIButtonTypeCustom];
    [_loginBtn setTitleColor:COLOR_WHITE forState:UIControlStateNormal];
    _loginBtn.backgroundColor = COLOR_GREEN;
    [_loginBtn addTarget:self
                  action:@selector(loginSend)
        forControlEvents:UIControlEventTouchUpInside];
    _loginBtn.layer.masksToBounds = YES;
    [_loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    _loginBtn.titleLabel.font = YLY6Font(36);
    [_backView addSubview:_loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(YLY6Width(630), YLY6Width(98)));
        make.left.mas_equalTo(YLY6Width(56));
        make.top.mas_equalTo(YLY6Width(669+100));
    }];
    _loginBtn.alpha = 0.0f;
    
}


#pragma -mark 初始化
/* 状态初始化 */
- (void)initState {
    //验证码
    _isSendingCode = NO;
    //步骤
    self.stepStatus = @"1";
    
}


/* 状态修改 */
//验证码按钮状态以及定时器
- (void)refreshSendCodeState {
    if (_isSendingCode == YES) {
        _getCodeBtn.backgroundColor = COLOR_GRAY;
    } else {
        _getCodeBtn.backgroundColor = COLOR_GREEN;
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    
}



//修改手机号
- (void)changePhonePress {
    YLYLog(@"修改手机号");
    //返回第一步
    [self alternateStep:@"1"];
}

#pragma -mark block回调
//无法登陆
- (void)cannotLoginSend {
    if (self.clickBtnCannotLoginBlock) {
        self.clickBtnCannotLoginBlock(self);
    }
}
//登陆
- (void)loginSend {
    if ([YLYRegular checkNumber:self.codeTextField.text] == NO || self.codeTextField.text.length < 6) {
        [YLYHelper showHudViewWithString:@"验证码格式不对"];
        if (_codeTextField.isFirstResponder == NO) {
            [_codeTextField becomeFirstResponder];
        }
        return;
    }
    
    if (self.clickBtnLoginBlock) {
        self.clickBtnLoginBlock(self);
    }
}

//获取验证码
- (void)getCodeSend {
    //判断是否可以触发按钮
    if (_isSendingCode == YES) {
        return;
    }
    if ([YLYRegular checkMobilePhone:self.phoneTextField.text] == NO) {
        [YLYHelper showHudViewWithString:@"请输入正确的手机号!"];
        if (_phoneTextField.isFirstResponder == NO) {
            [_phoneTextField becomeFirstResponder];
        }
        return;
    }

    
    if (self.clickBtnGetCodeBlock) {
        self.clickBtnGetCodeBlock(self);
    }
}


//定时器刷新
static int maxTime = CONSTANT_TIME_GETCODE;
- (void)refreshTimer {
    if (_isSendingCode == YES) {
        _getCodeBtn.backgroundColor = [UIColor grayColor];
        
        if (maxTime > 1) {
            maxTime --;
            [_getCodeBtn setTitle:[NSString stringWithFormat:@"获取验证码(%d)", maxTime] forState:UIControlStateNormal];
        } else {
            _isSendingCode = NO;
            [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            
            maxTime = CONSTANT_TIME_GETCODE;
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


#pragma -mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.phoneTextField) {
        if (string.length == 0) {
            return YES;
        }
        
        //如果选中一堆进行替换, 超出长度则不给替换
        NSInteger existLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existLength - selectedLength + replaceLength > 11) {
            return NO;
        }
    }
    if (textField == self.codeTextField) {
        if (string.length == 0) {
            return YES;
        }
        
        //如果选中一堆进行替换, 超出长度则不给替换
        NSInteger existLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existLength - selectedLength + replaceLength > 6) {
            return NO;
        }
    }
    return YES;
}

- (void)textChange:(UITextField *)textField {
    if (textField == self.phoneTextField) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
    if (textField == self.codeTextField) {
        if (textField.text.length > 6) {
            textField.text = [textField.text substringToIndex:6];
        }
    }
}

#pragma -mark 步骤切换
- (void)alternateStep:(NSString *)step {
    SELF_WEAK();
    if ([step integerValue] == 1) {
        self.stepStatus = @"1";
        
        //从上往下推
        //block2
        [weakSelf.codeicon mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(YLY6Width(442+100));
        }];
        [weakSelf.phoneLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(YLY6Width(328+100));
        }];
        [weakSelf.codeTextField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(YLY6Width(394+100));
        }];
        [weakSelf.changePhoneBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(YLY6Width(556+100));
        }];
        [weakSelf.loginBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(YLY6Width(669+100));
        }];
        
        //block1
        [weakSelf.phoneicon mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(YLY6Width(422));
        }];
        [weakSelf.phoneTextField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(YLY6Width(374));
        }];
        [weakSelf.cannotLogin mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(YLY6Width(515));
        }];
        [weakSelf.getCodeBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(YLY6Width(570));
        }];
        [weakSelf.phoneBack mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(YLY6Width(374));
        }];
        
        
        [UIView animateWithDuration:CONSTANT_TIME_ANIMATION_LONG animations:^{
            [weakSelf layoutIfNeeded];
        }];
        [UIView animateWithDuration:CONSTANT_TIME_ANIMATION_SHORT animations:^{
            weakSelf.phoneLabel.alpha = 0.0f;
            weakSelf.codeicon.alpha = 0.0f;
            weakSelf.codeTextField.alpha = 0.0f;
            weakSelf.changePhoneBtn.alpha = 0.0f;
            weakSelf.loginBtn.alpha = 0.0f;
            
            weakSelf.phoneicon.alpha = 1.0f;
            weakSelf.phoneTextField.alpha = 1.0f;
            weakSelf.cannotLogin.alpha = 1.0f;
            weakSelf.getCodeBtn.alpha = 1.0f;
        }];
    }
    
    if ([step integerValue] == 2) {
        self.stepStatus = @"2";
        
        //可以触发
        _isSendingCode = YES;
        [_sendingTimer setFireDate:[NSDate date]];
        
        //手机号
        _phoneLabel.text = [NSString stringWithFormat:@"您的手机号为: %@", _phoneTextField.text];
        
        
        
        //从下往上顶
        //block2
        [weakSelf.codeicon mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(YLY6Width(442));
        }];
        [weakSelf.phoneLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(YLY6Width(328));
        }];
        [weakSelf.codeTextField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(YLY6Width(394));
        }];
        [weakSelf.changePhoneBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(YLY6Width(556));
        }];
        [weakSelf.loginBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(YLY6Width(669));
        }];
        
        //block1
        [weakSelf.phoneicon mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(YLY6Width(422-100));
        }];
        [weakSelf.phoneTextField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(YLY6Width(374-100));
        }];
        [weakSelf.cannotLogin mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(YLY6Width(515-100));
        }];
        [weakSelf.getCodeBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(YLY6Width(570-100));
        }];
        [weakSelf.phoneBack mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(YLY6Width(394));
        }];
        
        [UIView animateWithDuration:CONSTANT_TIME_ANIMATION_LONG animations:^{
            [weakSelf layoutIfNeeded];
        }];
        [UIView animateWithDuration:CONSTANT_TIME_ANIMATION_SHORT animations:^{
            weakSelf.phoneLabel.alpha = 1.0f;
            weakSelf.codeicon.alpha = 1.0f;
            weakSelf.codeTextField.alpha = 1.0f;
            weakSelf.changePhoneBtn.alpha = 1.0f;
            weakSelf.loginBtn.alpha = 1.0f;
            
            weakSelf.phoneicon.alpha = 0.0f;
            weakSelf.phoneTextField.alpha = 0.0f;
            weakSelf.cannotLogin.alpha = 0.0f;
            weakSelf.getCodeBtn.alpha = 0.0f;
        }];
    }
}




@end
