//
//  MyInfoViewModel.h
//  Eyuemeiche
//
//  Created by yu on 16/04/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "YLYRootModel.h"

//table头部model
@interface MyInfoHeaderModel : YLYRootModel
@property (nonatomic, readwrite, copy)NSString *nickName;//昵称
@property (nonatomic, readwrite, copy)NSString *phoneNumber;//手机号
@property (nonatomic, readwrite, copy)NSString *sex;//性别
@property (nonatomic, readwrite, copy)NSString *headerImageURL;//头像URL
@property (nonatomic, readwrite, copy)NSString *money;//余额
@property (nonatomic, readwrite, copy)NSString *coupons;//优惠券数量
@property (nonatomic, readwrite, copy)NSString *points;//积分
@end

//cellModel
@interface MyInfoCellModel : YLYRootModel

@property (nonatomic, readwrite, copy)NSString *iconImage;//图标
@property (nonatomic, readwrite, copy)NSString *title;//标题
@property (nonatomic, readwrite, copy)NSString *carCount;//车辆数量

@end

//viewModel
@interface MyInfoViewModel : YLYRootModel

@property (nonatomic, readwrite, strong)MyInfoHeaderModel *headerModel;
@property (nonatomic, readwrite, strong)NSArray *tableData;

@end
