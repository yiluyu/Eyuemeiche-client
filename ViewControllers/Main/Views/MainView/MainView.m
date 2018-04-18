//
//  MainView.m
//  Eyuemeiche
//
//  Created by yu on 26/02/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "MainView.h"
#import "MainConfig.h"

typedef NS_ENUM(NSInteger, ORDERTYPE) {
    ///现在下单
    kOrderTypeNow = 100,
    ///预约
    kOrderTypeReserve
};

@interface MainView ()
{
    ORDERTYPE orderType;//当前预约类型
}

@property (nonatomic, readwrite, strong)YLYRootView *backView;

//头部
@property (nonatomic, readwrite, strong)YLYRootView *headerBarView;
@property (nonatomic, readwrite, strong)YLYRootButton *myButton;//我的
@property (nonatomic, readwrite, strong)YLYRootButton *cityButton;//修改城市
@property (nonatomic, readwrite, strong)YLYRootButton *messageButton;//信息

//底部
@property (nonatomic, readwrite, strong)YLYRootButton *returnMyLocationBtn;//回到当前定位位置

@property (nonatomic, readwrite, strong)UIImageView *orderSwitchView;//订单类型选择
@property (nonatomic, readwrite, strong)YLYRootButton *typeLeftBtn;//现在
@property (nonatomic, readwrite, strong)YLYRootButton *typeRightBtn;//预约
@property (nonatomic, readwrite, strong)UIImageView *slideImage;//滑块

@property (nonatomic, readwrite, strong)YLYRootView *localView;//定位信息视图
@property (nonatomic, readwrite, strong)YLYRootLabel *localLabel;//显示
@property (nonatomic, readwrite, strong)YLYRootButton *searchBtn;//搜索

@property (nonatomic, readwrite, strong)YLYRootButton *bookOrderBtn;//下订单

@end

@implementation MainView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    self.backView = [[YLYRootView alloc] init];
    _backView.backgroundColor = COLOR_CLEAR;
    [self addSubview:_backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    //最下层map
    [self creatMapView];
    
    //上半部分
    [self creatHeaderBarView];
    
    //下半部分
    [self creatBottomView];

}


- (void)creatMapView {
//    self.mapView = [[MAMapView alloc] init];
//    _mainMap.backgroundColor = COLOR_CLEAR;
//    [_backView addSubview:_mainMap];
//    [_mainMap mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(0);
//    }];
}


- (void)creatHeaderBarView {
    self.headerBarView = [[YLYRootView alloc] init];
    _headerBarView.backgroundColor = COLOR_GREEN;
    [_backView addSubview:_headerBarView];
    [_headerBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(FIT(44));
        make.top.mas_equalTo(STATUEBAR_HEIGHT);
    }];
    
    
    //我的
    self.myButton = [[YLYRootButton alloc] init];
    _myButton.backgroundColor = COLOR_BLUE;
    [_headerBarView addSubview:_myButton];
    [_myButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(16));
        make.size.mas_equalTo(CGSizeMake(FIT(17), FIT(17)));
        make.centerY.mas_equalTo(_headerBarView);
    }];
    [_myButton addTarget:self
                  action:@selector(openSlideView)
        forControlEvents:UIControlEventTouchUpInside];
    
    //显示城市
    self.cityButton = [[YLYRootButton alloc] init];
    _cityButton.backgroundColor = COLOR_RED;
    [_headerBarView addSubview:_cityButton];
    [_cityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(FIT(100));
        make.height.centerX.centerY.mas_equalTo(_headerBarView);
    }];
    _cityButton.titleLabel.font = CONSTANT_FONT_BIG;
    
    //信息
    self.messageButton = [[YLYRootButton alloc] init];
    _messageButton.backgroundColor = COLOR_GRAY;
    [_headerBarView addSubview:_messageButton];
    [_messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT(-21));
        make.size.mas_equalTo(CGSizeMake(FIT(18), FIT(14)));
        make.centerY.mas_equalTo(_headerBarView);
    }];
    [_messageButton addTarget:self
                       action:@selector(enterMessage)
             forControlEvents:UIControlEventTouchUpInside];
}


