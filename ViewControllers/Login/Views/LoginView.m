//
//  LoginView.m
//  Eyuemeiche
//
//  Created by yu on 09/02/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "LoginView.h"
#import "YLYBaseViewHeader.h"
#import "YLYDefine.h"

@interface LoginView () <UITextFieldDelegate>

//! 当前步骤状态
@property (nonatomic, readwrite, strong)NSString *stepStatus;
//! logo
@property (nonatomic, readwrite, strong)UIImageView *logoImage;
//! 背景色
@property (nonatomic, readwrite, strong)YLYRootView *backView;

//第一步模块
//! 图标
@property (nonatomic, readwrite, strong)UIImageView *phoneicon;
//! 输入背景
@property (nonatomic, readwrite, strong)YLYRootView *phoneBack;
//! phone输入
@property (nonatomic, readwrite, strong)YLYRootTextField *phoneTextField;
//! 无法登陆
@property (nonatomic, readwrite, strong)YLYRootButton *cannotLogin;
//! 获取验证码按钮
@property (nonatomic, readwrite, strong)YLYRootButton *getCodeBtn;

//第二步模块
//! 手机号展示
@property (nonatomic, readwrite, strong)YLYRootLabel *phoneLabel;
//! 图标
@property (nonatomic, readwrite, strong)UIImageView *codeicon;
//! code输入
@property (nonatomic, readwrite, strong)YLYRootTextField *codeTextField;
//! 重新输入手机号
@property (nonatomic, readwrite, strong)YLYRootButton *changePhoneBtn;
//! 登陆
@property (nonatomic, readwrite, strong)YLYRootButton *loginBtn;


