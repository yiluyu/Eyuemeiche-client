//
//  YLYRootLabel.h
//  Eyuemeiche
//
//  Created by yu on 27/02/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLYRootLabel;

@interface YLYRootLabel : UILabel

///常规label创建
+ (YLYRootLabel *)createLabelText:(NSString *)showText font:(UIFont *)font color:(UIColor *)textColor;

@end
