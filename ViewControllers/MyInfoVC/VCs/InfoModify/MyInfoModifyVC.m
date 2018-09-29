//
//  MyInfoModifyVC.m
//  Eyuemeiche
//
//  Created by yu on 18/04/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "MyInfoModifyVC.h"
#import "MyInfoConfig.h"
#import "MyInfoModifyViewModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MyInfoModifyVC () <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *tableData;
    
    NSInteger currentSexIndex;//性别选择
    
    NSArray *popData;//弹框数据
}

@property (nonatomic, readwrite, strong)UITableView *tableView;
@property (nonatomic, readwrite, strong)SexPopView *sexPopView;

@end

@implementation MyInfoModifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人信息";
    
    [self initBaseData];
    [self creatSubViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//初始化基础数据
- (void)initBaseData {
    NSArray *titleArr = @[@"头像", @"昵称", @"性别"];
    popData = @[@"男", @"女"];
    
    NSMutableArray *tmpArr = [[NSMutableArray alloc] initWithCapacity:titleArr.count];
    for (NSInteger i = 0; i < titleArr.count; i ++) {
        MyInfoModifyCellModel *model = [[MyInfoModifyCellModel alloc] init];
        model.iconImage = [NSString stringWithFormat:@"icon_%@", titleArr[i]];
        model.title = titleArr[i];
        if (i == 0) {
            model.imageURL = [UserManager shareInstanceUserInfo].userModel.headerImageURL;
        } else {
            model.imageURL = @"";
        }
        [tmpArr addObject:model];
    }
    tableData = [NSArray arrayWithArray:tmpArr];
    
    currentSexIndex = [UserManager shareInstanceUserInfo].userModel.sex.integerValue;
}

#pragma -mark 创建子视图
- (void)creatSubViews {
    self.view.backgroundColor = COLOR_VC_BG;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                  style:UITableViewStylePlain];
    _tableView.backgroundColor = COLOR_VC_BG;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[MyInfoModifyCell1 class] forCellReuseIdentifier:@"MyInfoModifyCell1"];
    [_tableView registerClass:[MyInfoModifyCell2 class] forCellReuseIdentifier:@"MyInfoModifyCell2"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-SAFETY_AREA_HEIGHT);
    }];
    
    YLYRootView *line = [[YLYRootView alloc] initWithFrame:YLY6Rect(0, 0, 375, 11)];
    line.backgroundColor = COLOR_VC_BG;
    _tableView.tableHeaderView = line;
}

#pragma -mark tableDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return FIT(73);
    } else {
        return FIT(56);
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        MyInfoModifyCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"MyInfoModifyCell1" forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[MyInfoModifyCell1 alloc] initWithStyle:UITableViewCellStyleValue2
                                            reuseIdentifier:@"MyInfoModifyCell1"];
        }
        cell.backgroundColor = COLOR_WHITE;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        MyInfoModifyCellModel *model = tableData[indexPath.row];
        
        cell.iconImage.image = [UIImage imageNamed:model.iconImage];
        cell.titleLabel.text = model.title;
        [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:model.imageURL]
                            placeholderImage:[UIImage imageNamed:@"image_默认用户头像"]
                                     options:SDWebImageRefreshCached];
        
        return cell;
    } else {
        MyInfoModifyCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"MyInfoModifyCell2" forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[MyInfoModifyCell2 alloc] initWithStyle:UITableViewCellStyleValue2
                                            reuseIdentifier:@"MyInfoModifyCell2"];
        }
        cell.backgroundColor = COLOR_WHITE;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        MyInfoModifyCellModel *model = tableData[indexPath.row];
        
        cell.iconImage.image = [UIImage imageNamed:model.iconImage];
        cell.titleLabel.text = model.title;
        
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        YLYLog(@"修改头像");
    }
    if (indexPath.row == 1) {
        YLYLog(@"修改昵称");
    }
    if (indexPath.row == 2) {
        YLYLog(@"修改性别");
        if (self.sexPopView == nil) {
            _sexPopView = [[SexPopView alloc] initWithArray:popData];
            
            SELF_WEAK();
            _sexPopView.sexPopSelectBlcok = ^(NSInteger index) {
                [weakSelf refreshPopViewCell:index];
            };
        } else {
            [_sexPopView show];
        }
        [_sexPopView pointIndex:currentSexIndex];
    }
}

//pop选择回调
- (void)refreshPopViewCell:(NSInteger)index {
    if (index < 0) {
        return;
    }
    MyInfoModifyCell2 *sexCell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    sexCell.detailLabel.text = popData[index];
    
    currentSexIndex = index;
}

- (void)dealloc {
    self.sexPopView = nil;
}

@end
