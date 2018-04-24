//
//  MyInfoView.m
//  Eyuemeiche
//
//  Created by yu on 16/04/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "MyInfoView.h"
#import "MyInfoConfig.h"
#import "MyInfoViewModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UserManager.h"

#pragma -mark ----- header -----
@interface MyInfoHeader ()
{
    MyInfoHeaderModel *headerModel;
}

@property (nonatomic, readwrite, strong)UIImageView *headerImage;//头像
@property (nonatomic, readwrite, strong)YLYRootLabel *nickNameLabel;//nicheng
@property (nonatomic, readwrite, strong)YLYRootLabel *phoneLabel;//电话
@property (nonatomic, readwrite, strong)YLYRootLabel *sexLabel;//性别

@property (nonatomic, readwrite, strong)YLYRootLabel *moneyLabel;//余额
@property (nonatomic, readwrite, strong)YLYRootLabel *couponsLabel;//优惠券
@property (nonatomic, readwrite, strong)YLYRootLabel *pointsLabel;//积分

- (void)refreshModel:(MyInfoHeaderModel *)model;

@end
@implementation MyInfoHeader

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = COLOR_WHITE;
        //底色
        UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"none"]];
        backImage.backgroundColor = COLOR_GREEN;
        [self addSubview:backImage];
        [backImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(FIT(243));
        }];
        
        self.headerImage = [[UIImageView alloc] init];
        _headerImage.backgroundColor = COLOR_BLUE;
        [self addSubview:_headerImage];
        [_headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom).offset(FIT(-102-80));
            make.centerX.mas_equalTo(self);
            make.width.height.mas_equalTo(FIT(69));
        }];
        _headerImage.layer.cornerRadius = FIT(69/2);
        _headerImage.layer.masksToBounds = YES;
        _headerImage.userInteractionEnabled = YES;
        
        UIImageView *modifyIcon = [[UIImageView alloc] init];
        modifyIcon.backgroundColor = COLOR_RED;
        [self addSubview:modifyIcon];
        [modifyIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_headerImage.mas_bottom).offset(0);
            make.right.mas_equalTo(_headerImage.mas_right).offset(0);
            make.width.mas_equalTo(FIT(10));
            make.height.mas_equalTo(FIT(8));
        }];
        modifyIcon.image = [UIImage imageNamed:@"icon_modify"];
        
        self.nickNameLabel = [YLYRootLabel creatLabelText:@""
                                                     font:YLY6Font(20)
                                                    color:COLOR_WHITE];
        [self addSubview:_nickNameLabel];
        [_nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(_headerImage.mas_bottom).offset(FIT(8));
            make.height.mas_equalTo(FIT(20));
        }];
        self.phoneLabel = [YLYRootLabel creatLabelText:@""
                                                  font:YLY6Font(12)
                                                 color:COLOR_WHITE];
        [self addSubview:_phoneLabel];
        [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(FIT(115));
            make.top.mas_equalTo(_nickNameLabel.mas_bottom).offset(FIT(16));
            make.height.mas_equalTo(FIT(14));
        }];
        
        self.sexLabel = [YLYRootLabel creatLabelText:@""
                                                font:YLY6Font(12)
                                               color:COLOR_WHITE];
        [self addSubview:_sexLabel];
        [_sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(FIT(-115));
            make.centerY.mas_equalTo(_phoneLabel);
            make.height.mas_equalTo(_phoneLabel);
        }];
        
        //触发事件
        YLYRootButton *allBtn = [YLYRootButton creatButtonText:nil
                                                    titleColor:nil
                                                     titleFont:nil
                                           backgroundImageName:nil
                                                        target:self
                                                           SEL:@selector(clickHeader)];
        [_headerImage addSubview:allBtn];
        [allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        allBtn.backgroundColor = COLOR_CLEAR;
        
        //钱包
        self.moneyLabel = [YLYRootLabel creatLabelText:@"--"
                                                  font:YLY6Font(18)
                                                 color:[UIColor colorWithHexString:@"#666666"]];
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_moneyLabel];

        //优惠券
        self.couponsLabel = [YLYRootLabel creatLabelText:@"--"
                                                    font:YLY6Font(18)
                                                   color:[UIColor colorWithHexString:@"#666666"]];
        _couponsLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_couponsLabel];
        
        //积分
        self.pointsLabel = [YLYRootLabel creatLabelText:@"--"
                                                   font:YLY6Font(18)
                                                  color:[UIColor colorWithHexString:@"#666666"]];
        _pointsLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_pointsLabel];
        
        NSArray *items = @[_moneyLabel, _couponsLabel, _pointsLabel];
        [items mas_distributeViewsAlongAxis:MASAxisTypeHorizontal
                           withFixedSpacing:1
                                leadSpacing:0
                                tailSpacing:0];
        [items mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(FIT(18));
            make.top.mas_equalTo(backImage.mas_bottom).offset(FIT(24));
        }];
        
