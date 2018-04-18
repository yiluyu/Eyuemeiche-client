//
//  UserInfoModel.m
//  Eyuemeiche
//
//  Created by yu on 14/11/2017.
//  Copyright © 2017 yu. All rights reserved.
//

#import "UserInfoModel.h"
#import "YLYDefine.h"

@implementation UserInfoModel

- (void)renewUserData {
    YLYLog(@"重置userModel数据");
    self.nickName = @"未登录";
    self.phoneNumber = @"无登陆手机号";
    self.headerImageURL = @"";
    self.sex = @"男";
}

@end
