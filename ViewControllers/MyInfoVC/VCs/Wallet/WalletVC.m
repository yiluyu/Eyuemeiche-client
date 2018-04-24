//
//  WalletVC.m
//  Eyuemeiche
//
//  Created by 易路宇 on 2018/4/23.
//  Copyright © 2018年 yu. All rights reserved.
//

#import "WalletVC.h"
#import "MyInfoConfig.h"

@interface WalletVC ()
{
    WalletViewModel *vModel;//view数据
    
    NSInteger selectBtnIndex;//当前选中的btn
    NSArray *itemsArr;//充值items
}

@property (nonatomic, readwrite, strong)YLYRootView *navi;

@property (nonatomic, readwrite, strong)YLYRootView *headerView;
@property (nonatomic, readwrite, strong)YLYRootLabel *totalMoneyLabel;//总余额
@property (nonatomic, readwrite, strong)YLYRootLabel *freezeMoneyLabel;//冻结余额

@property (nonatomic, readwrite, strong)YLYRootView *mainView;

@property (nonatomic, readwrite, strong)YLYRootButton *bottomBtn;

@end

@implementation WalletVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"钱包";
    
    [self initBaseData];
    [self creatSubViews];
    [self sendRequests];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark 初始化数据
- (void)initBaseData {
    selectBtnIndex = 0;//默认选中第一个
}

#pragma -mark 创建子视图
- (void)creatSubViews {
    [self creatHeaderView];
    [self creatBottomView];
    [self creatMainView];
    
    [self creatNavigationBar];
}



- (void)creatHeaderView {
    self.headerView = [[YLYRootView alloc] init];
    [self.view addSubview:_headerView];
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(FIT(217)+STATUSBAR_HEIGHT);
    }];
    
    //背景图
    UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_wallet"]];
    [_headerView addSubview:bgImage];
    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    bgImage.backgroundColor = COLOR_GREEN;
    
    //余额描述
    YLYRootLabel *desMoney = [YLYRootLabel creatLabelText:@"账户余额（元）"
                                                     font:YLY6Font(14)
                                                    color:COLOR_WHITE];
    [_headerView addSubview:desMoney];
    [desMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(16));
        make.height.mas_equalTo(FIT(17));
        make.bottom.mas_equalTo(FIT(-127));
    }];
    desMoney.backgroundColor = COLOR_RED;
    
    //余额显示
    //总余额
    self.totalMoneyLabel = [YLYRootLabel creatLabelText:nil
                                                   font:YLY6Font(72)
                                                  color:COLOR_WHITE];
    [_headerView addSubview:_totalMoneyLabel];
    [_totalMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(desMoney);
        make.height.mas_equalTo(FIT(72));
        make.bottom.mas_equalTo(FIT(-27));
    }];
    _totalMoneyLabel.backgroundColor = COLOR_RED;
    
    //冻结余额
    YLYLog(@"冻结余额显示... 待定");
}

- (void)creatBottomView {
    self.bottomBtn = [YLYRootButton creatButtonText:@"确定"
                                         titleColor:COLOR_WHITE
                                          titleFont:YLY6Font(18)
                                backgroundImageName:nil
                                             target:self
                                                SEL:@selector(commitCharge)];
    _bottomBtn.backgroundColor = COLOR_HEX(@"#00CA9D");
    _bottomBtn.layer.cornerRadius = FIT(4);
    _bottomBtn.layer.masksToBounds = YES;
    [self.view addSubview:_bottomBtn];
    [_bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(FIT(354));
        make.height.mas_equalTo(FIT(48));
        make.bottom.mas_equalTo(FIT(-26)-SAFETY_AREA_HEIGHT);
    }];
    
    
}

