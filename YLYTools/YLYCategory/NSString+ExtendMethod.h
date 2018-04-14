//
//  NSString+ExtendMethod.h
//  Eyuemeiche
//
//  Created by yu on 07/02/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (ExtendMethod)

///检查null字符串
+ (NSString *)checkNullString:(NSString *)inputString;

///正常格式转化货币格式
+ (NSString *)stringToMoneyFormat:(NSString *)inputString;

///货币格式转化正常格式
+ (NSString *)moneyToFloat:(NSString *)inputString;

///字符串去空格
+ (NSString *)clearSpace:(NSString *)inputString;

@end
