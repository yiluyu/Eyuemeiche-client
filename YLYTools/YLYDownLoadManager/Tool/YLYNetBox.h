//
//  YLYNetBox.h
//  Eyuemeiche
//
//  Created by yu on 15/03/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLYNetBox : NSObject

@property (nonatomic, readonly, copy)NSString *requestName;//请求名称
@property (nonatomic, readonly, copy)NSString *requestTag;//请求 number 标记

///请求成功block
@property (nonatomic, readwrite, copy)void (^requestSuccessBlock)(NSDictionary *dic);
///其他block
@property (nonatomic, readwrite, copy)void (^requestOtherBlock)(NSDictionary *dic);
///请求失败block
@property (nonatomic, readwrite, copy)void (^requestFailedBlock)(NSDictionary *dic);
///请求中处理block
@property (nonatomic, readwrite, copy)void (^requestProcessBlock)(NSProgress *uploadProgress);

/*
 @address 接口名
 @paramDict 参数
 @tag 接口对应数字编号
 @urlName 自定义接口名字
 */
///发送请求
- (void)sendRequestWithAddress:(NSString *)address
                 parameterDict:(NSDictionary *)paramDict
                           tag:(NSString *)urlTag
                          name:(NSString *)urlName;

@end
