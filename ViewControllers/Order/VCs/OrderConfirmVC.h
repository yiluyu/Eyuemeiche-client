//
//  OrderConfirmVC.h
//  Eyuemeiche
//
//  Created by yu on 2018/6/29.
//  Copyright © 2018 yu. All rights reserved.
//

#import "YLYRootViewController.h"
@class OrderConfirmModel;

@interface OrderConfirmVC : YLYRootViewController

@property (nonatomic, readwrite, copy)NSArray *baseArray;//基本信息数组
@property (nonatomic, readwrite, copy)NSArray *serviceArray;//服务信息数组


@end
