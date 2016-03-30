//
//  SharkApiModifyAddressManager.m
//  customer-ios
//
//  Created by liuweiqing on 16/1/13.
//  Copyright © 2016年 Leoc O'Cear. All rights reserved.
//

#import "SharkApiModifyAddressManager.h"

NSString * const kSharkApiModifyAddressManagerRequestPramsUserToken = @"user_token";
NSString * const kSharkApiModifyAddressManagerRequestPramsUid = @"uid";
NSString * const kSharkApiModifyAddressManagerRequestPramsServerToken = @"server_token";
NSString * const kSharkApiModifyAddressManagerRequestPramsName = @"name";
NSString * const kSharkApiModifyAddressManagerRequestPramsMobile = @"mobile";
NSString * const kSharkApiModifyAddressManagerRequestPramsAddress = @"address";
NSString * const kSharkApiModifyAddressManagerRequestPramsBuildingId = @"building_id";
NSString * const kSharkApiModifyAddressManagerRequestPramsId = @"id";

@implementation SharkApiModifyAddressManager

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
    return RTAPIManagerRequestTypePUT;
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
