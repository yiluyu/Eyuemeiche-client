//
//  YLYRootViewController.h
//  TestDemo
//
//  Created by yu on 31/08/2017.
//  Copyright © 2017 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLYRootModel;

@interface YLYRootViewController : UIViewController


/*
 下一个页面使用baseDict传参
 */

///前一个页面传入的参数dict
@property (nonatomic, readwrite, strong)NSDictionary *baseDict;


@end
