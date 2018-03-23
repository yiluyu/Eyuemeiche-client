//
//  YLYDownLoadManager.m
//  TestDemo
//
//  Created by yu on 31/08/2017.
//  Copyright © 2017 yu. All rights reserved.
//

#import "YLYDownLoadManager.h"
#import "URLConfig.h"
#import <AFNetworking.h>
#import "YLYDefine.h"

@interface YLYDownLoadManager ()

@property (nonatomic, readwrite, strong)NSMutableDictionary *controllerDict;//总操作字典

@end

@implementation YLYDownLoadManager

+ (instancetype)shareDownLoadManager {
    static YLYDownLoadManager *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[super allocWithZone:NULL] init];
    });
    return shareInstance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self shareDownLoadManager];
}

- (void)postRequest:(NSString *)URLString parameters:(NSDictionary *)paramDic tagName:(NSString *)requestName {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    [manager POST:URLString
       parameters:paramDic
         progress:^(NSProgress * _Nonnull uploadProgress) {
             ;
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             YLYLog(@"%@请求成功!", requestName);
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             YLYLog(@"\nxxxxxxxxxxxxxxxxxxxxx\n%@请求失败!\n", requestName);
         }
     ];
}


#pragma -mark 通用请求
- (void)sendRequest {
    ;
}

#pragma -mark 具体请求




@end