//        _moneyLabel.backgroundColor = COLOR_YELLOW;
//        _couponsLabel.backgroundColor = COLOR_BLUE;
//        _pointsLabel.backgroundColor = COLOR_RED;
        
        //分割线
        YLYRootView *line1 = [[YLYRootView alloc] init];
        line1.backgroundColor = [UIColor colorWithHexString:@"#121212"];
        line1.alpha = 0.1f;
        [self addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom).offset(FIT(-21));
            make.left.mas_equalTo(_moneyLabel.mas_right).offset(0);
            make.width.mas_equalTo(1);
            make.height.mas_equalTo(FIT(30));
        }];
        YLYRootView *line2 = [[YLYRootView alloc] init];
        line2.backgroundColor = [UIColor colorWithHexString:@"#121212"];
        line2.alpha = 0.1f;
        [self addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom).offset(FIT(-21));
            make.left.mas_equalTo(_couponsLabel.mas_right).offset(0);
            make.width.mas_equalTo(1);
            make.height.mas_equalTo(FIT(30));
        }];
        
        
        YLYRootView *block1 = [[YLYRootView alloc] init];
        [self addSubview:block1];
        [block1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom).offset(FIT(-18));
            make.width.mas_equalTo(FIT(15+24+2));
            make.height.mas_equalTo(FIT(14));
            make.centerX.mas_equalTo(_moneyLabel);
        }];
        YLYRootView *block2 = [[YLYRootView alloc] init];
        [self addSubview:block2];
        [block2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom).offset(FIT(-18));
            make.width.mas_equalTo(FIT(15+36+2));
            make.height.mas_equalTo(FIT(14));
            make.centerX.mas_equalTo(_couponsLabel);
        }];
        YLYRootView *block3 = [[YLYRootView alloc] init];
        [self addSubview:block3];
        [block3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom).offset(FIT(-18));
            make.width.mas_equalTo(FIT(16+24+2));
            make.height.mas_equalTo(FIT(14));
            make.centerX.mas_equalTo(_pointsLabel);
        }];
        
