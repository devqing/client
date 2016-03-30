//
//  SharkApiDeleteAddressManager.m
//  customer-ios
//
//  Created by liuweiqing on 16/1/13.
//  Copyright © 2016年 Leoc O'Cear. All rights reserved.
//

#import "SharkApiDeleteAddressManager.h"

NSString * const kSharkApiDeleteAddressManagerRequestPramsUserToken = @"user_token";
NSString * const kSharkApiDeleteAddressManagerRequestPramsUid = @"uid";
NSString * const kSharkApiDeleteAddressManagerRequestPramsServerToken = @"server_token";
NSString * const kSharkApiDeleteAddressManagerRequestPramsId = @"id";

@implementation SharkApiDeleteAddressManager


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
    return @"api.address";
}

- (NSString *)serviceType
{
    return @"kAXServiceShark";
}

- (RTAPIManagerRequestType)requestType
{
    return RTAPIManagerRequestTypeDELETE;
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
