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
 下一个页面使用统一传参方式
 上一个页面传入的参数处理使用 preFatherModel -> 当前VCmodel
 当前页面参数处理 nowFatherModel -> nextVCmodel
 */

///前一个页面传入的参数model
@property (nonatomic, readwrite, strong)YLYRootModel *preFatherModel;
///当前页面自身model
@property (nonatomic, readwrite, strong)YLYRootModel *nowFatherModel;

@end
