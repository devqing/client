//
//  SharkApiSearchAreas.m
//  customer-ios
//
//  Created by liuweiqing on 15/12/4.
//  Copyright (c) 2015年 Leoc O'Cear. All rights reserved.
//

#import "SharkApiSearchAreasManager.h"

NSString * const kSharkApiSearchAreasManagerRequestPramsName = @"name";
NSString * const kSharkApiSearchAreasManagerRequestPramsCity = @"city";

@implementation SharkApiSearchAreasManager

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
    return @"api.area";
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