//        block1.backgroundColor = COLOR_RED;
//        block1.backgroundColor = COLOR_BLUE;
//        block3.backgroundColor = COLOR_YELLOW;
        
        //图标
        UIImageView *moneyIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_钱包"]];
        [block1 addSubview:moneyIcon];
        [moneyIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(FIT(15));
            make.height.mas_equalTo(FIT(14));
            make.centerY.mas_equalTo(block1);
        }];
        UIImageView *couponsIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_优惠券"]];
        [block2 addSubview:couponsIcon];
        [couponsIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(FIT(15));
            make.height.mas_equalTo(FIT(12));
            make.centerY.mas_equalTo(block2);
        }];
        UIImageView *pointsIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_积分"]];
        [block3 addSubview:pointsIcon];
        [pointsIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(FIT(16));
            make.height.mas_equalTo(FIT(13));
            make.centerY.mas_equalTo(block3);
        }];
        //说明
        YLYRootLabel *moneyDes = [YLYRootLabel creatLabelText:@"钱包"
                                                         font:YLY6Font(12)
                                                        color:[UIColor colorWithHexString:@"#ADADAD"]];
        [block1 addSubview:moneyDes];
        [moneyDes mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(FIT(14));
            make.centerY.mas_equalTo(block1);
        }];
        YLYRootLabel *couponsDes = [YLYRootLabel creatLabelText:@"优惠券"
                                                           font:YLY6Font(12)
                                                          color:[UIColor colorWithHexString:@"#ADADAD"]];
        [block2 addSubview:couponsDes];
        [couponsDes mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(moneyDes);
            make.centerY.mas_equalTo(block2);
        }];
        YLYRootLabel *pointsDes = [YLYRootLabel creatLabelText:@"积分"
                                                          font:YLY6Font(12)
                                                         color:[UIColor colorWithHexString:@"#ADADAD"]];
        [block3 addSubview:pointsDes];
        [pointsDes mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(moneyDes);
            make.centerY.mas_equalTo(block3);
        }];
        
        //触发按钮
        YLYRootButton *btn1 = [YLYRootButton creatButtonText:nil
                                                  titleColor:nil
                                                   titleFont:nil
                                         backgroundImageName:nil
                                                      target:self
                                                         SEL:@selector(btnClick:)];
        btn1.tag = 0;
        [self addSubview:btn1];
        [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_moneyLabel);
            make.top.mas_equalTo(_moneyLabel.mas_top).offset(0);
            make.bottom.mas_equalTo(block1.mas_bottom).offset(0);
        }];
        YLYRootButton *btn2 = [YLYRootButton creatButtonText:nil
                                                  titleColor:nil
                                                   titleFont:nil
                                         backgroundImageName:nil
                                                      target:self
                                                         SEL:@selector(btnClick:)];
        btn2.tag = 1;
        [self addSubview:btn2];
        [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_couponsLabel);
            make.top.mas_equalTo(_couponsLabel.mas_top).offset(0);
            make.bottom.mas_equalTo(block2.mas_bottom).offset(0);
        }];
        YLYRootButton *btn3 = [YLYRootButton creatButtonText:nil
                                                  titleColor:nil
                                                   titleFont:nil
                                         backgroundImageName:nil
                                                      target:self
                                                         SEL:@selector(btnClick:)];
        btn3.tag = 2;
        [self addSubview:btn3];
        [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_pointsLabel);
            make.top.mas_equalTo(_pointsLabel.mas_top).offset(0);
            make.bottom.mas_equalTo(block3.mas_bottom).offset(0);
        }];
    }
    return self;
}

- (void)refreshModel:(MyInfoHeaderModel *)model {
    headerModel = model;
    
    //头像
    [_headerImage sd_setImageWithURL:[NSURL URLWithString:headerModel.headerImageURL]
                    placeholderImage:[UIImage imageNamed:@"image_用户默认头像"]
                             options:SDWebImageRefreshCached];
    
    //昵称
    _nickNameLabel.text = headerModel.nickName;
    
    //手机号
    _phoneLabel.text = headerModel.phoneNumber;
    
    //性别
    _sexLabel.text = (headerModel.sex.integerValue == 0)?@"男":@"女";
    
    //余额
    _moneyLabel.text = [NSString stringWithFormat:@"¥%@", headerModel.money];
    
    //优惠券
    _couponsLabel.text = [NSString stringWithFormat:@"%@张", headerModel.coupons];
    
    //积分
    _pointsLabel.text = headerModel.points;
}

- (void)clickHeader {
    if (self.clickImageBlcok) {
        self.clickImageBlcok();
    }
}

- (void)btnClick:(YLYRootButton *)sender {
    if (self.clickBtnBlcok) {
        self.clickBtnBlcok(sender.tag);
    }
}

@end

#pragma -mark ----- cell -----
@interface MyInfoCell ()

