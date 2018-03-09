//
//  URLConfig.h
//  Eyuemeiche
//
//  Created by yu on 09/03/2018.
//  Copyright © 2018 yu. All rights reserved.
//

//注掉为正式库
#define NET_TEST
#ifndef NET_TEST
#define BaseURLString @"http://119.29.192.135:10086"
#endif

//获取验证码
#define kRequest_getCode [NSString stringWithFormat:@"%@", BaseURLString];

//登陆
#define kRequest_login [NSString stringWithFormat:@"%@", BaseURLString];