//计时器
//! 发送code中
@property (nonatomic, readwrite, assign)BOOL isSendingCode;
//! 发送code的计时器
@property (nonatomic, readwrite, strong)NSTimer *sendingTimer;

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
    self.logoImage = [[UIImageView alloc] init];
    _logoImage.backgroundColor = COLOR_GREEN;
    _logoImage.image = [UIImage imageNamed:@"none"];
    [_backView addSubview:_logoImage];
    [_logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(FIT(107), FIT(107)));
        make.centerX.mas_equalTo(_backView);
        make.top.mas_equalTo(FIT(52)+SAFETY_AREA_HEIGHT);
    }];
    
    
    //iphoneInput
    self.phoneBack = [[YLYRootView alloc] init];
    _phoneBack.backgroundColor = [UIColor colorWithHexString:@"#FBFAFF"];
    [_backView addSubview:_phoneBack];
    [_phoneBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(30));
        make.height.mas_equalTo(FIT(64));
        make.right.mas_equalTo(FIT(-30));
        make.top.mas_equalTo(FIT(187)+SAFETY_AREA_HEIGHT);
    }];
    
    
    //phoneicon
    self.phoneicon = [[UIImageView alloc] init];
    _phoneicon.backgroundColor = COLOR_YELLOW;
    _phoneicon.image = [UIImage imageNamed:@"none"];
    [_backView addSubview:_phoneicon];
    [_phoneicon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(52));
        make.size.mas_equalTo(CGSizeMake(FIT(13), FIT(13)));
        make.top.mas_equalTo(FIT(212)+SAFETY_AREA_HEIGHT);
    }];
    _phoneicon.alpha = 1.0f;
    
    
    //phonetext
    self.phoneTextField = [[YLYRootTextField alloc] init];
    _phoneTextField.backgroundColor = COLOR_CLEAR;
    _phoneTextField.textAlignment = NSTextAlignmentLeft;
    _phoneTextField.placeholder = @"请输入手机号";
    _phoneTextField.font = CONSTANT_FONT_SMALL;
    _phoneTextField.textColor = [UIColor colorWithHexString:@"#5F5D70"];
    [_phoneTextField becomeFirstResponder];
    _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    _phoneTextField.delegate = self;
    [_backView addSubview:_phoneTextField];
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(83));
        make.right.mas_equalTo(FIT(-30));
        make.top.mas_equalTo(FIT(187)+SAFETY_AREA_HEIGHT);
        make.height.mas_equalTo(FIT(64));
    }];
    _phoneTextField.alpha = 1.0f;
    
    [_phoneTextField addTarget:self
                        action:@selector(textChange:)
              forControlEvents:UIControlEventEditingChanged];
    
    
    //无法登陆
    self.cannotLogin = [YLYRootButton buttonWithType:UIButtonTypeCustom];
    _cannotLogin.backgroundColor = COLOR_CLEAR;
    _cannotLogin.titleLabel.font = CONSTANT_FONT_SMALL;
    [_cannotLogin setTitle:@"无法登陆?" forState:UIControlStateNormal];
    [_cannotLogin addTarget:self
                     action:@selector(cannotLoginSend)
           forControlEvents:UIControlEventTouchUpInside];
    [_cannotLogin setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_backView addSubview:_cannotLogin];
    [_cannotLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(YLY6Width(-30));
        make.size.mas_equalTo(CGSizeMake(YLY6Width(72), YLY6Width(17)));
        make.top.mas_equalTo(FIT(256)+SAFETY_AREA_HEIGHT);
    }];
    _cannotLogin.alpha = 1.0f;
    
    
    //获取验证码按钮
    self.getCodeBtn = [YLYRootButton buttonWithType:UIButtonTypeCustom];
    [_getCodeBtn setTitleColor:COLOR_WHITE forState:UIControlStateNormal];
    [_getCodeBtn addTarget:self
                    action:@selector(getCodeSend)
          forControlEvents:UIControlEventTouchUpInside];
    _getCodeBtn.layer.masksToBounds = YES;
    _getCodeBtn.layer.cornerRadius = FIT(3.0f);
    _getCodeBtn.titleLabel.font = CONSTANT_FONT_BIG;
    [_backView addSubview:_getCodeBtn];
    [_getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(FIT(48));
        make.left.mas_equalTo(FIT(27));
        make.right.mas_equalTo(FIT(-27));
        make.top.mas_equalTo(FIT(285)+SAFETY_AREA_HEIGHT);
    }];
    _getCodeBtn.alpha = 1.0f;
    
    
    [self initState];
    
    [self refreshSendCodeState];
    
    //在主线程中创建timer
    self.sendingTimer = [[NSTimer alloc] initWithFireDate:[NSDate distantFuture]
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
    _codeicon.image = [UIImage imageNamed:@"none"];
    [_backView addSubview:_codeicon];
    [_codeicon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(53));
        make.size.mas_equalTo(CGSizeMake(FIT(11), FIT(14)));
        make.top.mas_equalTo(FIT(221+100)+SAFETY_AREA_HEIGHT);
    }];
    _codeicon.alpha = 0.0f;
    
    //phoneLabel
    self.phoneLabel = [YLYRootLabel createLabelText:@""
                                               font:CONSTANT_FONT_SMALL
                                              color:[UIColor colorWithHexString:@"#5F5D70"]];
    _phoneLabel.backgroundColor = COLOR_CLEAR;
    [_backView addSubview:_phoneLabel];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(30));
        make.height.mas_equalTo(FIT(17));
        make.top.mas_equalTo(FIT(165+100)+SAFETY_AREA_HEIGHT);
    }];
    _phoneLabel.alpha = 0.0f;
    
    //codetext
    self.codeTextField = [[YLYRootTextField alloc] init];
    _codeTextField.backgroundColor = [UIColor colorWithHexString:@"#FBFAFF"];
    _codeTextField.textAlignment = NSTextAlignmentLeft;
    _codeTextField.placeholder = @"请输入验证码";
    _codeTextField.font = CONSTANT_FONT_SMALL;
    _codeTextField.textColor = [UIColor colorWithHexString:@"#5F5D70"];
    _codeTextField.keyboardType = UIKeyboardTypePhonePad;
    _codeTextField.delegate = self;
    [_backView addSubview:_codeTextField];
    [_codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(83));
        make.size.mas_equalTo(CGSizeMake(FIT(262), FIT(64)));
        make.top.mas_equalTo(FIT(197+100)+SAFETY_AREA_HEIGHT);
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
        make.right.mas_equalTo(FIT(-30));
        make.size.mas_equalTo(CGSizeMake(FIT(100), FIT(17)));
        make.top.mas_equalTo(FIT(276+100)+SAFETY_AREA_HEIGHT);
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
    _loginBtn.titleLabel.font = CONSTANT_FONT_BIG;
    [_backView addSubview:_loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(27));
        make.right.mas_equalTo(FIT(-27));
        make.height.mas_equalTo(FIT(48));
        make.top.mas_equalTo(FIT(334+100)+SAFETY_AREA_HEIGHT);
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
    if ([YLYRegular checkNumber:self.codeTextField.text] == NO || self.codeTextField.text.length < 4) {
        [[YLYHelper shareHelper] showHudViewWithString:@"验证码格式错误!"];
        if (_codeTextField.isFirstResponder == NO) {
            [_codeTextField becomeFirstResponder];
        }
        return;
    }
    
    if (self.clickBtnLoginBlock) {
        NSDictionary *sendDict = @{@"mobile":_phoneTextField.text, @"validate":_codeTextField.text};
        self.clickBtnLoginBlock(sendDict);
    }
}

