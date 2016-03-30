//
//  SharkApiGetBuildingListManager.m
//  customer-ios
//
//  Created by liuweiqing on 16/1/15.
//  Copyright © 2016年 Leoc O'Cear. All rights reserved.
//

#import "SharkApiGetBuildingListManager.h"

NSString * const kSharkApiGetBuildingListManagerRequestPramsAreaId = @"area_id";

@implementation SharkApiGetBuildingListManager

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
    return @"api.building.list";
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