- (void)creatBottomView {
    //预定
    self.bookOrderBtn = [YLYRootButton creatButtonText:@"我要洗车"
                                            titleColor:COLOR_WHITE
                                             titleFont:YLY6Font(18)
                                   backgroundImageName:nil
                                                target:self
                                                   SEL:@selector(enterOrder)];
    _bookOrderBtn.layer.cornerRadius = FIT(3);
    _bookOrderBtn.backgroundColor = [UIColor colorWithHexString:@"#00CA9D"];
    [_backView addSubview:_bookOrderBtn];
    [_bookOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(11));
        make.right.mas_equalTo(FIT(-11));
        make.height.mas_equalTo(FIT(48));
        make.bottom.mas_equalTo(-FIT(26)-SAFETY_AREA_HEIGHT);
    }];
    
    //地址
    self.localView = [[YLYRootView alloc] init];
    _localView.backgroundColor = COLOR_YELLOW;
    _localView.layer.cornerRadius = FIT(3);
    [_backView addSubview:_localView];
    [_localView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(_bookOrderBtn);
        make.bottom.mas_equalTo(_bookOrderBtn.mas_top).offset(FIT(-16));
    }];
    
    YLYRootView *dotView = [[YLYRootView alloc] init];
    dotView.backgroundColor = [UIColor colorWithHexString:@"#00CA9D"];
    dotView.layer.cornerRadius = FIT(6/2);
    [_localView addSubview:dotView];
    [dotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(FIT(22));
        make.left.mas_equalTo(FIT(17));
        make.width.height.mas_equalTo(FIT(6));
    }];
    
    self.localLabel = [YLYRootLabel creatLabelText:@"测试--点击搜索地址"
                                              font:YLY6Font(14)
                                             color:[UIColor colorWithHexString:@"#5F5D70"]];
    [_localView addSubview:_localLabel];
    [_localLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(41));
        make.top.bottom.right.mas_equalTo(0);
    }];
    
    self.searchBtn = [YLYRootButton creatButtonText:nil
                                         titleColor:nil
                                          titleFont:nil
                                backgroundImageName:nil
                                             target:self
                                                SEL:@selector(openSearch)];
    _searchBtn.backgroundColor = COLOR_CLEAR;
    [_localView addSubview:_searchBtn];
    [_searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
    }];
    
    //选择器
    self.orderSwitchView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image_订单类型背景"]];;
    _orderSwitchView.backgroundColor = COLOR_YELLOW;
    _orderSwitchView.userInteractionEnabled = YES;
    [_backView addSubview:_orderSwitchView];
    [_orderSwitchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_bookOrderBtn);
        make.bottom.mas_equalTo(_localView.mas_top).offset(FIT(-6));
        make.size.mas_equalTo(CGSizeMake(FIT(117), FIT(40)));
    }];
    self.slideImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image_订单类型滑块"]];
    _slideImage.backgroundColor = COLOR_GREEN;
    _slideImage.userInteractionEnabled = YES;
    [_orderSwitchView addSubview:_slideImage];
    [_slideImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(FIT(2));
        make.bottom.mas_equalTo(FIT(-2));
        make.right.mas_equalTo(FIT(-58));
    }];
    
    self.typeLeftBtn = [YLYRootButton creatButtonText:@"现在"
                                           titleColor:[UIColor colorWithHexString:@"#4A4A4A"]
                                            titleFont:YLY6Font(12)
                                  backgroundImageName:nil
                                               target:self
                                                  SEL:@selector(changeTypeButton:)];
    _typeLeftBtn.tag = kOrderTypeNow;
    [_orderSwitchView addSubview:_typeLeftBtn];
    [_typeLeftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(_typeLeftBtn.superview.mas_width).dividedBy(2);
    }];
    self.typeRightBtn = [YLYRootButton creatButtonText:@"预约"
                                            titleColor:[UIColor colorWithHexString:@"#9B9B9B"]
                                             titleFont:YLY6Font(12)
                                   backgroundImageName:nil
                                                target:self
                                                   SEL:@selector(changeTypeButton:)];
    _typeRightBtn.tag = kOrderTypeReserve;
    [_orderSwitchView addSubview:_typeRightBtn];
    [_typeRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(_typeRightBtn.superview.mas_width).dividedBy(2);
    }];
    
    //回到当前定位点
    self.returnMyLocationBtn = [YLYRootButton creatButtonText:nil
                                                   titleColor:nil
                                                    titleFont:nil
                                          backgroundImageName:@"回到当前定位"
                                                       target:self
                                                          SEL:@selector(backMyLocation)];
    [_backView addSubview:_returnMyLocationBtn];
    _returnMyLocationBtn.backgroundColor = COLOR_BLACK;
    [_returnMyLocationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_bookOrderBtn);
        make.bottom.mas_equalTo(_orderSwitchView.mas_top).offset(FIT(-21));
        make.size.mas_equalTo(CGSizeMake(YLY6Width(26), YLY6Width(26)));
    }];
    
    
    //数据初始化
    orderType = kOrderTypeNow;
}

