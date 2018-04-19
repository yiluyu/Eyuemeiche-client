//
//  MyInfoView.h
//  Eyuemeiche
//
//  Created by yu on 16/04/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "YLYRootView.h"
#import "YLYRootCell.h"

/* ----- header ----- */
@interface MyInfoHeader : YLYRootView

///点击头像
@property (nonatomic, readwrite, copy)void (^clickImageBlcok)(void);

@end
/* ----- cell ----- */
@interface MyInfoCell : YLYRootCell

@end

/* ----- view ----- */
@interface MyInfoView : YLYRootView

@property (nonatomic, readwrite, strong)MyInfoHeader *headerView;//头部
@property (nonatomic, readwrite, strong)UITableView *tableView;//列表

///进入修改个人资料页
@property (nonatomic, readwrite, copy)void (^enterPersonalModifyBlcok)(void);
///cell选择
@property (nonatomic, readwrite, copy)void (^myInfoCellClick)(NSIndexPath *indexPath);
///退出登录
@property (nonatomic, readwrite, copy)void (^clickLogoutBlcok)(void);


///传入数据
- (void)refreshViewData:(NSDictionary *)dict;

@end
