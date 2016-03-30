//
//  SharkApiSubmitOrderManager.m
//  customer-ios
//
//  Created by liuweiqing on 15/12/4.
//  Copyright (c) 2015年 Leoc O'Cear. All rights reserved.
//

#import "SharkApiSubmitOrderManager.h"

NSString * const kSharkApiSubmitOrderManagerRequestPramsUserToken = @"user_token";
NSString * const kSharkApiSubmitOrderManagerRequestPramsUid = @"uid";
NSString * const kSharkApiSubmitOrderManagerRequestPramsServerToken = @"server_token";
NSString * const kSharkApiSubmitOrderManagerRequestPramsSid = @"sid";
NSString * const kSharkApiSubmitOrderManagerRequestPramsGoods = @"goods";

@implementation SharkApiSubmitOrderManager

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
    return @"api.order.submit";
}

- (NSString *)serviceType
{
    return @"kAXServiceShark";
}

- (RTAPIManagerRequestType)requestType
{
    return RTAPIManagerRequestTypePost;
}


#pragma mark --SharkAPIManagerValidator
- (BOOL)manager:(RTApiBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data
{
        return YES;
}

- (BOOL)manager:(RTApiBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data
{
    return YES;
}

@end
