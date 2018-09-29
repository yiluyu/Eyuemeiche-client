//
//  MakeOrderVC.h
//  Eyuemeiche
//
//  Created by yu on 2018/5/22.
//  Copyright © 2018 yu. All rights reserved.
//

#import "YLYRootViewController.h"

typedef NS_ENUM(NSInteger, MAKEORDER_TYPE) {
    kNormalType, //普通订单
    kReserveType //预约订单
};

@interface MakeOrderVC : YLYRootViewController

@property (nonatomic, readwrite, assign)MAKEORDER_TYPE type;

/*
 baseDict字段
 key            value           注释
 
 latitude       NSString        纬度
 longitude      NSString        经度
 address        NSString        地址名称
 
 */

@end
