//
//  OrderConfirmPopView.h
//  Eyuemeiche
//
//  Created by yu on 2018/7/2.
//  Copyright © 2018 yu. All rights reserved.
//

#import "YLYRootView.h"
#import "MakeOrderConfig.h"

typedef NS_ENUM(NSInteger, ORDERCONFIRMITEM_TYPE) {
    kItem,
    kTotal
};

@interface OrderConfirmDescription : YLYRootView

@property (nonatomic, readwrite, strong)YLYRootLabel *titleLabel;
@property (nonatomic, readwrite, strong)YLYRootLabel *detailLabel;

- (instancetype)initWithTitle:(NSString *)title detail:(NSString *)detail;

@end

@interface OrderConfirmItem : YLYRootView

@property (nonatomic, readwrite, strong)YLYRootLabel *titleLabel;
@property (nonatomic, readwrite, strong)YLYRootLabel *detailLabel;

- (instancetype)initWithTitle:(NSString *)title detail:(NSString *)detail type:(ORDERCONFIRMITEM_TYPE)type;

@end

@interface OrderConfirmPopView : YLYRootView

///付款回调
@property (nonatomic, readwrite, copy)void (^orderConfirmPopViewBlock)(void);

///初始化
- (instancetype)initWithModel:(OrderConfirmModel *)theModel;

///展示
- (void)show;
///隐藏
- (void)hide;

@end
