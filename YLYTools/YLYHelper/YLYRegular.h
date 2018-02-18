//
//  YLYRegular.h
//  Eyuemeiche
//
//  Created by yu on 08/02/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLYRegular : NSObject

/** 获取 regular 对象 */
+ (instancetype)shareRegular;

/*
 合规格式
 */
/** 验证手机格式 */
- (BOOL)checkMobilePhone:(NSString *)mobile;

/** 验证固定电话格式 */
- (BOOL)checkTelephone:(NSString *)telephone;

/** 验证邮箱格式 */
- (BOOL)checkEmail:(NSString *)email;

/** 验证身份证格式 */
- (BOOL)checkIdentity:(NSString *)number;

/** 验证全数字格式 */
- (BOOL)checkNumber:(NSString *)number;

@end
