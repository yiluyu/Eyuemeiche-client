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
@property (nonatomic, readwrite, copy)NSString *sex;//性别 0男 1女
@property (nonatomic, readwrite, copy)NSString *headerImageURL;//头像URL
@property (nonatomic, readwrite, copy)NSString *token;//token

///重置user数据
- (void)renewUserData;

@end