@property (nonatomic, readwrite, strong)UIImageView *iconImage;//icon
@property (nonatomic, readwrite, strong)UILabel *detailLabel;//描述
@property (nonatomic, readwrite, strong)UIImageView *arrowImage;//箭头
@property (nonatomic, readwrite, strong)UILabel *moreDetailLabel;//更多描述

@end

@implementation MyInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //icon
        self.iconImage = [[UIImageView alloc] init];
        _iconImage.backgroundColor = COLOR_CLEAR;
        [self.contentView addSubview:_iconImage];
        [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(FIT(15));
            make.centerY.mas_equalTo(self.contentView);
            make.width.height.mas_equalTo(FIT(19));
        }];
        
        //信息描述
        self.detailLabel = [YLYRootLabel creatLabelText:@"项目描述"
                                                   font:YLY6Font(14)
                                                  color:[UIColor colorWithHexString:@"#666666"]];
        [self.contentView addSubview:_detailLabel];
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_iconImage.mas_right).offset(FIT(13));
            make.centerY.mas_equalTo(self.contentView);
            make.height.mas_equalTo(FIT(17));
        }];
        
        //箭头
        self.arrowImage = [[UIImageView alloc] init];
        _arrowImage.backgroundColor = COLOR_GRAY;
        [self.contentView addSubview:_arrowImage];
        self.contentView.backgroundColor = COLOR_CLEAR;
        self.backgroundColor = COLOR_CLEAR;
        [_arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(FIT(-26));
            make.centerY.mas_equalTo(self.contentView);
            make.width.mas_equalTo(FIT(5));
            make.height.mas_equalTo(FIT(8));
        }];
        _arrowImage.hidden = YES;
        
        //更多描述
        self.moreDetailLabel = [YLYRootLabel creatLabelText:@"更多描述"
                                                       font:YLY6Font(14)
                                                      color:COLOR_HEX(@"#999999")];
        [self.contentView addSubview:_moreDetailLabel];
        [_moreDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(FIT(-22));
            make.centerY.mas_equalTo(self.contentView);
            make.height.mas_equalTo(FIT(17));
        }];
        _moreDetailLabel.hidden = YES;
        
        YLYRootView *line = [[YLYRootView alloc] init];
        line.backgroundColor = COLOR_HEX(@"#F0F0F0");
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}

@end


#pragma -mark ----- view -----
@interface MyInfoView () <UITableViewDelegate, UITableViewDataSource>
{
    MyInfoViewModel *viewModel;//view数据
    NSArray *tableData;
}

@property (nonatomic, readwrite, strong)YLYRootButton *logoutBtn;//退出按钮

@end

@implementation MyInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        tableData = nil;
        viewModel = nil;
        
        [self creatHeaderView];
        [self creatBottomView];
        [self creatTableView];
    }
    return self;
}

//头部创建
- (void)creatHeaderView {
    self.headerView = [[MyInfoHeader alloc] init];
    [self addSubview:_headerView];
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(FIT(243+80));
    }];
    
    SELF_WEAK();
    _headerView.clickImageBlcok = ^{
        if (weakSelf.enterPersonalModifyBlcok) {
            weakSelf.enterPersonalModifyBlcok();
        }
    };
    
    _headerView.clickBtnBlcok = ^(NSInteger index) {
        if (index == 0 && weakSelf.clickMoneyBlcok) {
            weakSelf.clickMoneyBlcok();
        }
        if (index == 1 && weakSelf.clickCouponsBlcok) {
            weakSelf.clickCouponsBlcok();
        }
        if (index == 2 && weakSelf.clickPointsBlcok) {
            weakSelf.clickPointsBlcok();
        }
    };
}

