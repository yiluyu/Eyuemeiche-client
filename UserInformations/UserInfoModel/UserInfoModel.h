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


/** 重置user数据 */
- (void)renewUserData;

@end
