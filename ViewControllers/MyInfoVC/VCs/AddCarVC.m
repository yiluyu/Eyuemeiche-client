//
//  AddCarVC.m
//  Eyuemeiche
//
//  Created by yu on 19/04/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "AddCarVC.h"
#import "MyInfoConfig.h"
#import "AddCarModel.h"

@interface AddCarVC () <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *tableData;
}

@property (nonatomic, readwrite, strong)UITableView *tableView;

@property (nonatomic, readwrite, strong)YLYRootView *headerView;
@property (nonatomic, readwrite, strong)YLYRootLabel *desLabel;//描述文字
@property (nonatomic, readwrite, strong)YLYRootButton *addCarImageBtn;
@property (nonatomic, readwrite, strong)YLYRootLabel *btnDes;//按钮描述
@property (nonatomic, readwrite, strong)UIImageView *carImage;

@property (nonatomic, readwrite, strong)YLYRootButton *bottomBtn;

@end

@implementation AddCarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.type == kNormal) {
        self.title = @"添加车辆";
    } else {
        self.title = @"修改车辆";
    }
    
    
    [self initBaseData];
    [self creatSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initBaseData {
    NSArray *titleArr = @[@"车牌号码", @"车型", @"颜色"];
    NSMutableArray *tmpArr = [[NSMutableArray alloc] initWithCapacity:titleArr.count];
    for (NSInteger i = 0; i < titleArr.count; i ++) {
        AddCarCellModel *cellModel = [[AddCarCellModel alloc] init];
        cellModel.iconImage = [NSString stringWithFormat:@"icon_%@", titleArr[i]];
        cellModel.title = titleArr[i];
        cellModel.currentDetail = [NSString stringWithFormat:@"请填写%@", titleArr[i]];
        
        [tmpArr addObject:cellModel];
    }
    
    AddCarCellModel *cellModel = nil;
    if (self.type == kModify) {
        cellModel = tmpArr[0];
        cellModel.currentDetail = self.baseDict[@"carNo"];
        cellModel = tmpArr[1];
        cellModel.currentDetail = self.baseDict[@"brand"];
        cellModel = tmpArr[2];
        cellModel.currentDetail = self.baseDict[@"color"];
    }
    tableData = [NSMutableArray arrayWithArray:tmpArr];
}

- (void)creatSubViews {
    [self creatHeader];
    [self creatBottom];
    [self creatTable];
}

- (void)creatHeader {
    self.headerView = [[YLYRootView alloc] init];
    _headerView.backgroundColor = COLOR_VC_BG;
    [self.view addSubview:_headerView];
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(FIT(172));
    }];
    
    //描述文字
    self.desLabel = [YLYRootLabel creatLabelText:@"请完善车辆信息以方便e约美车为您服务"
                                            font:YLY6Font(14)
                                           color:COLOR_HEX(@"#666666")];
    _desLabel.textAlignment = NSTextAlignmentCenter;
    [_headerView addSubview:_desLabel];
    [_desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_headerView);
        make.top.mas_equalTo(FIT(12));
        make.height.mas_equalTo(FIT(17));
    }];
    
    //图片
    self.carImage = [[UIImageView alloc] init];
    _carImage.backgroundColor = COLOR_WHITE;
    [_headerView addSubview:_carImage];
    [_carImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(FIT(41));
        make.width.mas_equalTo(FIT(174));
        make.height.mas_equalTo(FIT(113));
        make.centerX.mas_equalTo(_headerView);
    }];
    _carImage.userInteractionEnabled = YES;
    
    //按钮
    self.addCarImageBtn = [YLYRootButton creatButtonText:nil
                                              titleColor:nil
                                               titleFont:nil
                                     backgroundImageName:@"btn_添加车辆照片"
                                                  target:self
                                                     SEL:@selector(addCarImageClick)];
    [_headerView addSubview:_addCarImageBtn];
    [_addCarImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(_carImage);
        make.width.mas_equalTo(FIT(25));
        make.height.mas_equalTo(FIT(22));
    }];
    
    //按钮描述文字
    self.btnDes = [YLYRootLabel creatLabelText:@"添加车辆照片"
                                          font:YLY6Font(10)
                                         color:COLOR_HEX(@"#5F5D70")];
    _btnDes.textAlignment = NSTextAlignmentCenter;
    [_carImage addSubview:_btnDes];
    [_btnDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_carImage);
        make.bottom.mas_equalTo(_carImage.mas_bottom).offset(FIT(-29));
        make.height.mas_equalTo(FIT(16));
    }];
}

- (void)creatBottom {
    self.bottomBtn = [YLYRootButton creatButtonText:@"添加车辆"
                                         titleColor:COLOR_WHITE
                                          titleFont:YLY6Font(18)
                                backgroundImageName:@"none"
                                             target:self
                                                SEL:@selector(addCarClick)];
    _bottomBtn.backgroundColor = COLOR_HEX(@"#00CA9D");
    _bottomBtn.layer.cornerRadius = FIT(4);
    _bottomBtn.layer.masksToBounds = YES;
    [self.view addSubview:_bottomBtn];
    [_bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FIT(10));
        make.right.mas_equalTo(FIT(-10));
        make.bottom.mas_equalTo(FIT(-17)-SAFETY_AREA_HEIGHT);
        make.height.mas_equalTo(FIT(48));
    }];
}

- (void)creatTable {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                  style:UITableViewStylePlain];
    _tableView.backgroundColor = COLOR_VC_BG;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[AddCarCell class] forCellReuseIdentifier:@"AddCarCell"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_headerView.mas_bottom).offset(0);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(_bottomBtn.mas_top).offset(0);
    }];
}

#pragma -mark tableDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FIT(56);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddCarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddCarCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[AddCarCell alloc] initWithStyle:UITableViewCellStyleValue2
                                 reuseIdentifier:@"AddCarCell"];
    }
    cell.backgroundColor = COLOR_WHITE;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    test
    AddCarCellModel *model = tableData[indexPath.row];
    
    cell.iconImage.image = [UIImage imageNamed:model.iconImage];
    cell.titleLabel.text = model.title;
    cell.currentLabel.text = model.currentDetail;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        YLYLog(@"未完成 ----- 进入填写车牌号码页");
    }
    if (indexPath.row == 1) {
        YLYLog(@"未完成 ----- 进入填写车型页");
    }
    if (indexPath.row == 2) {
        YLYLog(@"未完成 ----- 进入填写颜色页");
    }
}

#pragma -mark method
- (void)addCarClick {
    YLYLog(@"未完成 ------- 发起添加车辆请求");
    [self requestCommit];
}

//添加图片
- (void)addCarImageClick {
    YLYLog(@"未完成 ----- 添加车辆图片");
}


#pragma -mark https
//提交
- (void)requestCommit {
    YLYLog(@"未完成 ------ 添加请求");
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end