- (void)creatMainView {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = COLOR_YELLOW;
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(_headerView.mas_bottom).offset(0);
        make.bottom.mas_equalTo(_bottomBtn.mas_top).offset(0);
    }];
    
    YLYRootView *backView = [[YLYRootView alloc] init];
    backView.backgroundColor = COLOR_WHITE;
    [scrollView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(FIT(375));
        make.top.mas_equalTo(_headerView.mas_bottom).offset(0);
    }];
    
    //标题
    YLYRootView *header = [[YLYRootView alloc] init];
    header.backgroundColor = COLOR_WHITE;
    [backView addSubview:header];
    [header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(FIT(51));
    }];
    //icon
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_账号充值"]];
    [header addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(16));
        make.width.height.mas_equalTo(FIT(17));
        make.centerY.mas_equalTo(header);
    }];
    //标题
    YLYRootLabel *titleLabel = [YLYRootLabel creatLabelText:@"账号充值"
                                                       font:YLY6Font(14)
                                                      color:COLOR_HEX(@"#00CA9D")];
    [header addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(icon.mas_right).offset(FIT(2));
        make.height.mas_equalTo(FIT(17));
        make.centerY.mas_equalTo(icon);
    }];
    //线
    YLYRootView *line = [[YLYRootView alloc] init];
    line.backgroundColor = COLOR_HEX(@"#F0F0F0");
    [header addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(header.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    //方块部分背景
    YLYRootView *btnsBack = [[YLYRootView alloc] init];
    btnsBack.backgroundColor = COLOR_WHITE;
    [backView addSubview:btnsBack];
    [btnsBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(header.mas_bottom).offset(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(FIT(169));
    }];
    //方块
    NSMutableArray *rowArr1 = [[NSMutableArray alloc] initWithCapacity:2];
    NSMutableArray *rowArr2 = [[NSMutableArray alloc] initWithCapacity:2];
    NSMutableArray *tmpArr = [[NSMutableArray alloc] initWithCapacity:4];
    //第一排
    for (NSInteger i = 0; i < 2; i ++) {
        ChargeMoneyItem *item = [[ChargeMoneyItem alloc] init];
        item.tag = i;
        SELF_WEAK();
        item.selectItemBlock = ^(NSInteger index) {
            [weakSelf refreshItemStatus:index];
        };
        
        [btnsBack addSubview:item];
        [rowArr1 addObject:item];
        
        [tmpArr addObject:item];
    }
    [rowArr1 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal
                         withFixedSpacing:FIT(24)
                              leadSpacing:FIT(20)
                              tailSpacing:FIT(20)];
    [rowArr1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(FIT(15));
        make.height.mas_equalTo(FIT(54));
    }];
    //第二排
    for (NSInteger j = 0; j < 2; j ++) {
        ChargeMoneyItem *item = [[ChargeMoneyItem alloc] init];
        item.tag = j+2;
        SELF_WEAK();
        item.selectItemBlock = ^(NSInteger index) {
            [weakSelf refreshItemStatus:index];
        };
        
        [btnsBack addSubview:item];
        [rowArr2 addObject:item];
        
        [tmpArr addObject:item];
    }
    [rowArr2 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal
                         withFixedSpacing:FIT(24)
                              leadSpacing:FIT(20)
                              tailSpacing:FIT(20)];
    [rowArr2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(FIT(-31));
        make.height.mas_equalTo(FIT(54));
    }];
    
    itemsArr = [NSArray arrayWithArray:tmpArr];
    
    //刷新当前选中状态
    [self refreshItemStatus:selectBtnIndex];
    
    //重置scroll高度
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(btnsBack.mas_bottom).offset(0);
    }];
    scrollView.contentSize = CGSizeMake(FIT(375), btnsBack.frame.origin.y+btnsBack.frame.size.height);
}

- (void)creatNavigationBar {
    self.navi = [[YLYRootView alloc] init];
    _navi.backgroundColor = COLOR_RED;
    [self.view addSubview:_navi];
    [_navi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(FIT(44));
        make.top.mas_equalTo(STATUSBAR_HEIGHT);
    }];
    
    //返回
    YLYRootButton *backBtn = [YLYRootButton creatButtonText:nil
                                                 titleColor:nil
                                                  titleFont:nil
                                        backgroundImageName:@"btn_back"
                                                     target:self
                                                        SEL:@selector(backVC)];
    backBtn.backgroundColor = COLOR_BLUE;
    [_navi addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(16));
        make.width.mas_equalTo(FIT(10));
        make.height.mas_equalTo(FIT(17));
        make.centerY.mas_equalTo(_navi);
    }];
    
    //title
    YLYRootLabel *titleLabel = [YLYRootLabel creatLabelText:@"钱包"
                                                       font:YLY6Font(17)
                                                      color:COLOR_WHITE];
    [_navi addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.mas_equalTo(_navi);
        make.height.mas_equalTo(FIT(17));
    }];
    
    //右侧
    YLYRootButton *detailBtn = [YLYRootButton creatButtonText:@"明细"
                                                   titleColor:COLOR_WHITE
                                                    titleFont:YLY6Font(17)
                                          backgroundImageName:nil
                                                       target:self
                                                          SEL:@selector(enterDetailVC)];
    [_navi addSubview:detailBtn];
    [detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FIT(-16));
        make.height.mas_equalTo(FIT(17));
        make.centerY.mas_equalTo(_navi);
    }];
}


#pragma -mark https请求
- (void)sendRequests {
    YLYLog(@"未完成 ----- 发起钱包详情请求");
    
    vModel = [[WalletViewModel alloc] init];
    
    [self refreshModel:vModel];
}

#pragma -mark 按钮事件
//返回
- (void)backVC {
    [self.navigationController popViewControllerAnimated:YES];
}

//进入明细
- (void)enterDetailVC {
    YLYLog(@"未完成 ----- 跳转明细");
}

//刷新item状态
- (void)refreshItemStatus:(NSInteger)index {
    ChargeMoneyItem *lastItem = itemsArr[selectBtnIndex];
    [lastItem cancelSelected];
    
    ChargeMoneyItem *nowItem = itemsArr[index];
    [nowItem beSelected];
    
    selectBtnIndex = index;
    YLYLog(@"选中 %ld", selectBtnIndex);
}

//充值
- (void)commitCharge {
    YLYLog(@"未完成 ----- 开始充值");
}


#pragma -mark 加载数据
- (void)refreshModel:(WalletViewModel *)model {
    _totalMoneyLabel.text = @"23.67";
    _freezeMoneyLabel.text = @"0";
    
    NSArray *moneyArr = @[@"¥50", @"¥100", @"¥200", @"¥500"];
    NSArray *desArr = @[@"送5元优惠券", @"送12元优惠券", @"送30元优惠券", @"送80元优惠券"];
    
    for (NSInteger i = 0; i < itemsArr.count; i ++) {
        ChargeMoneyItem *item = itemsArr[i];
        item.moneyLabel.text = moneyArr[i];
        item.desLabel.text = desArr[i];
        
        if (selectBtnIndex == i) {
            [item beSelected];
        } else {
            [item cancelSelected];
        }
    }
}

@end
