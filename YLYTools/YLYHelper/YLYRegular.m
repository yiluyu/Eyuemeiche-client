//
//  YLYRegular.m
//  Eyuemeiche
//
//  Created by yu on 08/02/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "YLYRegular.h"

static YLYRegular *instance = nil;

@implementation YLYRegular

+ (instancetype)shareRegular {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[YLYRegular allocWithZone:NULL] init];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self shareRegular];
}



/*
 **          手机号验证           **
 *********************************
 @手机号以13、15、18开头，八个 \d 数字
 @param NSString mobile 手机号
 @return BOOL YES | NO
 *********************************
 */
- (BOOL)checkMobilePhone:(NSString *)mobile {
    NSString *mobileRegex = @"^0?(13[0-9]|15[0123456789]|18[0-9]|14[57]|17[0123456789])[0-9]{8}$";
    NSPredicate *mobilePre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileRegex];
    
    return [mobilePre evaluateWithObject:mobile];
}

/*
 **         固定电话验证          **
 *********************************
 @非字母，纯数字
 @param NSString telephone 电话号码
 @return BOOL YES | NO
 *********************************
 */
- (BOOL)checkTelephone:(NSString *)telephone {
    NSString *telephoneRegex = @"^(0[0-9]{2,3})+([2-9][0-9]{6,7})+(\\-[0-9]{1,4})?$";
    NSPredicate *telephonePre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telephoneRegex];
    
    return [telephonePre evaluateWithObject:telephone];
}

/*
 **           邮箱验证           **
 *********************************
 @param NSString email 电话号码
 @return BOOL YES | NO
 *********************************
 */
- (BOOL)checkEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailPre evaluateWithObject:email];
}

/*
 **          验证身份证           **
 *********************************
 @param NSString number 身份证
 @return BOOL YES | NO
 *********************************
 */
- (BOOL)checkIdentity:(NSString *)number {
    NSString *numberRegex = @"^(\\d{14}|\\d{17})(\\d[xX])$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
    
    return [numberPre evaluateWithObject:number];
}

/*
 **          是否全数字           **
 *********************************
 @param NSString number
 @return BOOL YES | NO
 *********************************
 */
- (BOOL)checkNumber:(NSString *)number {
    NSString *numberRegex = @".*[0-9]+.*";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
    
    return [numberPre evaluateWithObject:number];
}













@end