//底部创建
- (void)creatBottomView {
    self.logoutBtn = [YLYRootButton creatButtonText:@"退出登录"
                                         titleColor:COLOR_WHITE
                                          titleFont:YLY6Font(18)
                                backgroundImageName:nil
                                             target:self
                                                SEL:@selector(logout)];
    _logoutBtn.backgroundColor = [UIColor colorWithHexString:@"#00CA9D"];
    _logoutBtn.layer.cornerRadius = FIT(4);
    _logoutBtn.layer.masksToBounds = YES;
    [self addSubview:_logoutBtn];
    [_logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(11));
        make.right.mas_equalTo(FIT(-11));
        make.height.mas_equalTo(FIT(48));
        make.bottom.mas_equalTo(FIT(-26)-SAFETY_AREA_HEIGHT);
    }];
}

//table创建
- (void)creatTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                  style:UITableViewStylePlain];
    _tableView.backgroundColor = COLOR_HEX(@"#F6F6F6");
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[MyInfoCell class] forCellReuseIdentifier:@"MyInfoCell"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(_headerView.mas_bottom).offset(0);
        make.bottom.mas_equalTo(_logoutBtn.mas_top).offset(0);
    }];
    
    YLYRootView *line = [[YLYRootView alloc] initWithFrame:YLY6Rect(0, 0, 375, 11)];
    line.backgroundColor = COLOR_HEX(@"#F6F6F6");
    _tableView.tableHeaderView = line;
}

- (void)logout {
    if (self.clickLogoutBlcok) {
        self.clickLogoutBlcok();
    }
}

//刷新 view 数据
- (void)refreshViewData:(NSDictionary *)dict {
    //封装model
    viewModel = [[MyInfoViewModel alloc] init];
    
    //处理headerModel
    MyInfoHeaderModel *hModel = [[MyInfoHeaderModel alloc] init];
    //从本地拉取用户数据
    UserInfoModel *localModel = [UserManager shareInstanceUserInfo].userModel;
    hModel.nickName = localModel.nickName;
    hModel.phoneNumber = localModel.phoneNumber;
    hModel.sex = localModel.sex;
    hModel.headerImageURL = localModel.headerImageURL;
    //其他接口数据
    YLYLog(@"写死假数据  ---------  我的详情数据");
    hModel.money = @"999";
    hModel.coupons = @"3";
    hModel.points = @"999";
    
    viewModel.headerModel = hModel;
    [_headerView refreshModel:viewModel.headerModel];
    
    //处理tableData
    NSArray *tArr = @[@"车辆管理", @"更换手机号"];//本地写死
    NSMutableArray *tmpArr = [[NSMutableArray alloc] initWithCapacity:tArr.count];
    for (NSInteger i = 0; i < tArr.count; i ++) {
        MyInfoCellModel *cellModel = [[MyInfoCellModel alloc] init];
        cellModel.iconImage = [NSString stringWithFormat:@"icon_%@", tArr[i]];
        cellModel.title = tArr[i];
        if (i == 0) {
            YLYLog(@"写死假数据  ---------  我的详情数据");
            cellModel.carCount = @"5";//测试数据
        } else {
            cellModel.carCount = @"0";//测试数据
        }
        [tmpArr addObject:cellModel];
    }
    viewModel.tableData = [NSArray arrayWithArray:tmpArr];
    tableData = viewModel.tableData;
    [_tableView reloadData];
}

#pragma -mark tableDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FIT(56);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyInfoCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[MyInfoCell alloc] initWithStyle:UITableViewCellStyleValue2
                                 reuseIdentifier:@"MyInfoCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MyInfoCellModel *model = tableData[indexPath.row];
    
    cell.iconImage.image = [UIImage imageNamed:model.iconImage];
    cell.detailLabel.text = model.title;
    if (indexPath.row == 0) {
        cell.arrowImage.hidden = YES;
        cell.moreDetailLabel.hidden = NO;
        cell.moreDetailLabel.text = [NSString stringWithFormat:@"共%@辆", model.carCount];
    } else {
        cell.arrowImage.hidden = NO;
        cell.moreDetailLabel.hidden = YES;
    }
    
    cell.backgroundColor = COLOR_WHITE;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.myInfoCellClick) {
        self.myInfoCellClick(indexPath);
    }
}


@end