//获取验证码
- (void)getCodeSend {
    //判断是否可以触发按钮
    if (_isSendingCode == YES) {
        return;
    }
    if ([YLYRegular checkMobilePhone:self.phoneTextField.text] == NO) {
        [[YLYHelper shareHelper] showHudViewWithString:@"请输入正确的手机号!"];
        if (_phoneTextField.isFirstResponder == NO) {
            [_phoneTextField becomeFirstResponder];
        }
        return;
    }

    if (self.clickBtnGetCodeBlock) {
        NSDictionary *sendDict = @{@"mobile":_phoneTextField.text};
        self.clickBtnGetCodeBlock(sendDict);
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
        if (existLength - selectedLength + replaceLength > 4) {
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
        if (textField.text.length > 4) {
            textField.text = [textField.text substringToIndex:4];
        }
    }
}

#pragma -mark 步骤切换
- (void)alternateStep:(NSString *)step {
    SELF_WEAK();
    if ([step integerValue] == 1) {
        self.stepStatus = @"1";
        if (_phoneTextField.isFirstResponder == NO) {
            [_codeTextField resignFirstResponder];
            [_phoneTextField becomeFirstResponder];
        }
        
        //从上往下推
        //block2
        [weakSelf.codeicon mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(FIT(221+100)+SAFETY_AREA_HEIGHT);
        }];
        [weakSelf.phoneLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(FIT(165+100)+SAFETY_AREA_HEIGHT);
        }];
        [weakSelf.codeTextField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(FIT(197+100)+SAFETY_AREA_HEIGHT);
        }];
        [weakSelf.changePhoneBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(FIT(276+100)+SAFETY_AREA_HEIGHT);
        }];
        [weakSelf.loginBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(FIT(334+100)+SAFETY_AREA_HEIGHT);
        }];
        
        //block1
        [weakSelf.phoneicon mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(FIT(212)+SAFETY_AREA_HEIGHT);
        }];
        [weakSelf.phoneTextField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(FIT(187)+SAFETY_AREA_HEIGHT);
        }];
        [weakSelf.cannotLogin mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(FIT(256)+SAFETY_AREA_HEIGHT);
        }];
        [weakSelf.getCodeBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(FIT(285)+SAFETY_AREA_HEIGHT);
        }];
        [weakSelf.phoneBack mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(FIT(187)+SAFETY_AREA_HEIGHT);
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
        if (_codeTextField.isFirstResponder == NO) {
            [_phoneTextField resignFirstResponder];
            [_codeTextField becomeFirstResponder];
        }
        
        //可以触发
        _isSendingCode = YES;
        [_sendingTimer setFireDate:[NSDate date]];
        
        //手机号
        _phoneLabel.text = [NSString stringWithFormat:@"您的手机号为: %@", _phoneTextField.text];
        
        //从下往上顶
        //block2
        [weakSelf.codeicon mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(FIT(221)+SAFETY_AREA_HEIGHT);
        }];
        [weakSelf.phoneLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(FIT(165)+SAFETY_AREA_HEIGHT);
        }];
        [weakSelf.codeTextField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(FIT(197)+SAFETY_AREA_HEIGHT);
        }];
        [weakSelf.changePhoneBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(FIT(276)+SAFETY_AREA_HEIGHT);
        }];
        [weakSelf.loginBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(FIT(334)+SAFETY_AREA_HEIGHT);
        }];
        
        //block1
        [weakSelf.phoneicon mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(YLY6Width(212-100)+SAFETY_AREA_HEIGHT);
        }];
        [weakSelf.phoneTextField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(YLY6Width(187-100)+SAFETY_AREA_HEIGHT);
        }];
        [weakSelf.cannotLogin mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(YLY6Width(256-100)+SAFETY_AREA_HEIGHT);
        }];
        [weakSelf.getCodeBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(YLY6Width(285-100)+SAFETY_AREA_HEIGHT);
        }];
        [weakSelf.phoneBack mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(YLY6Width(187)+SAFETY_AREA_HEIGHT);
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

- (void)dealloc {
    self.codeTextField = nil;
    self.phoneTextField = nil;
}

@end
