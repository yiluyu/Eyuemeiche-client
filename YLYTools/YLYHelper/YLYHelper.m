//
//  YLYHelper.m
//  TestDemo
//
//  Created by yu on 31/08/2017.
//  Copyright © 2017 yu. All rights reserved.
//

#import "YLYHelper.h"
#import "YLYDefine.h"
#import <MBProgressHUD.h>
#import "BootUnit.h"

@interface YLYHelper ()

@property (nonatomic, readwrite, strong)MBProgressHUD *textHud;
@property (nonatomic, readwrite, strong)MBProgressHUD *processHud;

@property (nonatomic, readwrite, assign)BOOL textShowing;//文字正在显示
@property (nonatomic, readwrite, assign)BOOL processShowing;//菊花正在显示

@end

@implementation YLYHelper

static YLYHelper *helper = nil;

+ (instancetype)shareHelper {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[super allocWithZone:NULL] init];
    });
    
    return helper;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self shareHelper];
}

+ (void)registerNotificationName:(NSString *)notiName object:(id)object event:(notificationBlock)block {
    [[NSNotificationCenter defaultCenter] addObserverForName:notiName
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue] /*暂时放在主线程*/ usingBlock:^(NSNotification * _Nonnull note) {
                                                           if (block != nil) {
                                                               block(note);
                                                           }
                                                       }
     ];
}

+ (void)removeNotificationName:(NSString *)notiName observer:(id)observer {
    [[NSNotificationCenter defaultCenter] removeObserver:observer
                                                    name:notiName
                                                  object:nil];
}

//自动适配Rect
+ (CGRect)autoAdjustRect:(CGRect)rect {
    CGRect retRect = CGRectMake(0, 0, 0, 0);
    CGFloat rate = [BootUnit shareUnit].rate;
    retRect = CGRectMake(rect.origin.x*rate, rect.origin.y*rate, rect.size.width*rate, rect.size.height*rate);
    return retRect;
}


//自动适配长度
+ (CGFloat)autoAdjustWidth:(CGFloat)width {
    CGFloat retFloat = 0.0f;
    retFloat = width*[BootUnit shareUnit].rate;
    return retFloat;
}

//自动适配Font
+ (UIFont *)autoAdjustFont:(CGFloat)fontFloat {
    UIFont *retFont = [UIFont systemFontOfSize:0];
    retFont = [UIFont systemFontOfSize:fontFloat*[BootUnit shareUnit].rate];
    return retFont;
}





//显示hub提示
- (void)showHudViewWithString:(NSString *)promptString {
    if (self.textShowing == YES || self.processShowing == YES) {
        return;
    }
    self.textShowing = YES;
    
    if (self.textHud == nil) {
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        self.textHud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
        [keyWindow addSubview:_textHud];
        _textHud.mode = MBProgressHUDModeText;
        _textHud.label.text = promptString;
        _textHud.margin = 10.f;
        _textHud.removeFromSuperViewOnHide = YES;
        [_textHud showAnimated:YES];
        [_textHud hideAnimated:YES afterDelay:1.0f];
    } else {
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        [keyWindow addSubview:_textHud];
        _textHud.label.text = promptString;
        [_textHud showAnimated:YES];
        [_textHud hideAnimated:YES afterDelay:1.0f];
    }
    
    SELF_WEAK();
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakSelf.textShowing = NO;
    });
}


//打开菊花
- (void)openProcessHudViewText:(NSString *)showText {
    if (self.processShowing == YES || self.textShowing == YES) {
        return;
    }
    self.processShowing = YES;
    
    if (self.processHud == nil) {
        self.processHud = [[MBProgressHUD alloc] init];
        _processHud.mode = MBProgressHUDModeAnnularDeterminate;
        _processHud.label.text = showText;
        _processHud.label.font = CONSTANT_FONT_SMALL;
        _processHud.animationType = MBProgressHUDAnimationZoomOut;
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        [keyWindow addSubview:_processHud];
    }
    showText = [NSString checkNullString:showText];
    if (showText.length == 0) {
        _processHud.label.text = @"加载中...";
    } else {
        _processHud.label.text = showText;
    }
    
    [_processHud showAnimated:YES];
}
//关闭菊花
- (void)closeProcessHudView {
    [_processHud hideAnimated:YES];
    self.processShowing = NO;
}


@end
