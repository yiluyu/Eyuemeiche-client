//
//  OrderConfirmModel.h
//  Eyuemeiche
//
//  Created by yu on 2018/6/29.
//  Copyright © 2018 yu. All rights reserved.
//

#import "YLYRootModel.h"

@interface OrderConfirmItemModel : YLYRootModel

@property (nonatomic, readwrite, copy)NSString *title;
@property (nonatomic, readwrite, copy)NSString *detail;

@end

@interface OrderConfirmModel : YLYRootModel

@property (nonatomic, readwrite, copy)NSString *payType;//付款方式 默认空 目前只有钱包支付

@property (nonatomic, readwrite, copy)NSString *couponsID;//优惠券id 默认空
@property (nonatomic, readwrite, copy)NSString *couponsString;//优惠券展示文案

@property (nonatomic, readwrite, copy)NSArray *itemsArray;//项目数组

@property (nonatomic, readwrite, copy)NSString *totalMoney;//总金额

@end
