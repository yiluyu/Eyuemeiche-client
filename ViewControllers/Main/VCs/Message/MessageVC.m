//
//  MessageVC.m
//  Eyuemeiche
//
//  Created by yu on 2018/4/24.
//  Copyright © 2018 yu. All rights reserved.
//

#import "MessageVC.h"
#import "MainConfig.h"

@interface MessageVC ()
{
    NSArray *tableData;
}
@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initBaseData];
    [self creatSubViews];
    [self sendRequests];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark initData
- (void)initBaseData {
    
}

#pragma -mark views
- (void)creatSubViews {
    [self creatTableViews];
}
//table
- (void)creatTableViews {
    
}


#pragma -mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FIT(90);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell"
                                                            forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleValue2
                                      reuseIdentifier:@"MessageCell"];
        }
        cell.backgroundColor = COLOR_WHITE;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        MessageCellModel *model = tableData[indexPath.row];
        
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
            _sexPopView = [[SexPopView alloc] init];
            
            SELF_WEAK();
            _sexPopView.sexPopSelectBlcok = ^(NSInteger index) {
                MyInfoModifyCell2 *sexCell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
                sexCell.detailLabel.text = (index == 0)?@"男":@"女";
                
                SELF_STRONG();
                strongSelf->currentSexIndex = index;
            };
        } else {
            [_sexPopView show];
        }
        [_sexPopView pointIndex:currentSexIndex];
    }
}

#pragma -mark 网络
- (void)sendRequests {
    ylylog
}

#pragma -mark method
//刷新数据
- (void)refreshData {
    
}






@end
