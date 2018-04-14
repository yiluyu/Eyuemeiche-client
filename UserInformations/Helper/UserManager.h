//
//  UserManager.h
//  Eyuemeiche
//
//  Created by yu on 14/11/2017.
//  Copyright © 2017 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserInfoModel;
@class UserManager;

@interface UserManager : NSObject

@property (nonatomic, readwrite, strong)UserInfoModel *userModel;


/** 获取manager */
+ (instancetype)shareInstanceUserInfo;


/** 存储user信息 */
- (void)saveUserData;


@end