#pragma -mark click
- (void)backMyLocation {
    YLYLog(@"-----未处理按钮事件 回到当前定位");
}
- (void)changeTypeButton:(YLYRootButton *)sender {
    if (orderType == sender.tag) {
        //选择是之前的按钮
        return;
    } else {
        //更换按钮
        if (sender.tag == kOrderTypeNow) {
            SELF_WEAK();
            [UIView animateWithDuration:CONSTANT_TIME_ANIMATION_SHORT
                             animations:^{
                                 [weakSelf.typeLeftBtn setTitleColor:[UIColor colorWithHexString:@"#4A4A4A"]
                                                    forState:UIControlStateNormal];
                                 [weakSelf.typeRightBtn setTitleColor:[UIColor colorWithHexString:@"#9B9B9B"]
                                                     forState:UIControlStateNormal];
                                 
                                 [weakSelf.slideImage mas_updateConstraints:^(MASConstraintMaker *make) {
                                     make.left.mas_equalTo(FIT(2));
                                     make.right.mas_equalTo(FIT(-58));
                                 }];
                                 [_orderSwitchView layoutIfNeeded];
                             }
             ];
        } else {
            SELF_WEAK();
            [UIView animateWithDuration:CONSTANT_TIME_ANIMATION_SHORT
                             animations:^{
                                 [weakSelf.typeLeftBtn setTitleColor:[UIColor colorWithHexString:@"#9B9B9B"]
                                                            forState:UIControlStateNormal];
                                 [weakSelf.typeRightBtn setTitleColor:[UIColor colorWithHexString:@"#4A4A4A"]
                                                             forState:UIControlStateNormal];
                                 
                                 [weakSelf.slideImage mas_updateConstraints:^(MASConstraintMaker *make) {
                                     make.left.mas_equalTo(FIT(63));
                                     make.right.mas_equalTo(FIT(-2));
                                 }];
                                 [_orderSwitchView layoutIfNeeded];
                             }
             ];
        }
        
        //更新状态
        orderType = sender.tag;
    }
}
//打开搜索面板
- (void)openSearch {
    YLYLog(@"-----打开搜索面板 未完成");
}


/* ---- block ---- */
- (void)openSlideView {
    if (self.myBtnBlock) {
        self.myBtnBlock();
    }
}
- (void)enterMessage {
    if (self.messageBtnBlock) {
        self.messageBtnBlock();
    }
}
- (void)enterOrder {
    if (self.callBtnBlock) {
        NSDictionary *postDict = @{@"":@""};
        self.callBtnBlock(postDict);
    }
}

@end
