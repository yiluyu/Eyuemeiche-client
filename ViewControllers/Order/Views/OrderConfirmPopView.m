//
//  OrderConfirmPopView.m
//  Eyuemeiche
//
//  Created by yu on 2018/7/2.
//  Copyright © 2018 yu. All rights reserved.
//

#import "OrderConfirmPopView.h"
#import "BootUnit.h"

@implementation OrderConfirmDescription

- (instancetype)initWithTitle:(NSString *)title detail:(NSString *)detail {
    if (self = [super init]) {
        self.titleLabel = [YLYRootLabel createLabelText:@""
                                                   font:YLY6Font(13)
                                                  color:COLOR_HEX(@"#8E8E93")];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.height.mas_equalTo(FIT(16));
            make.left.mas_equalTo(FIT(16));
        }];
        
        self.detailLabel = [YLYRootLabel createLabelText:@""
                                                    font:YLY6Font(13)
                                                   color:COLOR_BLACK];
        [self addSubview:_detailLabel];
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.height.mas_equalTo(FIT(16));
            make.left.mas_equalTo(FIT(111));
        }];
        
        YLYRootView *line = [[YLYRootView alloc] init];
        line.backgroundColor = COLOR_HEX(@"#C8C7CC");
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(FIT(16));
            make.height.mas_equalTo(1);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(self);
        }];
        
        _titleLabel.text = title;
        _detailLabel.text = detail;
    }
    return self;
}

@end

@implementation OrderConfirmItem

- (instancetype)initWithTitle:(NSString *)title detail:(NSString *)detail type:(ORDERCONFIRMITEM_TYPE)type {
    if (self = [super init]) {
        self.titleLabel = [YLYRootLabel createLabelText:@""
                                                   font:YLY6Font(13)
                                                  color:COLOR_HEX(@"#8E8E93")];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self);
            make.left.mas_equalTo(FIT(111));
        }];
        
        self.detailLabel = [YLYRootLabel createLabelText:@""
                                                    font:YLY6Font(13)
                                                   color:COLOR_HEX(@"#8E8E93")];
        [self addSubview:_detailLabel];
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.height.mas_equalTo(self);
            make.right.mas_equalTo(FIT(-16));
        }];
        
        if (type == kTotal) {
            [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(FIT(16));
                make.bottom.mas_equalTo(self);
            }];
            _titleLabel.textColor = COLOR_BLACK;
            _detailLabel.textColor = COLOR_BLACK;
            
            _detailLabel.font = YLY6Font(20);
        } else {
            [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(self);
                make.centerY.mas_equalTo(self);
            }];
        }
        
        _titleLabel.text = title;
        _detailLabel.text = detail;
    }
    return self;
}

@end

@interface OrderConfirmPopView ()
{
    OrderConfirmModel *model;
    CGFloat scale;
}

@property (nonatomic, readwrite, strong)YLYRootView *backView;//背景底色
@property (nonatomic, readwrite, strong)YLYRootView *whiteView;//白色view

@end

@implementation OrderConfirmPopView

- (instancetype)initWithModel:(OrderConfirmModel *)theModel {
    if (self = [super init]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        
        self.hidden = YES;
        self.backgroundColor = COLOR_CLEAR;
        self.alpha = 0.0f;
        
        model = theModel;
        
        [self createSubViews];
        [self show];
    }
    
    return self;
}

