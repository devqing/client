//
//  SharkApiSubmitOrderCommentManager.m
//  customer-ios
//
//  Created by liuweiqing on 15/12/8.
//  Copyright (c) 2015年 Leoc O'Cear. All rights reserved.
//

#import "SharkApiSubmitOrderCommentManager.h"

@implementation SharkApiSubmitOrderCommentManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.validator = self;
    }
    return self;
}

- (NSString *)methodName
{
    return @"api.order.comment.submit";
}

- (NSString *)serviceType
{
    return @"kAXServiceShark";
}

- (RTAPIManagerRequestType)requestType
{
    return RTAPIManagerRequestTypePost;
}

- (BOOL)manager:(RTApiBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data
{
    return YES;
}

- (BOOL)manager:(RTApiBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data
{
    return YES;
}

@end
