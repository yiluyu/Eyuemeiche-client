//
//  CarModifyVC.m
//  Eyuemeiche
//
//  Created by yu on 19/04/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "CarModifyVC.h"
#import "MyInfoConfig.h"
#import "CarModifyViewModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CarModifyVC () <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *tableData;
}

@property (nonatomic, readwrite, strong)UITableView *tableView;

@end

@implementation CarModifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"车辆管理";
    
    [self initBaseData];
    [self creatSubViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setBackgroundImage:[UIImage imageNamed:@"btn_添加车辆"]
                       forState:UIControlStateNormal];
    [addBtn addTarget:self
               action:@selector(addCar)
     forControlEvents:UIControlEventTouchUpInside];
    addBtn.frame = YLY6Rect(0, 0, 12, 12);
    addBtn.backgroundColor = COLOR_YELLOW;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    
    [self.navigationItem setRightBarButtonItem:rightItem];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addCar {
    AddCarVC *nextVC = [[AddCarVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)initBaseData {
    YLYLog(@"假数据 ----- 车辆管理");
    NSArray *idArr = @[@"1", @"2", @"3"];
    NSArray *brandArr = @[@"阿尔法", @"帕加尼", @"柯尼塞格"];
    NSArray *carNoArr = @[@"京A1233", @"沪A6666", @"京B7778"];
    NSArray *colorArr = @[@"蓝色", @"红色", @"黄色"];
    NSMutableArray *tmpArr = [[NSMutableArray alloc] initWithCapacity:idArr.count];
    for (NSInteger i = 0; i < idArr.count; i ++) {
        CarModifyCellModel *model = [[CarModifyCellModel alloc] init];
        model.carImage = @"none";
        model.brand = brandArr[i];
        model.carNo = carNoArr[i];
        model.color = colorArr[i];
        model.carID = idArr[i];
        
        [tmpArr addObject:model];
    }
    tableData = [NSArray arrayWithArray:tmpArr];
}

- (void)creatSubViews {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                  style:UITableViewStylePlain];
    _tableView.backgroundColor = COLOR_VC_BG;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[CarModifyCell class] forCellReuseIdentifier:@"CarModifyCell"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-SAFETY_AREA_HEIGHT);
    }];
}


#pragma -mark tableDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FIT(192/2);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CarModifyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CarModifyCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[CarModifyCell alloc] initWithStyle:UITableViewCellStyleValue2
                                    reuseIdentifier:@"CarModifyCell"];
    }
    cell.backgroundColor = COLOR_WHITE;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CarModifyCellModel *model = tableData[indexPath.row];
    
    cell.brandLabel.text = model.brand;
    cell.carNoLabel.text = model.carNo;
    cell.colorLabel.text = model.color;
    [cell.carImage sd_setImageWithURL:[NSURL URLWithString:model.carImage]
                     placeholderImage:[UIImage imageNamed:@"image_默认车辆"]
                              options:SDWebImageRefreshCached];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YLYLog(@"进入修改车辆");
}

@end
