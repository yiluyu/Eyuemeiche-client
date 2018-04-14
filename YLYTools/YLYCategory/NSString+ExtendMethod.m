//
//  NSString+ExtendMethod.m
//  Eyuemeiche
//
//  Created by yu on 07/02/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "NSString+ExtendMethod.h"

@implementation NSString (ExtendMethod)

//检查字段是否合法
+ (NSString *)checkNullString:(NSString *)inputString {
    if (![inputString isKindOfClass:[NSNull class]]
        && inputString != nil
        && inputString.length != 0
        && ![inputString isEqualToString:@"(null)"]
        && ![inputString isEqualToString:@"<null>"]
        && ![inputString isEqualToString:@"null"]) {
        return inputString;
    } else {
        return @"";
    }
}

//字符串转金钱格式
+ (NSString *)stringToMoneyFormat:(NSString *)inputString {
    inputString = [NSString checkNullString:inputString];
    if (inputString.length == 0 || [inputString floatValue] == 0) {
        return @"0.00";
    }
    
    NSString *integerPart = @"";
    NSString *decimalPart = @"";
    NSRange dotRange = [inputString rangeOfString:@"."];
    if (dotRange.location != NSNotFound) {
        integerPart = [[inputString componentsSeparatedByString:@"."] firstObject];
        decimalPart = [[inputString componentsSeparatedByString:@"."] lastObject];
        decimalPart = [decimalPart substringToIndex:2];
    } else {
        integerPart = inputString;
        decimalPart = @"00";
    }
    inputString = [NSString stringWithFormat:@"%@.%@", integerPart, decimalPart];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,###,###,##0.00;"];
//    numberFormatter.roundingMode = NSNumberFormatterRoundFloor;
//    numberFormatter.maximumFractionDigits = 2;//在小数点后2位才四舍五入
//    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSString *moneyStr = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[inputString doubleValue]]];
    return moneyStr;
}

//金钱格式转double
+ (NSString *)moneyToFloat:(NSString *)inputString {
    inputString = [NSString checkNullString:inputString];
    if ([inputString isEqualToString:@"0.00"] || inputString.length == 0 || [inputString floatValue] == 0) {
        return 0;
    }
    
    NSString *integerPart = @"";
    NSString *decimalPart = @"";
    NSRange dotRange = [inputString rangeOfString:@"."];
    if (dotRange.location != NSNotFound) {
        integerPart = [[inputString componentsSeparatedByString:@"."] firstObject];
        decimalPart = [[inputString componentsSeparatedByString:@"."] lastObject];
        decimalPart = [decimalPart substringToIndex:2];
    } else {
        integerPart = inputString;
        decimalPart = @"00";
    }
    inputString = [NSString stringWithFormat:@"%@.%@", integerPart, decimalPart];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,###,###,##0.00;"];

    NSNumber *moneyNumber = [numberFormatter numberFromString:inputString];
    return [NSString stringWithFormat:@"%.2f", [moneyNumber doubleValue]];
}

//出去空格
+ (NSString *)clearSpace:(NSString *)inputString {
    NSCharacterSet *whiteSpaceSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [inputString stringByTrimmingCharactersInSet:whiteSpaceSet];
}

@end
