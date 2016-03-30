//
//  SharkApiSearchGoodsManager.m
//  customer-ios
//
//  Created by liuweiqing on 15/12/29.
//  Copyright © 2015年 Leoc O'Cear. All rights reserved.
//

#import "SharkApiSearchGoodsManager.h"

NSString * const kSharkApiSearchGoodsManagerRequestPramsShopId = @"sid";
NSString * const kSharkApiSearchGoodsManagerRequestPramsSearchValue = @"v";

@implementation SharkApiSearchGoodsManager

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
    return @"api.search.items";
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
