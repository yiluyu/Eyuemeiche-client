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
#define BaseURLString @"https://www.eyuemeiche.com/" //正式库
#define BaseHTTPSCerPath @"server_cert" //cer证书
#define BaseHTTPSP12Path @"client_cert" //p12证书
#else
#define BaseURLString @"https://www.eyuemeiche.com/" //测试库
#define BaseHTTPSCerPath @"server_cert" //cer证书
#define BaseHTTPSP12Path @"client_cert" //p12证书
#endif


/*
 请求地址宏
 */
//获取验证码
#define kRequest_getCode @"common/sms/validate"

//登陆
#define kRequest_login @"user/basic/login"
