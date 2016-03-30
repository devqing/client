//
//  SharkApiPresubmitOrderManager.m
//  customer-ios
//
//  Created by liuweiqing on 15/12/4.
//  Copyright (c) 2015年 Leoc O'Cear. All rights reserved.
//

#import "SharkApiPresubmitOrderManager.h"

NSString * const kSharkApiPresubmitOrderManagerRequestPramsUserToken = @"user_token";
NSString * const kSharkApiPresubmitOrderManagerRequestPramsUid = @"uid";
NSString * const kSharkApiPresubmitOrderManagerRequestPramsServerToken = @"server_token";
NSString * const kSharkApiPresubmitOrderManagerRequestPramsSid = @"sid";
NSString * const kSharkApiPresubmitOrderManagerRequestPramsGoods = @"goods";

@implementation SharkApiPresubmitOrderManager

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
    return @"api.order.presubmit";
}

- (NSString *)serviceType
{
    return @"kAXServiceShark";
}

- (RTAPIManagerRequestType)requestType
{
    return RTAPIManagerRequestTypePost;
}

#pragma mark --public method
- (void)loadNextPage
{
    if (self.isLoading) {
        return;
    }
    [self loadData];
}

#pragma mark --SharkAPIManagerValidator
- (BOOL)manager:(RTApiBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data
{
    if ([data[@"flag"] isEqualToString:@"ok"]) {
        return YES;
    }
    return NO;
}

- (BOOL)manager:(RTApiBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data
{
    NSLog(@"%@",data);
    return YES;
}

@end
