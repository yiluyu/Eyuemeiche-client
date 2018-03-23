//
//  YLYNetBox.h
//  Eyuemeiche
//
//  Created by yu on 15/03/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLYNetBox : NSObject

///请求成功block
@property (nonatomic, readwrite, copy)void (^requestSuccessBlock)(NSDictionary *dic);
///请求失败block
@property (nonatomic, readwrite, copy)void (^requestFailedBlock)(NSDictionary *dic);

///请求参数字典
@property (nonatomic, readwrite, copy)NSDictionary *parameter;
///接口名
@property (nonatomic, readwrite, copy)NSString *address;
///接口tag
@property (nonatomic, readwrite, copy)NSString *urlTag;


///发送请求
- (void)sendRequest;

@end
