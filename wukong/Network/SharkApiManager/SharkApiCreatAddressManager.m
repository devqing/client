//
//  SharkApiCreatAddressManager.m
//  customer-ios
//
//  Created by liuweiqing on 16/1/13.
//  Copyright © 2016年 Leoc O'Cear. All rights reserved.
//

#import "SharkApiCreatAddressManager.h"


NSString * const kSharkApiCreatAddressManagerRequestPramsUserToken = @"user_token";
NSString * const kSharkApiCreatAddressManagerRequestPramsUid = @"uid";
NSString * const kSharkApiCreatAddressManagerRequestPramsServerToken = @"server_token";
NSString * const kSharkApiCreatAddressManagerRequestPramsName = @"name";
NSString * const kSharkApiCreatAddressManagerRequestPramsMobile = @"mobile";
NSString * const kSharkApiCreatAddressManagerRequestPramsAddress = @"address";
NSString * const kSharkApiCreatAddressManagerRequestPramsAreaId = @"area_id";
NSString * const kSharkApiCreatAddressManagerRequestPramsBuildingId = @"building_id";

@implementation SharkApiCreatAddressManager

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
    return RTAPIManagerRequestTypePost;
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
