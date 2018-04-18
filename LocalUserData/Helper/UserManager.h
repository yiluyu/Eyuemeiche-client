//
//  UserManager.h
//  Eyuemeiche
//
//  Created by yu on 14/11/2017.
//  Copyright © 2017 yu. All rights reserved.
//

/*
 记录本地用户数据
 */
#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

@interface UserManager : NSObject

///获取本地userModel
@property (nonatomic, readwrite, strong)UserInfoModel *userModel;

///获取manager
+ (instancetype)shareInstanceUserInfo;

///存储user信息
- (void)saveUserData;

@end
