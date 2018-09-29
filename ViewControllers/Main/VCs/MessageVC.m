//
//  MessageVC.m
//  Eyuemeiche
//
//  Created by yu on 2018/4/24.
//  Copyright © 2018 yu. All rights reserved.
//

#import "MessageVC.h"
#import "MainConfig.h"

@interface MessageVC () <UITableViewDelegate, UITableViewDataSource>
{
    CGFloat scale;
    NSArray *tableData;
}

@property (nonatomic, readwrite, strong)YLYRootView *noDataView;

@property (nonatomic, readwrite, strong)YLYRootView *backView;
@property (nonatomic, readwrite, strong)UITableView *tableView;

@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的消息";
    
    [self initBaseData];
    [self createSubViews];
    [self sendRequests];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark initData
- (void)initBaseData {
    scale = [BootUnit shareUnit].rate;
    
    tableData = nil;
    
    NSMutableArray *tmpArr = [[NSMutableArray alloc] initWithCapacity:5];
    for (NSInteger i = 0; i < 5; i ++) {
        MessageCellModel *model = [[MessageCellModel alloc] init];
        model.type = [NSString stringWithFormat:@"%ld", i%2];
        model.title = [NSString stringWithFormat:@"标题 %ld", i];
        model.detail = [NSString stringWithFormat:@"内容 %ld", i];
        model.date = [NSString stringWithFormat:@"时间 %ld", i];
        
        [tmpArr addObject:model];
    }
    
    tableData = [NSArray arrayWithArray:tmpArr];
}

#pragma -mark views
- (void)createSubViews {
    [self createNoDataView];
    [self createTableViews];
}
//table
- (void)createTableViews {
    self.backView = [[YLYRootView alloc] init];
    [self.view addSubview:_backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                  style:UITableViewStylePlain];
    _tableView.backgroundColor = COLOR_CLEAR;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[MessageCell class] forCellReuseIdentifier:@"MessageCell"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_backView addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-SAFETY_AREA_HEIGHT);
    }];
}

//无数据
- (void)createNoDataView {
    self.noDataView = [[YLYRootView alloc] init];
    [self.view addSubview:_noDataView];
    [_noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    UIImageView *noDataImage = [[UIImageView alloc] init];
    noDataImage.image = [UIImage imageNamed:@"image_noData"];
    [self.view addSubview:noDataImage];
    [noDataImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(135*scale);
        make.width.mas_equalTo(79*scale);
        make.height.mas_equalTo(91*scale);
    }];
    
    YLYRootLabel *noDataLabel = [YLYRootLabel createLabelText:@"暂无消息"
                                                         font:YLY6Font(14)
                                                        color:COLOR_HEX(@"#B5B5B5")];
    [_noDataView addSubview:noDataLabel];
    [noDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(noDataImage);
        make.height.mas_equalTo(17*scale);
        make.top.mas_equalTo(noDataImage.mas_bottom).offset(26*scale);
    }];
}

#pragma -mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FIT(90);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell"
                                                        forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleValue2
                                  reuseIdentifier:@"MessageCell"];
    }
    cell.backgroundColor = COLOR_WHITE;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MessageCellModel *model = tableData[indexPath.row];
    
    [cell refreshModel:model];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YLYLog(@"点击%ld", indexPath.row);
    MessageDetailVC *nextVC = [[MessageDetailVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

#pragma -mark 网络
- (void)sendRequests {
    YLYLog(@"未完成 ----- 发起消息盒子请求");
}

#pragma -mark method
//刷新数据
- (void)refreshData {
    
}






@end
