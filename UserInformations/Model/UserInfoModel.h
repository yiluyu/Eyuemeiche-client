//
//  UserInfoModel.h
//  Eyuemeiche
//
//  Created by yu on 14/11/2017.
//  Copyright © 2017 yu. All rights reserved.
//

#import "YLYRootModel.h"

@interface UserInfoModel : YLYRootModel

@property (nonatomic, readwrite, copy)NSString *nickName;//昵称
@property (nonatomic, readwrite, copy)NSString *phoneNumber;//手机号
@property (nonatomic, readwrite, copy)NSString *sex;//性别
@property (nonatomic, readwrite, copy)NSString *headerImageURL;//头像URL

/** 重置user数据 */
- (void)renewUserData;

@end