//
//  MessageDetailVC.m
//  Eyuemeiche
//
//  Created by yu on 2018/5/16.
//  Copyright © 2018 yu. All rights reserved.
//

#import "MessageDetailVC.h"
#import "MainConfig.h"
#import <sys/socket.h>
#import <arpa/inet.h>

@interface MessageDetailVC ()
{
    CGFloat scale;
}

@property (nonatomic, readwrite, strong)UIScrollView *scrollView;
@property (nonatomic, readwrite, strong)YLYRootView *whiteView;

@property (nonatomic, readwrite, strong)YLYRootImageView *icon;
@property (nonatomic, readwrite, strong)YLYRootLabel *titleLabel;
@property (nonatomic, readwrite, strong)YLYRootLabel *subtitleLabel;
@property (nonatomic, readwrite, strong)YLYRootLabel *dateLabel;
@property (nonatomic, readwrite, strong)YLYRootLabel *contentLabel;

@end

@implementation MessageDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"系统消息";
    
    [self initBaseData];
    [self createSubViews];
    [self sendRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initBaseData {
    scale = [BootUnit shareUnit].rate;
}

#pragma -mark 视图
- (void)createSubViews {
    self.view.backgroundColor = COLOR_HEX(@"#F3F4F5");
    
    [self createScrollView];
    [self createWhiteView];
}

- (void)createScrollView {
    self.scrollView = [[UIScrollView alloc] init];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-SAFETY_AREA_HEIGHT);
    }];
}

- (void)createWhiteView {
    self.whiteView = [[YLYRootView alloc] init];
    _whiteView.backgroundColor = COLOR_WHITE;
    _whiteView.layer.cornerRadius = 3*scale;
    [self.view addSubview:_whiteView];
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10*scale);
        make.top.mas_equalTo(15*scale);
        make.right.mas_equalTo(-10*scale);
    }];
    
    //头像
    self.icon = [[YLYRootImageView alloc] init];
    _icon.image = [UIImage imageNamed:@"none"];
    _icon.backgroundColor = COLOR_RED;
    [_whiteView addSubview:_icon];
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10*scale);
        make.top.mas_equalTo(23*scale);
        make.width.height.mas_equalTo(50*scale);
    }];
    
    //标题
    self.titleLabel = [YLYRootLabel createLabelText:@"尊敬的车主"
                                              font:YLY6Font(16)
                                             color:COLOR_HEX(@"#444444")];
    [_whiteView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_icon.mas_right).offset(14*scale);
        make.top.mas_equalTo(23*scale);
        make.height.mas_equalTo(19*scale);
    }];
    
    //副标题
    self.subtitleLabel = [YLYRootLabel createLabelText:@"您的车已洗完"
                                                 font:YLY6Font(14)
                                                color:COLOR_HEX(@"#B5B5B5")];
    [_whiteView addSubview:_subtitleLabel];
    [_subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel);
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(9*scale);
        make.height.mas_equalTo(17*scale);
    }];
    
    //时间
    self.dateLabel = [YLYRootLabel createLabelText:@"2018-05-21"
                                             font:YLY6Font(12)
                                            color:COLOR_HEX(@"#DAD9E2")];
    [_whiteView addSubview:_dateLabel];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12*scale);
        make.top.mas_equalTo(_titleLabel);
        make.height.mas_equalTo(14*scale);
    }];
    
    //线
    YLYRootView *line = [[YLYRootView alloc] init];
    line.backgroundColor = COLOR_HEX(@"#EFEFEF");
    [_whiteView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_whiteView);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(88*scale);
    }];
    
    NSString *contentString = @"气象专家提醒,本次高温天气,湿度也明显升气象专家提醒,本次高温天气,湿度也明显升气象专家提醒,本次高温天气,湿度也明显升气象专家提醒,本次高温天气,湿度也明显升气象专家提醒,本次高温天气,湿度也明显升";
    //内容
    self.contentLabel = [YLYRootLabel createLabelText:contentString
                                                 font:YLY6Font(14)
                                                color:COLOR_HEX(@"#9B9B9B")];
    _contentLabel.numberOfLines = 0;
    _contentLabel.preferredMaxLayoutWidth = 334*scale;
    [_whiteView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_whiteView);
        make.top.mas_equalTo(line.mas_bottom).offset(23*scale);
    }];
    
    //设置whiteView高度
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_contentLabel.mas_bottom).offset(23*scale);
    }];
    //scrollView
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, _whiteView.frame.origin.y+_whiteView.frame.size.height);
}

#pragma -mark 请求
- (void)sendRequest {
    [self messageDetailRequest];
}

- (void)messageDetailRequest {
    
}

@end
