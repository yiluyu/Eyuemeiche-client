//
//  WalletView.m
//  Eyuemeiche
//
//  Created by 易路宇 on 2018/4/23.
//  Copyright © 2018年 yu. All rights reserved.
//

#import "WalletView.h"
#import "MyInfoConfig.h"

#pragma -mark chargeItem

@interface ChargeMoneyItem ()

@property (nonatomic, readwrite, strong)YLYRootView *bgView;//背景

@end

@implementation ChargeMoneyItem

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:(CGRect)frame]) {
        self.bgView = [[YLYRootView alloc] init];
        _bgView.layer.cornerRadius = FIT(4);
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.borderColor = COLOR_HEX(@"#50E3C2").CGColor;
        _bgView.layer.borderWidth = FIT(1);
        [self addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        
        self.moneyLabel = [YLYRootLabel creatLabelText:nil
                                                  font:YLY6Font(18)
                                                 color:COLOR_BLACK];
        [self addSubview:_moneyLabel];
        [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(FIT(10));
            make.height.mas_equalTo(FIT(18));
        }];
        
        self.desLabel = [YLYRootLabel creatLabelText:nil
                                                font:YLY6Font(10)
                                               color:COLOR_HEX(@"#949496")];
        [self addSubview:_desLabel];
        [_desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(_moneyLabel.mas_bottom).offset(FIT(6));
            make.height.mas_equalTo(FIT(12));
        }];
        
        //按钮
        YLYRootButton *btn = [YLYRootButton creatButtonText:nil
                                                 titleColor:nil
                                                  titleFont:nil
                                        backgroundImageName:nil
                                                     target:self
                                                        SEL:@selector(clicked)];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
    return self;
}

- (void)clicked {
    if (self.selectItemBlock) {
        self.selectItemBlock(self.tag);
    }
}

- (void)beSelected {
    _bgView.backgroundColor = COLOR_HEX(@"#50E3C2");
    _moneyLabel.textColor = COLOR_WHITE;
    _desLabel.textColor = COLOR_WHITE;
}

- (void)cancelSelected {
    _bgView.backgroundColor = COLOR_WHITE;
    _moneyLabel.textColor = COLOR_BLACK;
    _desLabel.textColor = COLOR_HEX(@"#949496");
}

@end



#pragma -mark view
@implementation WalletView

@end
