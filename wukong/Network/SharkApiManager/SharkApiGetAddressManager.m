//
//  SharkApiGetAddressManager.m
//  customer-ios
//
//  Created by liuweiqing on 16/1/13.
//  Copyright © 2016年 Leoc O'Cear. All rights reserved.
//

#import "SharkApiGetAddressManager.h"

NSString * const kSharkApiGetAddressManagerRequestPramsUserToken = @"user_token";
NSString * const kSharkApiGetAddressManagerRequestPramsUid = @"uid";
NSString * const kSharkApiGetAddressManagerRequestPramsServerToken = @"server_token";
NSString * const kSharkApiGetAddressManagerRequestPramsLimit = @"limit";
NSString * const kSharkApiGetAddressManagerRequestPramsSkip = @"skip";

@implementation SharkApiGetAddressManager

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
    return RTAPIManagerRequestTypeGet;
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
