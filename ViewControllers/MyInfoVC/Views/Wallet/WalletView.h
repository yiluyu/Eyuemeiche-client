//
//  WalletView.h
//  Eyuemeiche
//
//  Created by 易路宇 on 2018/4/23.
//  Copyright © 2018年 yu. All rights reserved.
//

#import "YLYRootView.h"

@class YLYRootLabel;

#pragma -mark 充值item
@interface ChargeMoneyItem : YLYRootView

@property (nonatomic, readwrite, strong)YLYRootLabel *moneyLabel;//显示金额
@property (nonatomic, readwrite, strong)YLYRootLabel *desLabel;//赠送描述

///选择item
@property (nonatomic, readwrite, copy)void (^selectItemBlock)(NSInteger index);

///被选中的
- (void)beSelected;
///取消选中
- (void)cancelSelected;

@end



@interface WalletView : YLYRootView

@end