//子视图
- (void)createSubViews {
    scale = [BootUnit shareUnit].rate;
    
    self.backView = [[YLYRootView alloc] init];
    _backView.backgroundColor = COLOR_BLACK;
    [self addSubview:_backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    SELF_WEAK();
    _backView.viewTouchBlock = ^(YLYRootView *sender) {
        [weakSelf hide];
    };
    
    //子视图 从底部往上计算高度
    YLYRootButton *payBtn = [YLYRootButton createButtonText:@"预支付"
                                                 titleColor:COLOR_WHITE
                                                  titleFont:YLY6Font(18)
                                        backgroundImageName:nil
                                                     target:self
                                                        SEL:@selector(btnClick)];
    payBtn.backgroundColor = COLOR_HEX(@"#00CA9D");
    [self addSubview:payBtn];
    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-SAFETY_AREA_HEIGHT-5*scale);
        make.height.mas_equalTo(48*scale);
    }];
    
    self.whiteView = [[YLYRootView alloc] init];
    _whiteView.backgroundColor = COLOR_WHITE;
    [self addSubview:_whiteView];
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(payBtn.mas_top).offset(-5*scale);
    }];
    
    //总计
    OrderConfirmItem *totalItem = [[OrderConfirmItem alloc] initWithTitle:@"总计"
                                                                   detail:model.totalMoney
                                                                     type:kTotal];
    [_whiteView addSubview:totalItem];
    [totalItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_whiteView.mas_bottom).offset(-16*scale);
        make.height.mas_equalTo(23*scale);
        make.left.right.mas_equalTo(0);
    }];
    
    //item数组
    NSArray *items = model.itemsArray;
    NSMutableArray *tmpArr = [[NSMutableArray alloc] initWithCapacity:items.count];
    OrderConfirmItem *lastItem = totalItem;
    for (NSInteger i = items.count-1; i >= 0 ; i --) {
        OrderConfirmItemModel *itemModel = items[i];
        OrderConfirmItem *item = [[OrderConfirmItem alloc] initWithTitle:itemModel.title
                                                                  detail:itemModel.detail
                                                                    type:kItem];
        [_whiteView addSubview:item];
        
        CGFloat bottomHeight = -4*scale;
        if (lastItem == totalItem) {
            bottomHeight = -10*scale;
        }
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(lastItem.mas_top).offset(bottomHeight);
            make.height.mas_equalTo(16*scale);
            make.left.right.mas_equalTo(0);
        }];
        
        lastItem = item;
        [tmpArr insertObject:item atIndex:0];//每次往0插入
    }
    
    //优惠券
    OrderConfirmDescription *couponsDes = [[OrderConfirmDescription alloc] initWithTitle:@"优惠券"
                                                                                  detail:model.couponsString];
    [_whiteView addSubview:couponsDes];
    [couponsDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(lastItem.mas_top).offset(-19*scale);
        make.height.mas_equalTo(42*scale);
    }];
    
    //支付方式
    OrderConfirmDescription *payWayDes = [[OrderConfirmDescription alloc] initWithTitle:@"支付方式"
                                                                                 detail:@"钱包"];
    [_whiteView addSubview:payWayDes];
    [payWayDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(couponsDes.mas_top).offset(1);
        make.height.mas_equalTo(42*scale);
    }];
    
    //标题
    YLYRootView *cancelItem = [[YLYRootView alloc] init];
    [_whiteView addSubview:cancelItem];
    [cancelItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(44*scale);
        make.bottom.mas_equalTo(payWayDes.mas_top).offset(1);
    }];
    YLYRootButton *cancelBtn = [YLYRootButton createButtonText:@"取消"
                                                    titleColor:COLOR_HEX(@"#69B99E")
                                                     titleFont:YLY6Font(18)
                                           backgroundImageName:nil
                                                        target:self
                                                           SEL:@selector(cancelConfirm)];
    [cancelItem addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16*scale);
        make.centerY.mas_equalTo(cancelItem);
    }];
    YLYRootView *line = [[YLYRootView alloc] init];
    line.backgroundColor = COLOR_HEX(@"#C8C7CC");
    [cancelItem addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(16));
        make.height.mas_equalTo(1);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(cancelItem);
    }];
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(payBtn.mas_top).offset(-5*scale);
        make.top.mas_equalTo(cancelItem.mas_top).offset(0);
    }];
}

//取消
- (void)cancelConfirm {
    [self hide];
}

//展示
- (void)show {
    self.hidden = NO;
    
    SELF_WEAK();
    [UIView animateWithDuration:CONSTANT_TIME_ANIMATION_SHORT animations:^{
        weakSelf.alpha = 1.0f;
        weakSelf.backView.alpha = 0.3f;
    }];
}
//隐藏
- (void)hide {
    if (self.backView.alpha < 0.3f) {
        return;
    }
    
    SELF_WEAK();
    [UIView animateWithDuration:CONSTANT_TIME_ANIMATION_SHORT animations:^{
        weakSelf.alpha = 0.0f;
    } completion:^(BOOL finished) {
        weakSelf.hidden = YES;
    }];
}

//点击事件
- (void)btnClick {
    if (self.orderConfirmPopViewBlock) {
        self.orderConfirmPopViewBlock();
    }
}

@end
