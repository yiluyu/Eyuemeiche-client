//
//  OrderConfirmVC.m
//  Eyuemeiche
//
//  Created by yu on 2018/6/29.
//  Copyright © 2018 yu. All rights reserved.
//

#import "OrderConfirmVC.h"
#import "MakeOrderConfig.h"
#import "MyInfoModifyView.h"
#import "OrderConfirmPopView.h"
#import "BootUnit.h"

@interface OrderConfirmVC () <UITableViewDelegate, UITableViewDataSource>
{
    CGFloat scale;
    
    NSArray *tableData;//table数组
    NSArray * discountArray;//优惠信息组数据
    
    NSArray *couponsArray;//优惠券数组
    NSInteger nowCouponsIndex;//当前优惠券下标
    
    OrderConfirmModel *payModel;//下单信息
}

@property (nonatomic, readwrite, strong)UITableView *tableView;
@property (nonatomic, readwrite, strong)MakeOrderBottomView *bottomView;

@property (nonatomic, readwrite, strong)SexPopView *couponsPopView;//优惠券弹框

@property (nonatomic, readwrite, strong)OrderConfirmPopView *confirmPopView;//付款弹框

@end

@implementation OrderConfirmVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"确认订单";
    
    scale = [BootUnit shareUnit].rate;
    
    [self initBaseData];
    [self createSubViews];
    [self sendRequests];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma -mark 数据
- (void)initBaseData {
    //优惠券下标默认选择 -1
    nowCouponsIndex = -1;
    
    //优惠组数据
    MakeOrderBaseModel *couponsModel = [[MakeOrderBaseModel alloc] init];
    couponsModel.icon = @"icon_OrderConfirmVC_优惠券";
    couponsModel.title = @"优惠券";
    couponsModel.detail = @"请选择";
    
    discountArray = @[couponsModel];
    
    tableData = @[self.baseArray, self.serviceArray, discountArray];
}

#pragma -mark 视图
- (void)createSubViews {
    [self createBottomView];
    [self createTableView];
    [self createFooterView];
}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                  style:UITableViewStyleGrouped];
    _tableView.backgroundColor = COLOR_VC_BG;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[MakeOrderContentCell class]
       forCellReuseIdentifier:@"MakeOrderContentCell"];
    [_tableView registerClass:[MakeOrderSelectCell class]
       forCellReuseIdentifier:@"MakeOrderSelectCell"];
    [_tableView registerClass:[MakeOrderBaseCell class]
       forCellReuseIdentifier:@"MakeOrderBaseCell"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(_bottomView.mas_top).offset(0);
    }];
}

- (void)createFooterView {
    YLYRootView *footerView = [[YLYRootView alloc] initWithFrame:YLY6Rect(0, 0, 375, 84)];
    footerView.backgroundColor = COLOR_CLEAR;
    
    YLYRootView *whiteView = [[YLYRootView alloc] init];
    whiteView.backgroundColor = COLOR_WHITE;
    [footerView addSubview:whiteView];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(34*scale);
    }];
    
    //按钮
    YLYRootButton *btn = [YLYRootButton createButtonText:@"免责说明"
                                              titleColor:COLOR_HEX(@"#00CA9D")
                                               titleFont:YLY6Font(14)
                                     backgroundImageName:nil
                                                  target:self
                                                     SEL:@selector(clickResponsibleText)];
    [whiteView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(300*scale);
        make.height.mas_equalTo(20*scale);
        make.centerY.mas_equalTo(whiteView);
    }];
    
    _tableView.tableFooterView = footerView;
}

- (void)createBottomView {
    self.bottomView = [[MakeOrderBottomView alloc] init];
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-SAFETY_AREA_HEIGHT);
        make.height.mas_equalTo(56*scale);
    }];
    
    SELF_WEAK();
    _bottomView.makeOrderClick = ^{
        [weakSelf popConfirmView];
    };
}

#pragma -mark tableDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return FIT(62);//设置header高度
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;//设置footer高度, 不设置则默认使用header高度
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *backView = [[UIView alloc] initWithFrame:YLY6Rect(0, 0, 750, 62)];
    backView.backgroundColor = COLOR_CLEAR;
    
    MakeOrderHeaderItem *header = [[MakeOrderHeaderItem alloc] init];
    [backView addSubview:header];
    [header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(FIT(51));
    }];
    if (section == 0) {
        header.iconImage.image = [UIImage imageNamed:@"icon_makeOrderVC_基本信息"];
        header.titleLabel.text = @"基本信息";
    }
    if (section == 1) {
        header.iconImage.image = [UIImage imageNamed:@"icon_makeOrderVC_洗车服务"];
        header.titleLabel.text = @"洗车服务";
    }
    if (section == 2) {
        header.iconImage.image = [UIImage imageNamed:@"icon_makeOrderVC_优惠信息"];
        header.titleLabel.text = @"优惠信息";
    }
    
    return backView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return tableData.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tableData[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FIT(56);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //基本信息
    if (indexPath.section == 0) {
        MakeOrderContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MakeOrderContentCell" forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[MakeOrderContentCell alloc] initWithStyle:UITableViewCellStyleValue2
                                            reuseIdentifier:@"MakeOrderContentCell"];
        }
        MakeOrderContentModel *model = [self.baseArray objectAtIndex:indexPath.row];
        [cell refreshModel:model];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    //洗车服务
    if (indexPath.section == 1) {
        MakeOrderContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MakeOrderContentCell" forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[MakeOrderContentCell alloc] initWithStyle:UITableViewCellStyleValue2
                                               reuseIdentifier:@"MakeOrderContentCell"];
        }
        MakeOrderContentModel *model = [self.serviceArray objectAtIndex:indexPath.row];
        [cell refreshModel:model];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    if (indexPath.section == 2) {
        MakeOrderBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MakeOrderBaseCell" forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[MakeOrderBaseCell alloc] initWithStyle:UITableViewCellStyleValue2
                                            reuseIdentifier:@"MakeOrderBaseCell"];
        }
        [cell showArrow:YES];
        MakeOrderBaseModel *model = [discountArray objectAtIndex:indexPath.row];
        [cell refreshModel:model];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            YLYLog(@"选择优惠券");
            if (self.couponsPopView == nil) {
                _couponsPopView = [[SexPopView alloc] initWithArray:couponsArray];
                
                SELF_WEAK();
                _couponsPopView.sexPopSelectBlcok = ^(NSInteger index) {
                    [weakSelf refreshPopViewCell:index];
                };
            } else {
                [_couponsPopView show];
            }
            [_couponsPopView pointIndex:nowCouponsIndex];
        }
    }
}

#pragma -mark 交互
//刷新状态
- (void)refreshPopViewCell:(NSInteger)index {
    if (index < 0) {
        return;
    }
    MakeOrderBaseCell *couponsCell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:2]];
    couponsCell.detailLabel.text = couponsArray[index];
    
    nowCouponsIndex = index;
}

//弹出付款层
- (void)popConfirmView {
    YLYLog(@"确认付款，弹出付款");
    if (self.confirmPopView == nil) {
        payModel = [[OrderConfirmModel alloc] init];
        payModel.payType = 0;//目前只有钱包
        payModel.couponsID = @"123";//优惠券id
        payModel.couponsString = @"优惠好多好多钱";
        payModel.totalMoney = @"333";
        NSMutableArray *tmpArr = [[NSMutableArray alloc] initWithCapacity:self.serviceArray.count];
        for (NSInteger i = 0; i < self.serviceArray.count; i ++) {
            MakeOrderContentModel *contentModel = self.serviceArray[i];
            OrderConfirmItemModel *itemModel = [[OrderConfirmItemModel alloc] init];
            itemModel.title = contentModel.title;
            itemModel.detail = contentModel.detail;
            [tmpArr addObject:itemModel];
        }
        payModel.itemsArray = [tmpArr copy];
        
        self.confirmPopView = [[OrderConfirmPopView alloc] initWithModel:payModel];
        
        SELF_WEAK();
        _confirmPopView.orderConfirmPopViewBlock = ^{
            [weakSelf payMoney];
        };
    } else {
        [_confirmPopView show];
    }
}

//免责说明
- (void)clickResponsibleText {
    YLYLog(@"免责说明");
}

#pragma -mark HTTPS
- (void)sendRequests {
    YLYLog(@"获取优惠券信息");
}

- (void)payMoney {
    YLYLog(@"付款请求");
    
}


@end
